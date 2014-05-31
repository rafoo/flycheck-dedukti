;;; flycheck-dedukti.el --- Flycheck integration of Dedukti

;; Copyright 2014 Raphaël Cauderlier

;; Author: Raphaël Cauderlier
;; Version: 0.1
;; License: CeCILL-B

;;; Commentary:
;; This file defines a flycheck checker based on Dedukti type checker dkcheck.
;; Dedukti is a type checker for the lambda-Pi-calculus modulo.
;; It is a free software under the CeCILL-B license.
;; Dedukti is available at the following url:
;; <https://www.rocq.inria.fr/deducteam/Dedukti/>
;; Flycheck is an on-the-fly syntax checker for GNU Emacs 24

;; Package-Requires: ((f "0.11.0") (flycheck "0.19") (dedukti-mode "0.1"))

;(dash "2.4.0")  (s "1.7.0") (pkg-info "0.4") (cl-lib "0.3") (emacs "24.1"))

;;; Code:

(require 'flycheck)
(require 'dedukti-mode)

;;;###autoload
(add-hook 'flycheck-mode-hook
          (lambda ()
            (flycheck-define-checker dedukti
              "Dedukti type checker."
              :command ("dkcheck"
                        (eval dedukti-check-options)
                        source-inplace)
              :error-patterns
              ((warning
                line-start
                "WARNING file:" (file-name)
                " line:" line
                " column:" column
                (message) line-end)
               (error
                line-start
                "ERROR file:" (file-name)
                " line:" line
                " column:" column
                (message) line-end)
               (warning
                line-start
                "WARNING line:" line
                " column:" column
                (message) line-end)
               (error
                line-start
                "ERROR line:" line
                " column:" column
                (message) line-end))
              :modes dedukti-mode)
            (add-to-list 'flycheck-checkers 'dedukti)))

;;;###autoload
(add-hook 'dedukti-mode-hook 'flycheck-mode)

;;; flycheck-dedukti.el ends here
