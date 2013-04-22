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
     (define-key paredit-mode-map (kbd "RET") 'newline-and-indent)
     (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
     (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly)))

(eval-after-load 'clojure-mode
  '(progn
     (add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))))

(eval-after-load 'nrepl
  '(progn
     (add-hook 'nrepl-mode-hook (lambda () (paredit-mode +1)))
     (define-key nrepl-mode-map (kbd "RET") (lambda ()
                                              (interactive)
                                              (if (eobp)
                                                  (funcall 'nrepl-return)
                                                (flet ((nrepl-input-complete-p (&rest args) nil))
                                                  (funcall 'nrepl-return)))))))

(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))

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
