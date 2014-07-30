;;; ac-cider-compliment-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ac-cider-compliment-repl-setup ac-cider-compliment-setup)
;;;;;;  "ac-cider-compliment" "ac-cider-compliment.el" (21465 27657
;;;;;;  0 0))
;;; Generated autoloads from ac-cider-compliment.el

(defface ac-cider-compliment-candidate-face '((t (:inherit ac-candidate-face))) "\
Face for nrepl candidates." :group (quote auto-complete))

(defface ac-cider-compliment-selection-face '((t (:inherit ac-selection-face))) "\
Face for the nrepl selected candidate." :group (quote auto-complete))

(defconst ac-cider-compliment-source-defaults '((available . ac-cider-compliment-available-p) (candidate-face . ac-cider-compliment-candidate-face) (selection-face . ac-cider-compliment-selection-face) (prefix . cider-completion-symbol-start-pos) (match . ac-cider-compliment-match-everything) (document . ac-cider-compliment-documentation) (cache)) "\
Defaults common to the various completion sources.")

(defvar ac-source-compliment-everything (append '((candidates . ac-cider-compliment-candidates-everything) (symbol . "v")) ac-cider-compliment-source-defaults) "\
Auto-complete source for CIDER buffers.")

(autoload 'ac-cider-compliment-setup "ac-cider-compliment" "\
Add the Compliment completion source to the front of `ac-sources'.
This affects only the current buffer.

\(fn)" t nil)

(autoload 'ac-cider-compliment-repl-setup "ac-cider-compliment" "\
Left for backward-compatibility purposes.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("ac-cider-compliment-pkg.el") (21465 27657
;;;;;;  368373 0))

;;;***

(provide 'ac-cider-compliment-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ac-cider-compliment-autoloads.el ends here
