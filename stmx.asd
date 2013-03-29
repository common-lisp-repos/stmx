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
  :version "0.9.0"
  :license "LLGPL"
  :author "Massimiliano Ghilardi"
  :description "Composable Software Transactional Memory"

  :depends-on (:arnesi
               :bordeaux-threads
               :closer-mop
               :log4cl)

  :components ((:static-file "stmx.asd")

               (:module :src
                :components ((:file "package")
                             (:file "misc"        :depends-on ("package"))
                             (:file "classes"     :depends-on ("misc"))
                             (:file "tlog"        :depends-on ("classes"))
                             (:file "tvar"        :depends-on ("tlog"))
                             (:file "tclass"      :depends-on ("tvar"))
                             (:file "commit"      :depends-on ("tlog"))
                             (:file "atomic"      :depends-on ("tclass" "commit"))
                             (:file "orelse"      :depends-on ("atomic"))))

               (:module :util
                :components ((:file "package")
                             (:file "print"       :depends-on ("package"))
                             (:file "bmap"        :depends-on ("print"))
                             (:file "thash-table" :depends-on ("print"))
                             (:file "cell"        :depends-on ("package"))
                             (:file "cell-tobj"   :depends-on ("cell"))
                             (:file "cell-tvar"   :depends-on ("cell")))
                :depends-on (:src))))



(asdf:defsystem :stmx.test
  :name "STMX.TEST"
  :version "0.9.0"
  :author "Massimiliano Ghilardi"
  :license "LLGPL"
  :description "test suite for STMX"

  :depends-on (:arnesi
               :bordeaux-threads
               :log4cl
               :fiveam
               :stmx)

  :components ((:module :test
                :components ((:file "package")
                             (:file "atomic"    :depends-on ("package"))
                             (:file "on-commit" :depends-on ("package" "atomic"))
                             (:file "retry"     :depends-on ("package"))
                             (:file "orelse"    :depends-on ("package"))))))


