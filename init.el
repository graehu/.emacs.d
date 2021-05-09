(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-background t)
 '(company-backends
   (quote
    (company-bbdb company-eclim company-semantic company-xcode company-cmake company-capf company-files
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-dabbrev)))
 '(custom-safe-themes
   (quote
    ("e29a6c66d4c383dbda21f48effe83a1c2a1058a17ac506d60889aba36685ed94" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "2642a1b7f53b9bb34c7f1e032d2098c852811ec2881eec2dc8cc07be004e45a0" "b73a23e836b3122637563ad37ae8c7533121c2ac2c8f7c87b381dd7322714cd0" default)))
 '(dap-lldb-debug-program (quote ("/usr/local/bin/lldb-vscode")))
 '(lsp-headerline-breadcrumb-icons-enable nil)
 '(package-selected-packages
   (quote
    (doom-themes doom-modeline smart-mode-line-atom-one-dark-theme dap-mode flycheck-pyflakes use-package flycheck edit-indirect yaml-mode magit ace-jump-mode yasnippet markdown-mode disaster spacemacs-theme multiple-cursors helm-projectile atom-dark-theme company rainbow-delimiters helm one-themes ## which-key eglot))))
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
;; ansi colours in compilation mode
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
(setq compilation-scroll-output t)
;; find some way to start eglot server when entering a project
;; (require 'eglot)
;; Language hooks
;; C/C++

(setq c-default-style "ellemtel")
;; (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"));"--extra-arg-before=-xc++"));"--log=verbose"
;; (add-hook 'c++-mode-hook 'eglot-ensure)
;; (add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'electric-pair-mode)
(add-hook 'c++-mode-hook 'show-paren-mode)
(add-hook 'c-mode-hook 'electric-pair-mode)
(add-hook 'c-mode-hook 'show-paren-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)

;; Enabling only some features
(setq dap-auto-configure-features '(sessions locals controls tooltip))

(require 'dap-lldb)

(dap-register-debug-template
  "LLDB::Run::mpeg_sample"
  (list :type "lldb-vscode"
        :cwd "/home/graehu/Projects/C++/framework/src/application/mpeg_sample/"
        :request "launch"
        :program "/home/graehu/Projects/C++/framework/src/application/mpeg_sample/mpeg_sample.bin"
        :name "LLDB::Run::mpeg_sample"))

;; (define-key c-mode)
;; (define-key c-mode-base-map (kbd "C-c d") 'disaster)
;; (define-key c++-mode-base-map (kbd "C-c d") 'disaster)
;; Python
;; (add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'lsp)
(add-hook 'python-mode-hook 'electric-pair-mode)
(add-hook 'python-mode-hook 'outline-minor-mode)
;; Javascript
;; (add-hook 'javascript-mode-hook 'eglot-ensure)
(add-hook 'javascript-mode-hook 'lsp)
(add-hook 'javascript-mode-hook 'electric-pair-mode)
;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook 'electric-pair-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
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
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x m") 'helm-global-mark-ring)
(helm-mode 1)
;; Goto changes
;; (global-set-key (kbd "M-g n") 'flymake-goto-next-error)
;; (global-set-key (kbd "M-g p") 'flymake-goto-prev-error)
;; Company Keys
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
;; Multi Cursor Keys
(define-prefix-command 'mc-map)
(global-set-key (kbd "C-j") 'mc-map)
(define-key mc-map (kbd "C-n") 'mc/mark-next-like-this)
(define-key mc-map (kbd "n") 'mc/skip-to-next-like-this)
(define-key mc-map (kbd "C-p") 'mc/mark-previous-like-this)
(define-key mc-map (kbd "p") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "M-/") 'avy-goto-char)
(defun avy-mark-goto-char (char &optional arg)
  "Set a mark and jump to the currently visible CHAR.
The window scope is determined by `avy-all-windows' (ARG negates it)."
	 (interactive (list (read-char "char: " t)
			    current-prefix-arg))
	 (push-mark (point))
	 (activate-mark)
	 (avy-goto-char char))

(global-set-key (kbd "M-?") 'avy-mark-goto-char)

;; (require 'avy)
;; you can select the key you prefer to
;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
(setq markdown-fontify-code-blocks-natively t)
;;flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(define-key flycheck-mode-map flycheck-keymap-prefix nil)
(setq flycheck-keymap-prefix (kbd "C-c c"))
(define-key flycheck-mode-map flycheck-keymap-prefix
  flycheck-command-map)

;; Remove menus
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
;; testing
(display-time-mode)
(require 'doom-modeline)
(doom-modeline-mode 1)
;; Or use this
;; Use `window-setup-hook' if the right segment is displayed incorrectly
(add-hook 'after-init-hook #'doom-modeline-mode)

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  ;; (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  ;; (doom-themes-org-config))
  )

(provide '.emacs)
