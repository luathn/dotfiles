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

;; Keep backup (file~) and auto-save (#file#) files out of project folders
(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory))))
(setq auto-save-file-name-transforms `((".*" ,(expand-file-name "autosaves/" user-emacs-directory) t)))

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
  (load-theme 'doom-one-light t)
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
  ;; Leader key
  (evil-set-leader '(normal visual motion) (kbd "SPC"))
  (evil-define-key '(normal visual motion) 'global
    (kbd "<leader>ff") 'find-file
    (kbd "<leader>tc") 'tab-new
    (kbd "<leader>tq") 'tab-close
  )
  ;; evil-collection-unimpaired binds these too, but its minor mode is never
  ;; enabled in buffers that skip major mode hooks (EgtMMS playlist, *GNU Emacs*)
  (evil-define-key '(normal motion) 'global
    (kbd "[b") 'evil-prev-buffer
    (kbd "]b") 'evil-next-buffer
  )
  (evil-mode 1)
)

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
  :init
  ;; Keep SPC free for the evil leader key
  (setq evil-collection-key-blacklist '("SPC"))
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
  (setq evil-escape-excluded-major-modes '(ibuffer-mode))
  ;; The magit mode list only exists once evil-collection-magit is loaded
  (with-eval-after-load 'evil-collection-magit
    (setq evil-escape-excluded-major-modes
          (append evil-collection-magit-emacs-to-evil-collection-magit-state-modes
                  evil-escape-excluded-major-modes)))
  (setq evil-escape-excluded-states '(visual))
  :init
  (evil-escape-mode)
)

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

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
  (global-treesit-auto-mode)
)

;; Project.el config
(use-package project
  :init
  (evil-define-key '(normal visual motion) 'global
    (kbd "<leader>SPC") 'project-find-file
    (kbd "<leader>pp") 'project-switch-project)
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
  :init
  (evil-define-key '(normal visual motion) 'global
    (kbd "<leader>gg") 'magit-status)
  :custom
  (magit-diff-refine-hunk 'all)
)

;; Enable vertico
(use-package vertico
  :bind 
  (:map vertico-map
        ("C-k" . kill-whole-line)
        ("DEL" . vertico-directory-delete-char)
        ("M-[" . vertico-repeat-previous)
	("M-]" . vertico-repeat-next)
	("C-v" . my/embark-open-in-vsplit)
	("C-s" . my/embark-open-in-split-below)
	("C-o" . my/embark-open-in-other-window)
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
  (defun my/embark-open-in-split (window-fn)
    "Open the current minibuffer candidate in the window returned by WINDOW-FN."
    (require 'embark)
    (let* ((target (or (car (embark--targets)) (user-error "No target found")))
           (open (pcase (plist-get target :type)
                   ('file #'find-file)
                   ('buffer #'switch-to-buffer)
                   ('bookmark #'bookmark-jump)
                   (type (user-error "Cannot open %s in a split" type)))))
      (embark--act (lambda ()
                     (interactive)
                     (select-window (funcall window-fn))
                     (call-interactively open))
                   target t)))
  (defun my/embark-open-in-vsplit ()
    "Open the current minibuffer candidate in a vertical split."
    (interactive)
    (my/embark-open-in-split #'split-window-right))
  (defun my/embark-open-in-split-below ()
    "Open the current minibuffer candidate in a horizontal split."
    (interactive)
    (my/embark-open-in-split #'split-window-below))
  (defun my/embark-open-in-other-window ()
    "Open the current minibuffer candidate in the other window.
Split to the right when there is only one window."
    (interactive)
    (my/embark-open-in-split
     (lambda ()
       (let ((win (next-window)))
         (if (eq win (selected-window)) (split-window-right) win)))))
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
  (orderless-matching-styles '(orderless-flex))
)

;; Example configuration for Consult
(use-package consult
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c m" . consult-man)
         ;; C-x bindings in `ctl-x-map'
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer))     ;; orig. project-switch-to-buffer
  :init
  (evil-define-key '(normal visual motion) 'global
    (kbd "<leader>bb") 'consult-buffer
    (kbd "<leader>.") 'consult-buffer
    (kbd "<leader>,") 'consult-project-buffer
    (kbd "<leader>sg") 'consult-ripgrep)
  :config
  (setq consult-preview-key "C-<return>")
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

;; Config docview
(setq doc-view-resolution 200)

;; Music
(use-package emms
  :ensure t
  :init
  (evil-define-key '(normal visual motion) 'global
    (kbd "<leader>mm") 'emms
    (kbd "<leader>mx") 'emms-pause
    (kbd "<leader>m<") 'emms-seek-backward
    (kbd "<leader>m>") 'emms-seek-forward)
  :custom
  (emms-seek-seconds 3)
  :config
  (emms-all)
  (emms-default-players)
  (setq emms-player-list '(emms-player-mpv))
  (defvar-keymap emms-seek-repeat-map
    :repeat t
    "<" #'emms-seek-backward
    ">" #'emms-seek-forward)
  (repeat-mode 1)
)

(use-package corfu
  :custom
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-delay 0.3)
  (corfu-auto-prefix 2)
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  :init
  (global-corfu-mode)
)

(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
)

(advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)
(setq completion-category-overrides '((eglot (styles orderless))
                                      (eglot-capf (styles orderless))))

(defun my/eglot-capf ()
  (setq-local completion-at-point-functions
              (list (cape-capf-super
                     #'eglot-completion-at-point
                     #'cape-dabbrev
                     #'cape-file))))

(add-hook 'eglot-managed-mode-hook #'my/eglot-capf)

(setq newsticker-url-list
      '(("Reddit Emacs" "https://www.reddit.com/r/emacs.rss" nil nil nil)))

;; (use-package better-jumper
;;   :ensure t
;;   :config
;;   (with-eval-after-load 'evil-maps
;;     (define-key evil-motion-state-map (kbd "C-o") 'better-jumper-jump-backward)
;;     (define-key evil-motion-state-map (kbd "<C-i>") 'better-jumper-jump-forward))
;;   :init
;;   (better-jumper-mode +1)
;;   (global-set-key [remap evil-jump-forward]  #'better-jumper-jump-forward)
;;   (global-set-key [remap evil-jump-backward] #'better-jumper-jump-backward)
;;   (global-set-key [remap xref-pop-marker-stack] #'better-jumper-jump-backward)
;;   (global-set-key [remap xref-go-back] #'better-jumper-jump-backward)
;;   (global-set-key [remap xref-go-forward] #'better-jumper-jump-forward)
;; )

;; (use-package evil-anzu
;;   :after evil
;;   :ensure t
;;   :init
;;   (global-anzu-mode)
;; )
