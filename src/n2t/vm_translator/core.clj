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

(defn is-directory?
  [path]
  (.isDirectory (io/file path)))

(defn process-line
  [base line-no line]
  (->> line
       (parser/parse)
       (writer/write base line-no)
       (concat [(str "\n// line: " line)])))

(defn process-lines
  [base raw-lines]
  (->> raw-lines
       (mapv util/remove-comments)
       (mapv util/compress-whitespace)
       (remove str/blank?)
       (map-indexed (partial process-line base))
       (apply concat)))

(defn process-file
  [file]
  (let [base (get-filename file)]
    (with-open [input (io/reader file)]
      (concat
       ["\n\n\n" (str "// class: " base) "\n"]
       (process-lines base (line-seq input))))))

(defn process-folder
  [folder]
  (->> (.listFiles (io/file folder))
       (mapv #(.toString %))
       (filter #(.endsWith % ".vm"))
       (mapcat process-file)))

(defn attach-header
  [lines in-path]
  (concat ["\n\n\n" (str "// program: " (get-filename in-path)) "\n\n\n"]
          (writer/bootstrap)
          lines))

(defn output-file
  [lines in-path]
  (let [out-path (str (.toString (io/file in-path)) "/" (get-filename in-path) ".asm")]
    (with-open [output (io/writer out-path)]
      (doseq [line lines]
        (.write output line)
        (.write output "\n")))))

(defn -main
  [in-path]
  (if (is-directory? in-path)
    (-> (process-folder in-path)
        (attach-header in-path)
        (output-file in-path))
    (-> (process-file in-path)
        (output-file (parent in-path)))))
