;;; cider-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (cider cider-jack-in) "cider" "../../../../.emacs.d/elpa/cider-0.4.0/cider.el"
;;;;;;  "8951f319e40d80693db485472283a162")
;;; Generated autoloads from ../../../../.emacs.d/elpa/cider-0.4.0/cider.el

(autoload 'cider-jack-in "cider" "\
Start a nREPL server for the current project and connect to it.
If PROMPT-PROJECT is t, then prompt for the project for which to
start the server.

\(fn &optional PROMPT-PROJECT)" t nil)

(autoload 'cider "cider" "\
Connect to an nREPL server identified by HOST and PORT.

\(fn HOST PORT)" t nil)

(eval-after-load 'clojure-mode '(progn (define-key clojure-mode-map (kbd "C-c M-j") 'cider-jack-in) (define-key clojure-mode-map (kbd "C-c M-c") 'cider)))

;;;***

;;;### (autoloads (cider-macroexpand-all cider-macroexpand-1) "cider-macroexpansion"
;;;;;;  "../../../../.emacs.d/elpa/cider-0.4.0/cider-macroexpansion.el"
;;;;;;  "09af416b31aebcdb14372528f4853648")
;;; Generated autoloads from ../../../../.emacs.d/elpa/cider-0.4.0/cider-macroexpansion.el

(autoload 'cider-macroexpand-1 "cider-macroexpansion" "\
Invoke 'macroexpand-1' on the expression at point.
If invoked with a PREFIX argument, use 'macroexpand' instead of
'macroexpand-1'.

\(fn &optional PREFIX)" t nil)

(autoload 'cider-macroexpand-all "cider-macroexpansion" "\
Invoke 'clojure.walk/macroexpand-all' on the expression at point.

\(fn)" t nil)

;;;***

;;;### (autoloads (cider-mode) "cider-mode" "../../../../.emacs.d/elpa/cider-0.4.0/cider-mode.el"
;;;;;;  "29f34a541b06a6ac6f01957f2facef03")
;;; Generated autoloads from ../../../../.emacs.d/elpa/cider-0.4.0/cider-mode.el

(autoload 'cider-mode "cider-mode" "\
Minor mode for REPL interaction from a Clojure buffer.

\\{cider-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (cider-selector) "cider-selector" "../../../../.emacs.d/elpa/cider-0.4.0/cider-selector.el"
;;;;;;  "b7dd99ddab57b69a10fe32da5c660007")
;;; Generated autoloads from ../../../../.emacs.d/elpa/cider-0.4.0/cider-selector.el

(autoload 'cider-selector "cider-selector" "\
Select a new buffer by type, indicated by a single character.
The user is prompted for a single character indicating the method by
which to choose a new buffer.  The `?' character describes then
available methods.  OTHER-WINDOW provides an optional target.

See `def-cider-selector-method' for defining new methods.

\(fn &optional OTHER-WINDOW)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../.emacs.d/elpa/cider-0.4.0/cider-client.el"
;;;;;;  "../../../../.emacs.d/elpa/cider-0.4.0/cider-eldoc.el" "../../../../.emacs.d/elpa/cider-0.4.0/cider-interaction.el"
;;;;;;  "../../../../.emacs.d/elpa/cider-0.4.0/cider-macroexpansion.el"
;;;;;;  "../../../../.emacs.d/elpa/cider-0.4.0/cider-mode.el" "../../../../.emacs.d/elpa/cider-0.4.0/cider-pkg.el"
;;;;;;  "../../../../.emacs.d/elpa/cider-0.4.0/cider-repl.el" "../../../../.emacs.d/elpa/cider-0.4.0/cider-selector.el"
;;;;;;  "../../../../.emacs.d/elpa/cider-0.4.0/cider-util.el" "../../../../.emacs.d/elpa/cider-0.4.0/cider-version.el"
;;;;;;  "../../../../.emacs.d/elpa/cider-0.4.0/cider.el" "../../../../.emacs.d/elpa/cider-0.4.0/nrepl-client.el")
;;;;;;  (21210 37762 502466 0))

;;;***

(provide 'cider-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cider-autoloads.el ends here
