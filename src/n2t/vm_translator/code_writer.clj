(ns n2t.vm-translator.code-writer
  "Takes 'parsed' vm files and writes them out. most of this logic should
  be refactored and moved into the parser before i move on to the next
  week."
  (:require [clojure.string]
            [clojure.core.match :refer [match]]
            [n2t.util :as util]))

;; symbol | address | description
;; ------------------------------------------------------------------
;;  SP    |    0    | stack pointer: next topmost location in stack
;;  LCL   |    1    | base of current local segment
;;  ARG   |    2    | base of current argument segment
;;  THIS  |    3    | base of current this segment (within the heap)
;;  THAT  |    4    | base of current this segment (within the heap)
;;        |   5-12  | temp segment
;;        |  13-15  | general purpose registers

;; ---------------------------------------------------------- constant

;; push constant n
;; ---------------
;; @[n]
;; D=A
;; @SP
;; A=M
;; M=D
;; @SP
;; M=M+1

(defn access-constant
  [n]
  [(str "@" n)])

(defn read-constant
  [n]
  (concat (access-constant n)
          ["D=A"]))

;; --------------------------------------------------- dynamic segment

;; push [local, argument, this, that] n
;; ------------------------------------
;; @[n]
;; D=A
;; @[LCL, ARG, THIS, THAT]
;; A=M+D
;; ------------------------------------
;; D=M
;; ------------------------------------
;; @SP
;; A=M
;; M=D
;; @SP
;; M=M+1

(def vm-dseg->asm-dseg
  {"local"    "LCL"
   "argument" "ARG"
   "this"     "THIS"
   "that"     "THAT"})

(defn access-dynamic-segment
  [dseg n]
  [(str "@" n)
   "D=A"
   (->> dseg 
        (get vm-dseg->asm-dseg) 
        (str "@"))
   "A=M+D"])

(defn read-dynamic-segment
  [dseg n]
  (concat (access-dynamic-segment dseg n)
          ["D=M"]))

(defn pop-dseg
  [dseg n]
  [(str "@" n)
   "D=A"
   (->> dseg
        (get vm-dseg->asm-dseg)
        (str "@"))
   "D=M+D"
   "@R13"
   "M=D"
   "@SP"
   "M=M-1"
   "A=M"
   "D=M"
   "@R13"
   "A=M"
   "M=D"])

;; ----------------------------------------------------- fixed segment

;; push [pointer, temp] n
;; ----------------------
;; @[(pointer, temp) + n]
;; D=M
;; ----------------------
;; @SP
;; A=M
;; M=D
;; @SP
;; M=M+1

(def vm-fseg->asm-base
  {"pointer" 3
   "temp"    5})

(defn access-fixed-segment
  [fseg n]
  [(->> fseg
        (get vm-fseg->asm-base)
        (+ (read-string n))
        (str "@"))])

(defn read-fixed-segment
  [fseg n]
  (concat (access-fixed-segment fseg n)
          ["D=M"]))

(defn write-fixed-segment
  [fseg n]
  (concat (access-fixed-segment fseg n)
          ["M=D"]))

;; ------------------------------------------------------------ static

;; push static n
;; -------------
;; @[filename].n
;; D=M
;; -------------
;; @SP
;; A=M
;; M=D
;; @SP
;; M=M+1

(defn access-static
  [filename n]
  [(str "@" filename "." n)])

(defn read-static
  [filename n]
  (concat (access-static filename n)
          ["D=M"]))

(defn write-static
  [filename n]
  (concat (access-static filename n)
          ["M=D"]))

;; ------------------------------------------------------------- stack

(def push-stack
  ["@SP"
   "A=M"
   "M=D"
   "@SP"
   "M=M+1"])

(def pop-stack
  ["@SP"
   "M=M-1"
   "A=M"
   "D=M"])

(defn write-push-pop
  [{segment :arg1 index :arg2 filename :filename command :command}]
  (match [command segment]
    [:command/push "constant"] 
    (concat (read-constant index) push-stack)
    
    [:command/push (:or "local" "argument" "this" "that")]
    (concat (read-dynamic-segment segment index) push-stack)
    [:command/pop (:or "local" "argument" "this" "that")]
    (pop-dseg segment index)

    [:command/push (:or "pointer" "temp")]
    (concat (read-fixed-segment segment index) push-stack)
    [:command/pop (:or "pointer" "temp")]
    (concat pop-stack (write-fixed-segment segment index))

    [:command/push "static"]
    (concat (read-static filename index) push-stack)
    [:command/pop "static"]
    (concat pop-stack (write-static filename index))))

;; -------------------------------------------------------- arithmetic

(def add-sub-and-or-base
  ["@SP"
   "M=M-1"
   "A=M"
   "D=M"
   "A=A-1"])

(defn mth-add 
  [_]
  (concat add-sub-and-or-base
          ["M=M+D"]))

(defn mth-sub 
  [_]
  (concat add-sub-and-or-base
          ["M=M-D"]))

(defn mth-and
  [_]
  (concat add-sub-and-or-base
          ["M=M&D"]))

(defn mth-or
  [_]
  (concat add-sub-and-or-base
          ["M=M|D"]))

(defn mth-neg
  [_]
  ["@SP"
   "A=M-1"
   "M=-M"])

(defn mth-not
  [_]
  ["@SP"
   "A=M-1"
   "M=!M"])

;; -------------------------------------------------------- comparison

(defn comparison-base
  [key]
  [(str "(TRUE_" key ")")
   "@SP"
   "A=M-1"
   "M=-1"
   (str "@CONTINUE_" key)
   "0;JMP"
   (str "(FALSE_" key ")")
   "@SP"
   "A=M-1"
   "M=0"
   (str "@CONTINUE_" key)
   "0;JMP"
   (str "(CONTINUE_" key ")")])

(defn comparison 
  [jump {key :line-no}]
  (concat
   ["@SP"
    "M=M-1"
    "A=M"
    "D=M"
    "A=A-1"
    "D=M-D"
    (str "@TRUE_" key)
    (str "D;" jump)
    (str "@FALSE_" key)
    "0;JMP"]
   (comparison-base key)))

(def mth-eq (partial comparison "JEQ"))
(def mth-gt (partial comparison "JGT"))
(def mth-lt (partial comparison "JLT"))

(def vm-math->asm-math
  {:command/add mth-add
   :command/sub mth-sub
   :command/eq mth-eq
   :command/lt mth-lt
   :command/gt mth-gt
   :command/neg mth-neg
   :command/and mth-and
   :command/or mth-or
   :command/not mth-not})

(defn write-arithmetic
  [command]
  ((get vm-math->asm-math (:command command))
   command))

(def command-type->writer
  {:command-type/push write-push-pop
   :command-type/pop  write-push-pop
   :command-type/arithmetic  write-arithmetic})

(defn write
  [{:keys [command-type input-string] :as command}]
  (let [write-fn (get command-type->writer command-type)]
    (concat
     [(str "// " input-string)]
     (write-fn command))))

