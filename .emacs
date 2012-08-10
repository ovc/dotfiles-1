;; Erik Westrup's Emacs configuration.

;;; Environment
(add-to-list 'load-path "~/.emacs.d/")		 ;; Add folder to load path.

;;; Keyboard shortcuts.
(global-set-key [f7] 'global-hl-line-mode)	;; Toggle line higlight.
(global-set-key "\C-h" 'backward-delete-char)	;; ^H as expected.

;;; Settings
(menu-bar-mode -1) 				;; Disable the menu bar.
(global-hl-line-mode 1) 			;; Highlight cursor line.
(auto-compression-mode 1)			;; Allow editing of compressed files.
(setq mumamo-background-colors nil) 		;; Disable chunk coloring.
(setq tramp-default-method "ssh")		;; Use ssh by default for editing remote files.
(setq inhibit-startup-message t)		;; Hide welcome screen.
(put 'downcase-region 'disabled nil)		;; Enable lower case conversion of words.
(put 'upcase-region 'disabled nil)		;; Enable upper case conversion of words.

;; Show line numbers.
(require 'linum)
(global-linum-mode 1)
(setq linum-format "%4d ")
(setq flyspell-issue-welcome-flag nil)

;; Linux kernel coding style.
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8))

;; Set up UTF-8.
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; From Emacs wiki.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE.
(set-clipboard-coding-system 'utf-16le-dos)


;; Ctags.
(setq path-to-ctags "/usr/bin/ctags")	 ;; Path to ctags binary.
;; Command for creating a TAGS-file with ctags.
  (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )


;; Highligt programming comment tags.
(add-hook 'c-mode-common-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):?" 1 font-lock-warning-face t)))))

;;; Plugins.
;; Column marker.
(require 'column-marker)
(add-hook 'c-mode-hook (lambda () (interactive) (column-marker-1 80))) ;; Mark the 81st column in c-mode.
