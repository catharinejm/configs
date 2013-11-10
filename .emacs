(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
    alist))

(require 'color-theme)
(eval-after-load 'color-theme
  '(color-theme-hober))

(ido-mode)
(global-linum-mode)
(show-paren-mode)
(column-number-mode)
; (setq linum-format "%d ")
(setq-default indent-tabs-mode nil)
(tool-bar-mode -1)
(set-default-font "-apple-Monaco-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;(color-theme-molokai)
(global-auto-revert-mode)

(when (eq system-type 'darwin)
  (setq ispell-program-name "/usr/local/bin/aspell"))

(defun make-backup-file-name (fpath)
  (let (backup-root bpath)
    (setq backup-root "~/.emacs_backups")
    (setq bpath (concat backup-root fpath "~"))
    (make-directory (file-name-directory bpath) bpath)
    bpath))

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "C-<backspace>") 'paredit-backward-kill-word)
     (define-key paredit-mode-map (kbd "C-w") 'paredit-kill-region)
     (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
     (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly)
     (define-key paredit-mode-map (kbd "{") 'paredit-open-curly)
     (define-key paredit-mode-map (kbd "}") 'paredit-close-curly)))

;; (add-hook 'c-mode-common-hook (lambda ()
;;                                 (local-set-key (kbd "RET") 'newline-and-indent)))

(setq c-default-style "linux"
      c-basic-offset 4)

;; (add-hook 'emacs-lisp-mode-hook (lambda ()
;;                                   (local-set-key (kbd "RET") 'newline-and-indent)))

(eval-after-load 'clojure-mode
  '(progn
     (add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
     ;; (define-key clojure-mode-map (kbd "RET") 'newline-and-indent)
     ))

(eval-after-load 'nrepl
  '(progn
     (add-hook 'nrepl-repl-mode-hook (lambda () (paredit-mode +1)))
     (add-hook 'nrepl-repl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
     (define-key nrepl-repl-mode-map (kbd "RET") (lambda ()
                                              (interactive)
                                              (if (eobp)
                                                  (funcall 'nrepl-return)
                                                (flet ((nrepl-input-complete-p (&rest args) nil))
                                                  (funcall 'nrepl-return)))))))

(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook (lambda ()
                               (paredit-mode +1)
                               ;; (define-key scheme-mode-map (kbd "RET") 'newline-and-indent)
                               ))

(defun indent-on-return (modes)
  (if modes
      (let* ((mode (car modes))
             (hook-name (intern (concat (symbol-name mode) "-hook"))))
        (add-hook `,hook-name (lambda ()
                              (local-set-key (kbd "RET") 'newline-and-indent)))
        (indent-on-return (cdr modes)))))

(indent-on-return '(c-mode-common
                    clojure-mode
                    emacs-lisp-mode
                    scheme-mode))

(setq org-todo-keywords '((sequence "TODO" "INPROGRESS" "COMPLETED" "FAILED")))
(setq org-todo-keyword-faces '(("INPROGRESS" . "yellow") ("COMPLETED" . "green") ("FAILED" . "red")))
(setq org-startup-folded 'showeverything)
(setq org-special-ctrl-a/e t)
(setq org-hide-leading-stars t)

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "M-p") 'org-move-subtree-up)
            (define-key org-mode-map (kbd "M-n") 'org-move-subtree-down)
            (flyspell-mode)))

;; (add-hook 'erc-insert-post-hook
;;           (lambda ()
;;             (let ((notify-cmd "/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier")
;;                   (window-config (current-window-configuration)))
;;               (unwind-protect
;;                   (when (string-match "\\bjon\\(?:distad\\)?\\b" (buffer-string))
;;                     (call-process notify-cmd nil nil "-title" (buffer-name) "-message" (buffer-string))))
;;               (set-window-configuration window-config))
;;             (buffer-string)))

