;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

(add-to-list 'load-path "~/.emacs.d/non-elpa/")
(add-to-list 'load-path "~/.emacs.d/non-elpa/color-theme-6.6.0")

(require 'clojure-mode)

(defun make-backup-file-name (fpath)
  (let (backup-root bpath)
    (setq backup-root "~/.emacs_backups")
    (setq bpath (concat backup-root fpath "~"))
    (make-directory (file-name-directory bpath) bpath)
    bpath))

(show-paren-mode)
(ido-mode)
(column-number-mode)
(global-linum-mode)

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "C-<backspace>")
       'paredit-backward-kill-word)))

(eval-after-load 'clojure-mode
  '(progn
     (require 'paredit)
     (add-hook 'clojure-mode-hook (lambda ()
				    (enable-paredit-mode)))
     (define-key clojure-mode-map "{" 'paredit-open-brace)
     (define-key clojure-mode-map "}" 'paredit-close-brace)))

(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

;; TODO: Find out why paredit is messed up in slime
;; (add-hook 'slime-repl-mode-hook (lambda ()
;;   (enable-paredit-mode)))

(add-hook 'emacs-lisp-mode-hook (lambda ()
				  (enable-paredit-mode)))

(eval-after-load 'slime
  '(setq slime-protocol-version 'ignore))

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-deep-blue)))
