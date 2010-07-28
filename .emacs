;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

(show-paren-mode)
(ido-mode)

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "C-<backspace>")
       'paredit-backward-kill-word)))

(add-hook 'clojure-mode-hook (lambda ()
			       (paredit-mode +1)))
(add-hook 'emacs-lisp-mode-hook (lambda ()
				  (paredit-mode +1)))

