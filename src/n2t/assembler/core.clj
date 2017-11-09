(ns n2t.assembler.core
  (:require [clojure.string :as s]
            [n2t.util :as util])
  (:refer-clojure :exclude [compile]))

(def program-names
  ["Add" "Max" "Pong" "Rect"])

(def source-filenames
  (mapv
   #(str "resources/assembler/asm/" % ".asm")
   program-names))

(def output-filenames
  (mapv
   #(str "resources/assembler/output/" % ".hack")
   program-names))

(def test-filenames
  (mapv
   #(str "resources/assembler/expected/" % ".hack")
   program-names))

(def comp-table
  {"0"    "101010"
   "1"    "111111"
   "-1"   "111010"
   "D"    "001100"
   "A"    "110000"
   "M"    "110000"
   "!D"   "001101"
   "!A"   "110001"
   "!M"   "110001"
   "-D"   "001111"
   "-A"   "110011"
   "-M"   "110011"
   "D+1"  "011111"
   "A+1"  "110111"
   "M+1"  "110111"
   "D-1"  "001110"
   "A-1"  "110010"
   "M-1"  "110010"
   "D+A"  "000010"
   "D+M"  "000010"
   "D-A"  "010011"
   "D-M"  "010011"
   "A-D"  "000111"
   "M-D"  "000111"
   "D&A"  "000000"
   "D&M"  "000000"
   "D|A"  "010101" 
   "D|M"  "010101"})

(def dest-table
  {""    "000"
   "M"   "001"
   "D"   "010"
   "MD"  "011"
   "A"   "100"
   "AM"  "101"
   "AD"  "110"
   "AMD" "111"})

(def jump-table
  {""    "000"
   "JGT" "001"
   "JEQ" "010"
   "JGE" "011"
   "JLT" "100"
   "JNE" "101"
   "JLE" "110"
   "JMP" "111"})

(def builtins
  {"SP"     "000000000000000"
   "LCL"    "000000000000001"
   "ARG"    "000000000000010"
   "THIS"   "000000000000011"
   "THAT"   "000000000000100"
   "R0"     "000000000000000"
   "R1"     "000000000000001"
   "R2"     "000000000000010"
   "R3"     "000000000000011"
   "R4"     "000000000000100"
   "R5"     "000000000000101"
   "R6"     "000000000000110"
   "R7"     "000000000000111"
   "R8"     "000000000001000"
   "R9"     "000000000001001"
   "R10"    "000000000001010"
   "R11"    "000000000001011"
   "R12"    "000000000001100"
   "R13"    "000000000001101"
   "R14"    "000000000001110"
   "R15"    "000000000001111"
   "SCREEN" "100000000000000"
   "KBD"    "110000000000000"})

(def symbols
  (atom {}))

(def prev-variable
  (atom 15))

(def symbols-found
  (atom 0))

(defn get-variable
  [var]
  (if-let [addr (get @symbols var)]
    addr
    (swap! prev-variable
           (fn [prev-addr]
             (let [addr (inc prev-addr)]
               (swap! symbols assoc var addr)
               addr)))))

(def symbol-declaration-rx
  #"^\((?<sym>[a-zA-Z]+[a-zA-Z0-9_\.\$:]*)\)$")

(def constant-rx
  #"^@(?<const>[0-9]+)$")

(def a-instruction-rx
  #"^@(?<var>[a-zA-Z]+[a-zA-Z0-9_\.\$:]*)$")

(def c-instruction-rx
  #"^((?<dest>[ADM]+)=)?(?<comp>[01ADM!&\|\-\+]+)(;(?<jump>\w+))?$")

(defn replace-symbols
  [file]
  (->> file
       (map-indexed
        (fn [idx line]
          (let [declaration? (re-matcher symbol-declaration-rx line)]
            (if (.matches declaration?)
              (let [addr (- idx @symbols-found)]
                (swap! symbols-found inc)
                (swap! symbols assoc (.group declaration? "sym") addr)
                nil)
              line))))
       (remove nil?)
       (vec)))

(defn binary-string
  [n]
  (let [bin (. Integer toString n 2)
        zeros (apply str (repeat (- 15 (.length bin)) "0"))]
    (str zeros bin)))

(defn parse-c-instruction
  [{:keys [dest comp jump]}]
  (str "111"
       (if (s/includes? comp "M") "1" "0")
       (get comp-table comp)
       (get dest-table dest "000")
       (get jump-table jump "000")))

(defn parse-a-instruction
  [{:keys [var]}]
  (str "0" (or (get builtins var) 
               (binary-string (get-variable var)))))

(defn parse-constant-instruction
  [{:keys [const]}]
  (str "0" (binary-string (read-string const))))

(defn parse-instruction
  [line]
  (let [c-instruction      (re-matcher c-instruction-rx line)
        a-instruction      (re-matcher a-instruction-rx line)
        constant           (re-matcher constant-rx line)
        symbol-declaration (re-matcher symbol-declaration-rx line)]
    (cond
      (.matches c-instruction)      (parse-c-instruction {:type :c-instruction
                                                          :dest (.group c-instruction "dest")
                                                          :comp (.group c-instruction "comp")
                                                          :jump (.group c-instruction "jump")})
      (.matches a-instruction)      (parse-a-instruction {:type :a-instruction
                                                          :var (.group a-instruction "var")})
      (.matches constant)           (parse-constant-instruction {:type  :constant
                                                                 :const (.group constant "const")})
      :else                         {:COULD-NOT-PARSE line})))

(defn compile
  [input output]
  (reset! symbols {})
  (reset! prev-variable 15)
  (reset! symbols-found 0)
  (->> input
       (util/read-file)
       (mapv util/remove-comments)
       (mapv util/remove-whitespace)
       (remove s/blank?)
       (replace-symbols)
       (mapv parse-instruction)
       (util/output-file output)))
