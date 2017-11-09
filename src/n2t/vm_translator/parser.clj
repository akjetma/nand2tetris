(ns n2t.vm-translator.parser
  (:require [clojure.string :as str]
            [clojure.pprint :refer [pprint]]
            [clojure.spec.alpha :as s]
            [n2t.util :as util]))

(defn command-type
  [{:keys [command]}]
  (case command
    (:command/add :command/sub :command/neg
     :command/eq  :command/gt  :command/lt
     :command/and :command/or  :command/not)
    :command-type/arithmetic

    :command/push
    :command-type/push
    
    :command/pop
    :command-type/pop))

(defn parse
  [command-string]
  (as-> command-string $
    (str/split $ #" ")
    (zipmap [:command :arg1 :arg2] $)
    (update $ :command (partial keyword "command"))
    (assoc $ 
           :command-type (command-type $)
           :input-string command-string)))

(defn parse-commands
  [command-strings]
  (->> command-strings
       (mapv parse)))

