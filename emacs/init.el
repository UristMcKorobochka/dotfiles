;;; init.el -- Personal configurat file -*- lexical binding: t-*-

;; Copyright (c) 2021-2021 Kholodkov Iurii <urist.mckorobochka@gmail.com>

;; Author: Kholodkov Iurii <urist.mckorobochka@gmail.com>
;; URL: no yet
;; Version: 0.0.0
;; Package-Requires: ((emacs "28.0"))

;; This files is NO/ part of GNU Emas.

;; Tis file is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation, either version 3 of the License, or (at your option) any later version.
;;
;; This file is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. see the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License along with this file. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This file sets up the essentials for incorporating my init org file. This is known as "literate programming", which I think is particularly helpful for sharing Emacs configurations with a wider audience that includes new or potential users (I am still very new myself).
;;
;; See my dotfiles: https:notyet

;;; Code:

;; I create an "el" version of my Org Emacs configuration subtree as a final step
;; before closing down Emacs. This is done to load the latest version of my code upon startup.
;; Also helps with initialisation times. Not that I care too much about
;; those... Hence why I no longer bother with deferring package loading either by default or on a case-by-case basis.
(let* ((conf (concat user-emacs-directory "ret-emacs"))
       (el (concat conf ".el"))
       (org (concat conf ".org")))
  (if (file-exists-p el)
      (load-file el)
    (require 'org)
    (org-babel-load-file org)))
       
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")
     (eval let
	   ((root-dir-unexpanded
	     (locate-dominating-file default-directory ".dir-locals.el")))
	   (when root-dir-unexpanded
	     (let*
		 ((root-dir
		   (expand-file-name root-dir-unexpanded))
		  (root-dir*
		   (directory-file-name root-dir)))
	       (unless
		   (boundp 'geiser-guile-load-path)
		 (defvar geiser-guile-load-path 'nil))
	       (make-local-variable 'geiser-guile-load-path)
	       (require 'cl-lib)
	       (cl-pushnew root-dir* geiser-guile-load-path :test #'string-equal))))
     (eval setq-local guix-directory
	   (locate-dominating-file default-directory ".dir-locals.el")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
