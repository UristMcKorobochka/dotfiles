(use-package emacs
	     :config
	     (defun ret/delete-emacs-init ()
	       (interactive ((config "~/.emacs.d/emacs-init.el"))
			    (when config
			      (delete-file config))))
	     :hook ((kill-emacs-hook . ret/delete-emacs-init)))

(use-package modus-vivendi
	:config
