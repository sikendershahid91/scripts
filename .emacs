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

(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
(cond ((not running-xemacs)
       (global-font-lock-mode t)

(set-frame-height (selected-frame) 55)
(set-frame-width (selected-frame) 90)
(setq require-final-newline t)
(setq next-line-add-newlines nil)
(setq-default tab-width 8 indent-tabs-mode nil)
(setq case-fold-search t)
(setq column-number-mode t)
(set-background-color "grey13")
(set-foreground-color "LightSteelBlue1")
(setq frame-title-format "%b")
(setq delete-auto-save-files t)
(global-linum-mode t)
(setq linum-format "%d")
(tool-bar-mode -1)
(defun dos2unix() (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(autoload 'octave-mode "octave" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . octave-mode))
(setq octave-comment-char ?%)
(setq comment-start "% ")
