(ns n2t.util
  (:require [clojure.string :as s]))

(defn remove-whitespace
  [line]
  (s/replace line #"(\h*)" ""))

(defn compress-whitespace
  "Replace continuous whitespace with a single whitespace character."
  [line]
  (-> line
      (s/replace #"(\s+)" " ")
      (s/trim)))

(defn remove-comments
  [line]
  (s/replace line #"\/\/(.*)" ""))

(defn read-file
  [filename]
  (s/split
   (slurp filename)
   #"\n"))

(defn output-file
  [filename file]
  (->> file
       (clojure.string/join "\n")
       (spit filename)))
