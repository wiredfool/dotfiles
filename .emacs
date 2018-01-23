(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "English")
 '(c-basic-offset 4)
 '(default-tab-width 4)
 '(delete-selection-mode 1)
 '(indent-tabs-mode nil)
 '(mode-require-final-newline nil)
 )
(if window-system
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "1ASC" :slant normal :weight normal :height 90 :width normal))))
 '(font-lock-keyword-face ((t (:foreground "purple"))))
 '(font-lock-string-face ((t (:foreground "blue"))))
 '(font-lock-type-name-face ((t (:foreground "black"))))
 '(font-lock-variable-name-face ((t (:foreground "MidnightBlue"))))
 )
)

; disable the damn splash screen
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;
; dev stuff, not required on servers
;

(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://stable.melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa-stable" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
;; note that setting `venv-location` is not necessary if you
;; use the default location (`~/.virtualenvs`), or if the
;; the environment variable `WORKON_HOME` points to the right place
(setq venv-location "~")

(defun compile-parent (command)
  (interactive
   (let* ((dir (locate-dominating-file (buffer-file-name)
				       "Makefile"))
	  (command (concat "cd " dir " && make install")))
     (list (compilation-read-command command))))
  (compile command))

(defun test-parent (command)
  (interactive
   (let* ((dir (locate-dominating-file (buffer-file-name)
				       "Makefile"))
	  (command (concat "cd " dir " && make test")))
     (list (compilation-read-command command))))
  (compile command))


;; bind compiling to f5
(global-set-key [f5] 'compile-parent)
(global-set-key [f6] 'test-parent)

(setq compilation-scroll-output 1)

;; Start the emacsserver
;(if (and (fboundp 'server-running-p) 
;         (not (server-running-p)))
;   (server-start))


; magit key binding

(global-set-key (kbd "C-x g") 'magit-status)

; whitespace cleaner, only if currently clean.
(require 'ethan-wspace)
(global-ethan-wspace-mode 1)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

; required packages:
; magit
; ethan-wspace
; virtualenvwrapper
