(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-bbdb company-eclim company-semantic company-xcode company-cmake company-capf company-files
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-dabbrev)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "2642a1b7f53b9bb34c7f1e032d2098c852811ec2881eec2dc8cc07be004e45a0" "b73a23e836b3122637563ad37ae8c7533121c2ac2c8f7c87b381dd7322714cd0" default)))
 '(package-selected-packages
   (quote
    (yasnippet markdown-mode disaster spacemacs-theme multiple-cursors helm-projectile atom-dark-theme company rainbow-delimiters helm one-themes ## which-key eglot))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; MY SHIT COMES NOW
(require 'package)
;(company-select-next)
;(company--company-command-p)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)
;;tings.
(load-theme 'spacemacs-dark)
(add-hook 'emacs-lisp-mode 'rainbow-delimiters-mode)
;; find some way to start eglot server when entering a project
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"));"/usr/bin/clangd" "--log=verbose"))
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)
;;
(global-company-mode)
(which-key-mode)
;; projectile setup
(require 'projectile)
(define-key projectile-mode-map (kbd "M-p") 'projectile-command-map)
(projectile-mode +1)
;;
(require 'helm-projectile)
(helm-projectile-on)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; Goto changes
(global-set-key (kbd "M-g n") 'flymake-goto-next-error)
(global-set-key (kbd "M-g p") 'flymake-goto-prev-error)
;;
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
;;
(provide '.emacs)

