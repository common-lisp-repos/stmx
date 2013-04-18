;; -*- lisp -*-

;; This file is part of STMX.
;; Copyright (c) 2013 Massimiliano Ghilardi
;;
;; This library is free software: you can redistribute it and/or
;; modify it under the terms of the Lisp Lesser General Public License
;; (http://opensource.franz.com/preamble.html), known as the LLGPL.
;;
;; This library is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty
;; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the Lisp Lesser General Public License for more details.


(in-package :cl-user)

(asdf:defsystem :stmx
  :name "STMX"
  :version "1.0.1"
  :license "LLGPL"
  :author "Massimiliano Ghilardi"
  :description "Composable Software Transactional Memory"

  :depends-on (:log4cl
               :closer-mop
               :bordeaux-threads
               :trivial-garbage)

  :components ((:static-file "stmx.asd")

               (:module :lang
                :components ((:file "package")
                             (:file "macro"       :depends-on ("package"))
                             (:file "fast-vector" :depends-on ("package"))
                             (:file "hash-table"  :depends-on ("package"))
                             (:file "print"       :depends-on ("package"))))

               (:module :src
                :depends-on (:lang)
                :components ((:file "package")
                             (:file "classes"     :depends-on ("package"))
                             (:file "tlog"        :depends-on ("classes"))
                             (:file "tvar"        :depends-on ("tlog"))
                             (:file "tclass"      :depends-on ("tvar"))
                             (:file "commit"      :depends-on ("tlog"))
                             (:file "atomic"      :depends-on ("tclass" "commit"))
                             (:file "orelse"      :depends-on ("atomic"))))

               (:module :util
                :depends-on (:lang :src)
                :components ((:file "package")
                             (:file "misc"        :depends-on ("package"))
                             (:file "print"       :depends-on ("package"))

                             (:file "container"   :depends-on ("package"))
                             (:file "tvar"        :depends-on ("container"))
                             (:file "tcell"       :depends-on ("container"))
                             (:file "tfifo"       :depends-on ("container"))
                             (:file "tstack"      :depends-on ("container"))
                             (:file "tchannel"    :depends-on ("container"))

			     (:file "bheap"       :depends-on ("container"))

                             (:file "bmap"        :depends-on ("print"))
                             (:file "rbmap"       :depends-on ("bmap"))
                             (:file "tmap"        :depends-on ("rbmap"))

                             (:file "thash-table" :depends-on ("print"))))))



(asdf:defsystem :stmx.test
  :name "STMX.TEST"
  :version "1.0.1"
  :author "Massimiliano Ghilardi"
  :license "LLGPL"
  :description "test suite for STMX"

  :depends-on (:log4cl
               :bordeaux-threads
               :fiveam
               :stmx)

  :components ((:module :test
                :components ((:file "package")
                             (:file "misc"      :depends-on ("package"))
                             (:file "rbmap"     :depends-on ("misc"))
                             (:file "atomic"    :depends-on ("package"))
                             (:file "on-commit" :depends-on ("atomic"))
                             (:file "retry"     :depends-on ("package"))
                             (:file "orelse"    :depends-on ("package"))
                             (:file "tmap"      :depends-on ("rbmap" "orelse"))))))


