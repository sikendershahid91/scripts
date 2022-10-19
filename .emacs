;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

(require 'package)
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))


(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ================================================================
;; --------------------- CUSTOM CHANGES BELOW ---------------------
;; ================================================================

;; map both delete keys 
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Adjust GUI Size 
(when (display-graphic-p)
(set-frame-height (selected-frame) 55)
(set-frame-width (selected-frame) 90)
)

;; Color scheme 
(set-background-color "grey18")
(set-foreground-color "LightSteelBlue1")

;; Adjust character insertions 
(setq require-final-newline t)
(setq next-line-add-newlines nil)
(setq-default tab-width 8 indent-tabs-mode nil)
(setq case-fold-search t)

(setq column-number-mode t)
(setq frame-title-format "%b")
(setq delete-auto-save-files t)
(global-linum-mode t)
(setq linum-format "%d")
(tool-bar-mode -1)
(defun dos2unix() (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))
       
(setq fortran-continuation-string "&")
(setq fortran-blink-matching-if "on")
(setq fortran-comment-region "Cssh991 ")
;; (if (not running-xemacs)
;;     (require 'mwheel') ;
;;     (mwheel-install) ;
;; )

;; Text customization 
(global-highlight-changes-mode t)
(global-set-key (kbd "M-h") 'highlight-changes-mode)
(show-paren-mode 1 )
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match "grey13")
(global-set-key [(meta down)] (lambda () (interactive) (scroll-up 4)) )
(global-set-key [(meta up)] (lambda () (interactive) (scroll-down 4)) )

       
;; Octave/MATLAB mode customization
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(setq octave-comment-char ?%)
(setq octave-comment-region "% ")
(defface matlab-strings
  '((t (:foreground "green" :weight normal)))
  "String color for Matlab")
(font-lock-add-keywords 'octave-mode '(("\'\\(\\(?:.\\)*?[^\\]\\)\'" 0 'matlab-strings t)))
(font-lock-add-keywords 'octave-mode '(("\\.\\.\\..*" . font-lock-comment-face)))
;; (autoload 'octave-mode "octave" t)
;; (add-to-list
;;  'auto-mode-alist
;;  '("\\.m$" . octave-mode))
;; (setq octave-comment-char ?%)
;; (setq comment-start "% ")


;; ORG mode customization 
(transient-mark-mode 1)
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; Ediff customization
(setq ediff-split-window-function 'split-window-horizontally)

;; Interactive window resizing
(global-set-key [(control kp-add)] (lambda () (interactive) (enlarge-window-horizontally 1)) )
(global-set-key [(control kp-subtract)] (lambda () (interactive) (shrink-window-horizontally 1)) )
(global-set-key [(meta kp-add)] (lambda () (interactive) (enlarge-window 1)) )
(global-set-key [(meta kp-subtract)] (lambda () (interactive) (shrink-window 1)) )

;; BELOW OBS BECAUSE OF ABOVE - START 
;; Window resizing
;; (defvar resize-frame-map
;;   (let ((map (make-keymap)))
;;        (define-key map (kbd "<up>") 'enlarge-window)
;;        (define-key map (kbd "<down>") 'shrink-window)
;;        (define-key map (kbd "<right>") 'enlarge-window-horizontally)
;;        (define-key map (kbd "<left>") 'shrink-window-horizontally)
;;        (set-char-table-range (nth 1 map) t 'resize-frame-done)
;;        map))
;; (define-minor-mode resize-frame
;;   "Use C-c C-c to move windows"
;;   :init-value nil
;;   :lighter " ResizeFrame"
;;   :keymap resize-frame-map
;;   :global t
;;   (if (<= (length (window-list)) 1)
;;       (progn (setq resize-frame nil)
;;         (message "There is only one frame"))
;;       (message "move arrow keys to adjust window")))
;; (defun resize-frame-done ()
;;   (interactive)
;;   (setq resize-frame nil)
;;   (message "Done"))       
;; (global-set-key (kbd "C-c C-c") 'resize-frame)
;; (provide 'resize-frame)
;; -------------------------- - END
       
