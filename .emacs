;; Erik Westrup's Emacs configuration.

(menu-bar-mode -1) 			;; Don't display the menu.
(global-hl-line-mode 1) 		;; Highlight cursor line.
(setq mumamo-background-colors nil) 	;; Disable chunk coloring.

(require 'linum)			;; Show line numbers.
(global-linum-mode 1)
(setq linum-format "%3d ")

;; kernelstyle
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8))

(setq tramp-default-method "ssh")
(auto-compression-mode 1)

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


;; Set up UTF-8.
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; From Emacs wiki
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE 
(set-clipboard-coding-system 'utf-16le-dos)



(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

  (setq path-to-ctags "/usr/bin/ctags") ;; <- your ctags path here

;; Comman for creating a TAGS-file with ctags.
  (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )
