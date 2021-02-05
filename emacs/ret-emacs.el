(use-package emacs
	     :config
	     (defun ret/delete-emacs-init ()
	       (interactive ((config "~/.config/emacs/ret-emacs.el"))
			    (when config
			      (delete-file config))))
	     :hook (kill-emacs-hook . ret/delete-emacs-init))

(use-package emacs
  :config
  (load-theme 'modus-vivendi t)
  )

(use-package emacs
  :config
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (horizontal-scroll-bar-mode -1))
