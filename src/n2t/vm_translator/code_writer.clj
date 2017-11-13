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

(defn at
  ([x] (str "@" x))
  ([base x] (str "@" base "$" x)))

(defn lbl
  ([x] (str "(" x ")"))
  ([base x] (str "(" base "$" x ")")))

;; goto constant n
;; ---------------
;; @[n]

(defn push-constant
  [n]
  (concat [(at n)
           "D=A"]
          push-stack))

;; goto [local, argument, this, that] n
;; ------------------------------------
;; @[n]
;; D=A
;; @[LCL, ARG, THIS, THAT]
;; A=M+D

(def dynamic-label
  {:local    "LCL"
   :argument "ARG"
   :this     "THIS"
   :that     "THAT"})

(defn goto-dynamic
  [segment offset]
  [(at offset)
   "D=A"
   (at (segment dynamic-label))
   "A=M+D"])

(defn push-dynamic
  [segment offset]
  (concat (goto-dynamic segment offset)
          ["D=M"]
          push-stack))

(defn pop-dynamic
  [segment offset]
  (concat (goto-dynamic segment offset)
          ["D=A"
           "@R13"
           "M=D"]
          pop-stack
          ["@R13"
           "A=M"
           "M=D"]))

;; goto [pointer, temp] n
;; ----------------------
;; @[(pointer, temp) + n]

(def fixed-index
  {:pointer 3
   :temp    5})

(defn goto-fixed
  [segment offset]
  [(at (+ (segment fixed-index) offset))])

(defn push-fixed
  [segment offset]
  (concat (goto-fixed segment offset)
          ["D=M"]
          push-stack))

(defn pop-fixed
  [segment offset]
  (concat pop-stack
          (goto-fixed segment offset)
          ["M=D"]))

;; ------------------------------------------------------------ static

;; goto static n
;; -------------
;; @[filename].[n]

(defn goto-static
  [base index]
  [(at (str base "." index))])

(defn push-static
  [base index]
  (concat (goto-static base index)
          ["D=M"]
          push-stack))

(defn pop-static
  [base index]
  (concat pop-stack
          (goto-static base index)
          ["M=D"]))

;; -------------------------------------------------------- arithmetic

(def bitwise-base
  ["@SP"
   "M=M-1"
   "A=M"
   "D=M"
   "A=A-1"])

(def unary-base
  ["@SP"
   "A=M-1"])

(def simple-arithmetic-bases
  {:bitwise bitwise-base
   :unary   unary-base})

(def bitwise-ops
  {:add "M+D"
   :sub "M-D"
   :and "M&D"
   :or  "M|D"})

(def unary-ops
  {:neg "-M"
   :not "!M"})

(def simple-arithmetic-ops
  {:bitwise bitwise-ops
   :unary   unary-ops})

(defn arithmetic-simple
  [[base op]]
  (conj (get simple-arithmetic-bases base)
        (str "M=" (get-in simple-arithmetic-ops [base op]))))

(defn comparison-branch
  [branch-key]
  [(str "(TRUE_" branch-key ")")
   "@SP"
   "A=M-1"
   "M=-1"
   (str "@CONTINUE_" branch-key)
   "0;JMP"
   (str "(FALSE_" branch-key ")")
   "@SP"
   "A=M-1"
   "M=0"
   (str "@CONTINUE_" branch-key)
   "0;JMP"
   (str "(CONTINUE_" branch-key ")")])

(def comparison-jump-instructions
  {:eq "JEQ"
   :gt "JGT"
   :lt "JLT"})

(defn arithmetic-comparison
  [line-no op]
  (concat
   ["@SP"
    "AM=M-1"
    "D=M"
    "A=A-1"
    "D=M-D"
    (str "@TRUE_" line-no)
    (str "D;" (get comparison-jump-instructions op))
    (str "@FALSE_" line-no)
    "0;JMP"]
   (comparison-branch line-no)))

(defn label-declaration
  [base label]
  [(lbl base label)])

(defn goto
  [base label]
  [(at base label)
   "0;JMP"])

(defn if-goto
  [base label]
  ["@SP"
   "AM=M-1"
   "D=M"
   (at base label)
   "D;JNE"])

(defn fn-declaration
  [fn-name num-locals]
  (->> (push-constant 0)
       (repeat num-locals)
       (apply concat)
       (concat [(lbl fn-name)])))

(defn fn-return
  []
  ["@LCL"   ;; set R13 to frame ...
   "D=M"
   "@R13"
   "M=D"
   "@5"     ;; set R14 to return address *(frame - 5) ...
   "D=A"
   "@LCL"
   "A=M-D"
   "D=M"
   "@R14"
   "M=D"
   "@SP"    ;; set return value for caller (replace arg0 with top of stack) ...
   "A=M-1"
   "D=M"
   "@ARG"   
   "A=M"
   "M=D"
   "D=A"    ;; set SP for caller (arg0 + 1) ...
   "@SP"
   "M=D+1"
   "@R13"   ;; reset THAT ...
   "AM=M-1"
   "D=M"
   "@THAT"
   "M=D"    
   "@R13"   ;; reset THIS ...
   "AM=M-1"
   "D=M"
   "@THIS"
   "M=D"
   "@R13"   ;; reset ARG ...
   "AM=M-1"
   "D=M"
   "@ARG"
   "M=D"
   "@R13"   ;; reset LCL ...
   "AM=M-1"
   "D=M"
   "@LCL"
   "M=D"
   "@R14"   ;; go to return address ...
   "A=M"
   "0;JMP"])

(defn fn-call
  [base line-no fn-name num-args]
  (concat
   [(at base line-no)      ;; 1. push return address
    "D=A"]
   push-stack
   ["@LCL"                 ;; 2. push LCL
    "D=M"]
   push-stack
   ["@ARG"                 ;; 3. push ARG
    "D=M"]
   push-stack
   ["@THIS"                ;; 4. push THIS
    "D=M"]
   push-stack
   ["@THAT"                ;; 5. push THAT
    "D=M"]
   push-stack              ;; set new ARG (SP - 5 - num-args)
   [(at num-args)
    "D=A"
    "@5"
    "D=A+D"
    "@SP"
    "D=M-D"
    "@ARG"
    "M=D"
    "@SP"                  ;; set new LCL
    "D=M"
    "@LCL"
    "M=D"
    (at fn-name)           ;; go to fn
    "0;JMP"
    (lbl base line-no)]))  ;; return address

(defn write
  [base line-no command]
  (match command    
    [:arithmetic {:instruction (([(:or :bitwise :unary) _] :seq) :as instruction)}]
    (arithmetic-simple instruction)

    [:arithmetic {:instruction [:comparison op]}]
    (arithmetic-comparison line-no op)

    [:memory {:instruction :push :segment [:constant _] :index n}]
    (push-constant n)

    [:memory {:instruction :push :segment [:static _] :index index}]
    (push-static base index)

    [:memory {:instruction :pop :segment [:static _] :index index}]
    (pop-static base index)

    [:memory {:instruction :push :segment [:dynamic segment] :index offset}]
    (push-dynamic segment offset)

    [:memory {:instruction :pop :segment [:dynamic segment] :index offset}]
    (pop-dynamic segment offset)

    [:memory {:instruction :push :segment [:fixed segment] :index offset}]
    (push-fixed segment offset)

    [:memory {:instruction :pop :segment [:fixed segment] :index offset}]
    (pop-fixed segment offset)

    [:program-flow {:instruction :label :label label}]
    (label-declaration base label)

    [:program-flow {:instruction :goto :label label}]
    (goto base label)

    [:program-flow {:instruction :if-goto :label label}]
    (if-goto base label)

    [:function {:fn-name fn-name :num-locals num-locals}]
    (fn-declaration fn-name num-locals)

    [:call {:fn-name fn-name :num-args num-args}]
    (fn-call base line-no fn-name num-args)

    [:return _]
    (fn-return)))

(defn bootstrap
  []
  (concat
   ["@256"
    "D=A"
    "@SP"
    "M=D"]
   (fn-call "PROGRAM_ROOT" 0 "Sys.init" 0)))
