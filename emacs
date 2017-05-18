(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("73a13a70fd111a6cd47f3d4be2260b1e4b717dbf635a9caee6442c949fad41cd" "1b27e3b3fce73b72725f3f7f040fd03081b576b1ce8bbdfcb0212920aec190ad" "721bb3cb432bb6be7c58be27d583814e9c56806c06b4077797074b009f322509" "c79c2eadd3721e92e42d2fefc756eef8c7d248f9edefd57c4887fbf68f0a17af" "158013ec40a6e2844dbda340dbabda6e179a53e0aea04a4d383d69c329fba6e6" "da538070dddb68d64ef6743271a26efd47fbc17b52cc6526d932b9793f92b718" "9b1c580339183a8661a84f5864a6c363260c80136bd20ac9f00d7e1d662e936a" "cf284fac2a56d242ace50b6d2c438fcc6b4090137f1631e32bedf19495124600" "66aea5b7326cf4117d63c6694822deeca10a03b98135aaaddb40af99430ea237" "de0b7245463d92cba3362ec9fe0142f54d2bf929f971a8cdf33c0bf995250bcf" "251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" "01e067188b0b53325fc0a1c6e06643d7e52bc16b6653de2926a480861ad5aa78" "256a381a0471ad344e1ed33470e4c28b35fb4489a67eb821181e35f080083c36" "b563a87aa29096e0b2e38889f7a5e3babde9982262181b65de9ce8b78e9324d5" "e30f381d0e460e5b643118bcd10995e1ba3161a3d45411ef8dfe34879c9ae333" "003a9aa9e4acb50001a006cfde61a6c3012d373c4763b48ceb9d523ceba66829" "af717ca36fe8b44909c984669ee0de8dd8c43df656be67a50a1cf89ee41bde9a" "d21135150e22e58f8c656ec04530872831baebf5a1c3688030d119c114233c24" "c616e584f7268aa3b63d08045a912b50863a34e7ea83e35fcab8537b75741956" "228c0559991fb3af427a6fa4f3a3ad51f905e20f481c697c6ca978c5683ebf43" "d6db7498e2615025c419364764d5e9b09438dfe25b044b44e1f336501acd4f5b" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "6db9acac88c82f69296751e6c6d808736d6ff251dcb34a1381be86efc14fef54" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "2b8dff32b9018d88e24044eb60d8f3829bd6bbeab754e70799b78593af1c3aba" "b181ea0cc32303da7f9227361bb051bbb6c3105bb4f386ca22a06db319b08882" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(eval-expression-debug-on-error nil)
 '(flymake-google-cpplint-command "/usr/bin/cpplint")
 '(package-selected-packages
   (quote
    (geiser paredit flymake-cursor flymake-google-cpplint iedit auto-complete-c-headers auto-complete key-chord airline-themes helm zygospore projectile company use-package solarized-theme relative-line-numbers evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "#073642" :foreground "#586e75" :underline nil :weight normal)))))

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(require 'evil)
(evil-mode t)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(defun relative-abs-line-numbers-format (offset)
  "The default formatting function.
Return the absolute value of OFFSET, converted to string."
  (if (= 0 offset)
      (format "%3d \u2502" (line-number-at-pos))
    (format "%3d \u2502" (abs offset))))
(setq relative-line-numbers-format 'relative-abs-line-numbers-format)
(global-relative-line-numbers-mode)

(load-theme 'solarized-dark)

(require 'powerline)
(powerline-default-theme)

(require 'auto-complete)
;; do defafult config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;;define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-pc-linux-gnu/6.3.1/../../../../include/c++/6.3.1
/usr/lib/gcc/x86_64-pc-linux-gnu/6.3.1/../../../../include/c++/6.3.1/x86_64-pc-linux-gnu
/usr/lib/gcc/x86_64-pc-linux-gnu/6.3.1/../../../../include/c++/6.3.1/backward
/usr/lib/gcc/x86_64-pc-linux-gnu/6.3.1/include
/usr/local/include
/usr/lib/gcc/x86_64-pc-linux-gnu/6.3.1/include-fixed
/usr/include"))
;; call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

(require 'iedit)
(defun iedit-dwim (arg)
  "Starts iedit but uses \\[narrow-to-defun] to dimit its scope."
  (interactive "P")
  (if arg
      (iedit-mode)
    (save-excursion
      (save-restriction
	(widen)
	;; this function determines the scope of `iedit-start'.
	(if iedit-mode
	    (iedit-done)
	  ;; `current-word' can of course be replaced by other functions.
	  (narrow-to-defun)
	  (iedit-start (iedit-regexp-quote (current-word)) (point-min) (point-max)))))))
(global-set-key (kbd "C-;") 'iedit-dwim)

;; start flymake-google-cpplint-load
;; define a function for flymake initialization
(defun my:flymake-google-init()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/bin/cpplint"))
  (flymake-google-cpplint-load))
;;(add-hook 'c-mode-hook 'my:flymake-google-init)
;;(add-hook 'c++-mode-hook 'my:flymake-google-init)

;; turn on Semantic
(semantic-mode 1)
;; define a function which adds semantic as a suggestion
;; backend to auto ocmplete and hook this function c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

(global-semantic-idle-scheduler-mode -1)

(require 'airline-themes)
(load-theme 'airline-wombat)

(setq-default c-deault-style "linux"
	      c-basic-offset 4)
(set-window-fringes nil 0 0)

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-normal-state)

(require 'paredit)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)


