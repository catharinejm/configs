(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defun melpa-packages-enable ()
  (interactive)
  (unless (boundp 'package-archives-backup)
    (setq package-archives-backup (copy-alist package-archives))
    (setq package-archives (cons '("melpa" . "http://melpa.milkbox.net/packages/") package-archives))))
(defun melpa-packages-disable ()
  (interactive)
  (when (boundp 'package-archives-backup)
    (setq package-archives package-archives-backup)
    (makunbound 'package-archives-backup)))
(defun melpa-packages ()
  (interactive)
  (melpa-packages-enable)
  (package-list-packages))

(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
    alist))

(setq exec-path (append (list "/Users/jon/local/bin" "/usr/local/bin") exec-path))
(setenv "PATH" "/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/jon/local/bin")
(setenv "SCHEMEHEAPDIRS" "/Users/jon/local/lib/csv%v/%m")

(load-theme 'monokai t)

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;(setq ido-use-faces nil)
;(setq flx-ido-use-faces nil)
(global-linum-mode)
(show-paren-mode)
(column-number-mode)
;(setq linum-format "%d ")
(setq-default indent-tabs-mode nil)
(tool-bar-mode -1)
(set-default-font "-apple-Monaco-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;(color-theme-molokai)
(global-auto-revert-mode)

(when (eq system-type 'darwin)
  (setq ispell-program-name "/usr/local/bin/aspell"))

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "C-<backspace>") 'paredit-backward-kill-word)
     (define-key paredit-mode-map (kbd "C-w") 'paredit-kill-region)
     (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
     (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly)
     (define-key paredit-mode-map (kbd "{") 'paredit-open-curly)
     (define-key paredit-mode-map (kbd "}") 'paredit-close-curly)))


(setq c-default-style "linux"
      c-basic-offset 4)

(eval-after-load 'clojure-mode
  '(progn
     (add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))))

(eval-after-load 'cider-repl
  '(progn
     (add-hook 'cider-repl-mode-hook (lambda () (paredit-mode +1)))
     (add-hook 'cider-interaction-mode-hook 'cider-turn-on-eldoc-mode)
     (define-key cider-repl-mode-map (kbd "RET") (lambda ()
                                              (interactive)
                                              (if (eobp)
                                                  (funcall 'cider-repl-return)
                                                (flet ((cider-repl--input-complete-p (&rest args) nil))
                                                  (funcall 'cider-repl-return)))))))

(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook (lambda ()
                               (paredit-mode +1)))



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
                    scheme-mode
                    scala-mode))

(mapc (lambda (s) (put s 'scheme-indent-function 'defun))
      (list 'run* 'run 'fresh 'conde 'module 'if))
;(setq scheme-program-name "petite")
(setq scheme-program-name "csi")

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

(require 'find-file-in-project)
(setq ffip-patterns (append (list "*.scala" "*.coffee") ffip-patterns))
(setq ffip-limit 1024)

(defun find-file-in-project-with-options ()
  (interactive)
  (let ((ffip-find-options (if (boundp 'ffip-exclude-dirs)
                               (format "\\( %s \\)"
                                       (mapconcat (lambda (dir)
                                                    (format "-not -regex \".*/%s/.*\""
                                                            (replace-regexp-in-string "\\." "\\\\." dir)))
                                                  ffip-exclude-dirs
                                                  " -and "))
                             ffip-find-options))
        (ffip-patterns (if (boundp 'ffip-additional-patterns)
                           (append ffip-additional-patterns ffip-patterns)
                         ffip-patterns)))
    (find-file-in-project)))

(global-set-key (kbd "C-x M-f") 'find-file-in-project-with-options)
(global-set-key (kbd "C-x M-g") 'rgrep)
(global-set-key (kbd "C-M-g") 'magit-status)
(global-set-key (kbd "M-k") 'kill-sexp)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((ffip-additional-patterns "*.conf" "*.dist" "routes") (ffip-exclude-dirs "target" "node_modules" ".mocha")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "#FD971F" :weight normal))))
 '(font-lock-type-face ((t (:foreground "#66D9EF" :slant normal))))
 '(font-lock-warning-face ((t (:inherit error :foreground "#FD971F" :underline t :slant normal :weight bold))))
 '(italic ((t (:slant normal)))))
