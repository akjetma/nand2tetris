(ns n2t.vm-translator.core
  (:require [n2t.util :as util]
            [n2t.vm-translator.parser :as parser]
            [n2t.vm-translator.code-writer :as writer]
            [clojure.string :as str]
            [clojure.pprint :refer [pprint]]
            [clojure.core.match :refer [match]]))



;; command types
;; 1. command
;; 2. command arg
;; 3. command arg1 arg2

;; memory layout
;; 0-15:        virtual registers
;; 16-255:      static variables
;; 256-2047:    stack
;; 2048-16483:  heap
;; 16384–24575: memory mapped I/O

(defn prepare-file
  "Removes comments, blank lines, etc. from a file string,
  returning a vector of command strings."
  [file-string]
  (->> (str/split file-string #"\n")
       (mapv util/remove-comments)
       (mapv util/compress-whitespace)
       (remove str/blank?)))

(defn run-test []
  (->> "resources/vm-translator/test/BasicTest.vm"
       (slurp)
       (prepare-file)
       (mapv parser/parse)
       (mapv #(assoc % :filename "BasicTest"))
       (map-indexed #(assoc %2 :line-no %1))
       (mapv writer/write)
       (apply concat)
       (str/join "\n")
       (spit "resources/vm-translator/test/BasicTest.asm")))
