(ns n2t.vm-translator.core
  (:require [n2t.util :as util]
            [n2t.vm-translator.parser :as parser]
            [n2t.vm-translator.code-writer :as writer]
            [clojure.string :as str]
            [clojure.pprint :refer [pprint]]
            [clojure.java.io :as io])
  (:gen-class))

(defn get-filename
  [path]
  (re-find #"^(?:[^.]+)" (.getName (io/file path))))

(defn parent
  [path]
  (.getParent (io/file path)))

(defn process-line
  [base line-no line]
  (->> line
       (parser/parse)
       (writer/write base line-no)
       (concat [(str "\n// input: " line)])))

(defn process-lines
  [base raw-lines]
  (->> raw-lines
       (mapv util/remove-comments)
       (mapv util/compress-whitespace)
       (remove str/blank?)
       (map-indexed (partial process-line base))
       (apply concat)))

(defn check
  [file]
  (let [base (get-filename file)]
    (with-open [input (io/reader file)]
      (process-lines base (line-seq input)))))

(defn -main
  [in-path]
  (let [base (get-filename in-path)
        out-path (str (parent in-path) "/" base ".asm")]
    (with-open [output (io/writer out-path)]
      (with-open [input (io/reader in-path)]
        (->> input
             (line-seq)
             (process-lines base)
             (mapv (fn [line]
                     (.write output line)
                     (.write output "\n")
                     line))
             (doall))))))
