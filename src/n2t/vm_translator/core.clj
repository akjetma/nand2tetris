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
       (concat [(str "// input: " line)])))

(defn -main
  [in-path]
  (let [base (get-filename in-path)
        out-path (str (parent in-path) "/" base ".asm")
        process (partial process-line base)]
    (with-open [output (io/writer out-path)]
      (with-open [input (io/reader in-path)]
        (->> input
             (line-seq)
             (mapv util/remove-comments)
             (mapv util/compress-whitespace)
             (remove str/blank?)
             (map-indexed process)
             (apply concat)
             (mapv (fn [line]
                     (.write output line)
                     (.write output "\n")))
             (doall))))))
