(defproject n2t "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.9.0-RC1"]
                 [org.clojure/core.match "0.3.0-alpha5"]]
  :main ^:skip-aot n2t.vm-translator.core
  :profiles {:uberjar {:aot :all}})
