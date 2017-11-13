(ns n2t.vm-translator.parser
  (:require [clojure.string :as str]
            [clojure.pprint :refer [pprint]]
            [clojure.spec.alpha :as s]
            [n2t.util :as util]))

(defn x-keyword?
  [x]
  (cond (keyword? x) x
        (string? x)  (keyword x)
        :else        :clojure.spec/invalid))

(defn x-int?
  [x]
  (cond (int? x)    x
        (string? x) (try
                      (Integer/parseInt x 10)
                      (catch NumberFormatException e
                        :clojure.spec/invalid))
        :else       :clojure.spec/invalid))

(defn x-vec?
  [x]
  (cond (vector? x) x
        (string? x) (str/split x #" ")
        :else       :clojure.spec/invalid))

(s/def :instruction.arithmetic/bitwise
  #{:add :sub :and :or})

(s/def :instruction.arithmetic/unary
  #{:neg :not})

(s/def :instruction.arithmetic/comparison
  #{:eq :gt :lt})

(s/def ::arithmetic-instruction
  (s/or :bitwise :instruction.arithmetic/bitwise
        :unary :instruction.arithmetic/unary
        :comparison :instruction.arithmetic/comparison))

(s/def ::memory-instruction
  #{:push :pop})

(s/def ::program-flow-instruction
  #{:label :goto :if-goto})

(s/def ::function-instruction
  #{:function})

(s/def ::call-instruction
  #{:call})

(s/def ::return-instruction
  #{:return})

(s/def :segment/constant
  #{:constant})

(s/def :segment/dynamic
  #{:local :argument :this :that})

(s/def :segment/fixed
  #{:pointer :temp})

(s/def :segment/static
  #{:static})

(s/def ::segment
  (s/or :constant :segment/constant
        :dynamic :segment/dynamic
        :fixed :segment/fixed
        :static :segment/static))

(s/def ::label 
  string?)

(s/def ::program-flow-command
  (s/cat :instruction (s/and (s/conformer x-keyword?)
                             ::program-flow-instruction)
         :label ::label))

(s/def ::function-command
  (s/cat :instruction (s/and (s/conformer x-keyword?)
                             ::function-instruction)
         :fn-name ::label
         :num-locals (s/conformer x-int?)))

(s/def ::call-command
  (s/cat :instruction (s/and (s/conformer x-keyword?)
                             ::call-instruction)
         :fn-name ::label
         :num-args (s/conformer x-int?)))

(s/def ::return-command
  (s/cat :instruction (s/and (s/conformer x-keyword?)
                             ::return-instruction)))

(s/def ::arithmetic-command
  (s/cat :instruction (s/and (s/conformer x-keyword?) 
                             ::arithmetic-instruction)))

(s/def ::memory-command
  (s/cat :instruction (s/and (s/conformer x-keyword?)
                             ::memory-instruction)
         :segment (s/and (s/conformer x-keyword?)
                         ::segment)
         :index (s/conformer x-int?)))

(s/def ::command
  (s/and (s/conformer x-vec?)
         (s/or :program-flow ::program-flow-command
               :function ::function-command
               :call ::call-command
               :return ::return-command
               :arithmetic ::arithmetic-command
               :memory ::memory-command)))

(defn parse
  [line]
  (let [parsed-line (s/conform ::command line)]
    (if (= :clojure.spec.alpha/invalid parsed-line)
      (throw (ex-info (s/explain-str ::command line) {}))
      parsed-line)))
