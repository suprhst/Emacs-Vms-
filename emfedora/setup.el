

;; Generel User Interface

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(display-time-mode 1)

;; Whichkey Mode

(use-package which-key
  :config
  (which-key-mode))


;; Org Sup

(use-package org-superstar
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

;; Avy

(use-package avy
	     :bind ("M-s" . avy-goto-char))


;;Icons

(use-package all-the-icons
  :straight t)


;;Company Mode


(use-package company
  :straight t
  :init
  (add-hook 'after-init-hook 'global-company-mode))
(use-package company-posframe)
(company-posframe-mode 1)


;; Projectile

(use-package projectile
  :straight t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

(use-package helm-projectile
  :straight t
  :config (helm-projectile-on))

(use-package treemacs-projectile
  :straight t)


;; Treemacs

(use-package treemacs
  :straight t
  :bind
  (:map global-map
	([f8] . treemacs))
  :config
  (progn
    (setq treemacs-is-never-other-window t)))


;; Dash

(use-package dashboard
  :straight t
  :init
  (progn
    (setq dashboard-center-content t)
    (setq dashboard-startup-banner "~/Downloads/l.png")
    (setq dashboard-set-file-icons t)
    (setq dashboard-banner-logo-title " Remember VIM Is Always Better  ")
    (setq dashboard-set-heading-icon t))
  :config
  (dashboard-setup-startup-hook))

;; Expand Region


(use-package expand-region
  :straight t
  :bind
  ("C-=" . er/expand-region)
  ("C--" . er/contract-region))


;; Flycheck

(use-package flycheck
:straight t
:init
(global-flycheck-mode t))


;; Theme

(use-package afternoon-theme)


;; Smart Parens

(use-package paren
  :init (setq show-paren-delay 0)
  :config (show-paren-mode +1))

;; ModeLine

;;(use-package mood-line
;;  :hook (after-init . mood-line-mode))


;; Transparency

(defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(85 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)


;; Keycast

(use-package keycast
  :config
    (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (if keycast-mode
	(add-hook 'pre-command-hook 'keycast--update t)
      (remove-hook 'pre-command-hook 'keycast--update)))
  (add-to-list 'global-mode-string '("" mode-line-keycast " "))
  (keycast-mode))




;; Improve Start

;; Using garbage magic hack.
 (use-package gcmh
   :config
   (gcmh-mode 1))
;; Setting garbage collection threshold
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))




;; Dired Icons

(use-package all-the-icons-dired)


;; Swiper/ivy


(use-package counsel
:ensure t
)

(use-package swiper
:ensure try
:config
(progn
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
))



;; Ivy POsframe

(use-package ivy-posframe)
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
(ivy-posframe-mode 1)

;; Marginalia

(use-package marginalia)
(marginalia-mode +1)


;; Org Roam


(use-package org-roam
  :straight t
  :custom
  (org-roam-directory (file-truename "~/orgroam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))
(setq org-roam-v2-ack t)



;; Emacs Python


(use-package exec-path-from-shell)
(use-package smartparens)
(smartparens-mode)
(use-package blacken)
(use-package jedi
:init
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'jedi:ac-setup))



;; Modeline

(use-package minions
  :config (minions-mode 1))
(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))
(let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9"))

(setq minions-mode-line-delimiters
      (cons "" ""))
(setq minions-mode-line-lighter "⚙")

;; remove trailing space and guard
(let ((minions nil))
  (dolist (m minions-mode-line-modes)
    (push m minions))
  (when (string= " " (car minions))
    (pop minions))
  (setq minions-mode-line-modes (nreverse minions)))



(defvar-local mode-line--vc-text+ nil)
(defun mode-line--update-vc-segment+ (&rest _)
  "Update `mode-line--vc-text+' against the current VCS state."
  (setq mode-line--vc-text+
        (when (and vc-mode buffer-file-name)
          (let ((backend (vc-backend buffer-file-name))
                (state (vc-state buffer-file-name (vc-backend buffer-file-name))))
            (let ((face 'mode-line-inactive)
                  (active (mode-line-is-active+)))
              (concat (cond ((memq state '(edited added))
                             (if active (setq face 'mode-line-status-info+))
                             (propertize "✚" 'face face))
                            ((eq state 'needs-merge)
                             (if active (setq face 'mode-line-status-warning+))
                             (propertize "●" 'face face))
                            ((eq state 'needs-update)
                             (if active (setq face 'mode-line-status-warning+))
                             (propertize "⬆" 'face face))
                            ((memq state '(removed conflict unregistered))
                             (if active (setq face 'mode-line-status-error+))
                             (propertize "✖" 'face face))
                            (t
                             (if active (setq face 'mode-line-status-grayed-out+))
                             (propertize "✔" 'face face)))
                      " "
                      (propertize (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2))
                                  'face (if active face))
                      "  "))))))



;;Org Presentation
(use-package ox-reveal)
(setq  org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(use-package htmlize)
