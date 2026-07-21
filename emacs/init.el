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
    ("melpa"    . 25)))
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
  ;; mac-option-modifier nil
  ;; mac-command-modifier 'meta
  (setq ns-pop-up-frames nil
        native-comp-async-report-warnings-errors nil))

;; UI packages
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
)

(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-project-name t)
)

;; (load-theme 'modus-vivendi)
;; (use-package catppuccin-theme
;;   :ensure t
;;   :config
;;   (load-theme 'catppuccin t)
;;   (setq catppuccin-flavor 'frappe)
;;   (catppuccin-reload)
;; )

;; Lsp
(use-package eglot
  :ensure t
  :custom
  (eglot-ignored-server-capabilities '(:documentHighlightProvider))
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

;; Ediff
(use-package ediff
  :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain)
)
;
; (defun ediff-copy-both-to-C ()
;   (interactive)
;   (ediff-copy-diff ediff-current-difference nil 'C nil
;                    (concat
;                     (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
;                     (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
; (defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
; (add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)

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
    '((consult-grep buffer)))
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

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

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
  :hook
  (embark-collect-mode . consult-preview-at-point-mode)
)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  ;; (completion-category-overrides '((file (styles partial-completion))))
  ;; (completion-pcm-leading-wildcard t)
  (orderless-matching-styles '(orderless-literal))
)

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
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

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

;; Test
(use-package consult-rg-files
  :load-path "~/code/consult-rg-files/"
)

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
