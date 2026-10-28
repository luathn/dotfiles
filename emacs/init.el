;;; init.el --- Emacs config -*- lexical-binding: t -*-

;; Set frame height & width
; (set-fringe-mode 0)

(add-to-list 'default-frame-alist '(height . 54))
(add-to-list 'default-frame-alist '(width . 180))

; (add-to-list 'default-frame-alist '(undecorated-round . t))
; (add-to-list 'default-frame-alist '(internal-border-width . 0))

;; Better default modes
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(menu-bar-mode -1)          ; Disable the menu bar
(savehist-mode t)

(show-paren-mode 1)
(global-display-line-numbers-mode 1)
;; (global-hl-line-mode 1)
(blink-cursor-mode 0)
;; Turn off ring bell
(setq ring-bell-function 'ignore)

;; Fonts
(set-face-attribute 'default nil :font "JetBrainsMono NF" :height 130 :weight 'light)

;; Set custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Package manager
(setq package-archives
  '(("gnu elpa" . "https://elpa.gnu.org/packages/")
    ("melpa"    . "https://melpa.org/packages/"))
  package-archive-priorities
  '(("gnu elpa" . 20)
    ("melpa"    . 15)))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;; MacOS
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-copy-env "GEMINI_API_KEY")
  (exec-path-from-shell-initialize)
)

(when (memq window-system '(mac ns))
  (setq ns-pop-up-frames nil
        native-comp-async-report-warnings-errors nil))

;; UI packages
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
)

;; Lsp
(use-package eglot
  :ensure t
  :custom
  (eglot-ignored-server-capabilities '(:documentHighlightProvider))
  (eglot-sync-connect 0)
  :hook ((go-ts-mode . eglot-ensure))
  :config
  (define-key evil-normal-state-map (kbd "K") 
    (lambda () 
      (interactive)
      (call-interactively 'eldoc-print-current-symbol-info)))
)

(with-eval-after-load 'eglot
  ; (fset #'jsonrpc--log-event #'ignore)
  ; (remove-hook 'eldoc-display-functions 'eldoc-display-in-echo-area) ; Hide eldoc in minibuffer
  ;; (setq eglot-events-buffer-size 0)
  ;; (add-to-list 'eglot-stay-out-of 'eldoc-documentation-strategy)
)

;; Treesitter
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  (treesit-auto-langs '(go ruby lua python javascript typescript))
  :config
  (treesit-auto-add-to-auto-mode-alist '(go ruby lua python javascript typescript))
  ;(treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
)

;; Project.el config
(use-package project
  :custom
  (project-switch-commands '((project-find-file "Find file" "f")
			     (project-find-dir "Find dir" "d")
			     (project-dired "Dired" "D")
			     (consult-ripgrep "ripgrep" "g")
			     (magit-project-status "Magit" "m")))
  :config
  (setq project-mode-line t)
)

;; Magit
(use-package magit
  :ensure t
  :custom
  (magit-diff-refine-hunk 'all)
)

;; Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  ;(setq evil-want-minibuffer t)
  (setq evil-want-C-u-scroll t)
  (setq evil-search-module 'isearch)
  :config
  (evil-set-undo-system 'undo-redo)
  (evil-select-search-module evil-search-module 'isearch)
  (evil-mode 1)
)

;; (use-package evil-anzu
;;   :after evil
;;   :ensure t
;;   :init
;;   (global-anzu-mode)
;; )

(use-package evil-nerd-commenter
  :init
  (setq evilnc-comment-text-object "c")
  :config
  (define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
  ;; (evilnc-default-hotkeys)
  (evilnc-default-hotkeys nil t)
)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (setq evil-collection-magit-want-horizontal-movement t)
  (define-key evil-normal-state-map (kbd "gI") 'eglot-find-implementation)
  (evil-collection-init)
  (with-eval-after-load 'evil-collection-magit
    (evil-define-key 'normal magit-mode-map (kbd "p") nil))
)

(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2)
  (setq evil-escape-excluded-major-modes (append evil-collection-magit-emacs-to-evil-collection-magit-state-modes '(ibuffer-mode)))
  (setq evil-escape-excluded-states '(visual))
  :init
  (evil-escape-mode)
)

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; Enable vertico
(use-package vertico
  :bind 
  (:map vertico-map
        ("C-k" . kill-whole-line)
        ("DEL" . vertico-directory-delete-char)
        ("M-[" . vertico-repeat-previous)
	("M-]" . vertico-repeat-next)
	("M-V" . vertico-multiform-vertical)
	("M-G" . vertico-multiform-grid)
	("M-F" . vertico-multiform-flat)
	("M-R" . vertico-multiform-reverse)
	("M-U" . vertico-multiform-unobtrusive)
	("M-U" . vertico-multiform-buffer)
  )
  :custom
  (vertico-cycle t)
  (vertico-multiform-categories
   '((consult-grep buffer)
     ))
  :hook
  (minibuffer-setup-hook . vertico-repeat-save)
  :init
  (vertico-mode)
  (global-set-key "\M-R" #'vertico-repeat)
  (vertico-multiform-mode 1)
)

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
)

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  ;; (completion-category-overrides '((file (styles partial-completion))))
  ;; (completion-pcm-leading-wildcard t)
  (orderless-matching-styles '(orderless-flex))
)

;; Example configuration for Consult
(use-package consult
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c m" . consult-man)
         ;; C-x bindings in `ctl-x-map'
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult-source-bookmark consult-source-file-register
   consult-source-recent-file consult-source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))
  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"
)

;; Test
(use-package deadgrep
  :ensure t
)

(use-package rg
  :ensure t
)

(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup))

(use-package ghostel
  :ensure t)

(use-package evil-ghostel
  :ensure t
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode)
)

(use-package better-jumper
  :ensure t
  ; :config
  ; (with-eval-after-load 'evil-maps
  ;   (define-key evil-motion-state-map (kbd "C-o") 'better-jumper-jump-backward)
  ;   (define-key evil-motion-state-map (kbd "<C-i>") 'better-jumper-jump-forward))
  :init
  (better-jumper-mode +1)
  (global-set-key [remap evil-jump-forward]  #'better-jumper-jump-forward)
  (global-set-key [remap evil-jump-backward] #'better-jumper-jump-backward)
  (global-set-key [remap xref-pop-marker-stack] #'better-jumper-jump-backward)
  (global-set-key [remap xref-go-back] #'better-jumper-jump-backward)
  (global-set-key [remap xref-go-forward] #'better-jumper-jump-forward)
)

;; Config docview
(setq doc-view-resolution 300)

;; Music
(use-package emms
  :ensure t
  :config
  ;; (require 'emms-setup)
  ;; (emms-all)
  (setq emms-player-list '(emms-player-mpv))
)
