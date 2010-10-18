;; This is the main start up file for emacs.  You can learn more
;; about this at handy sites like http://emacswiki.org/
;; 
;; This file causes emacs or xemacs to load up the correct elisp
;; files from ~/.emacs.d/* as well as any customization files.

;; Turn on debugging for this file
(setq debug-on-error t)

(load-library "~/.emacs.d/byte-code-cache")
(load-library "~/.emacs.d/elisp-load-dir")

(if (not (featurep 'aquamacs))
    (progn
      ;; Get the customization file, if needed
      (if (file-exists-p
           (setq custom-file
                 (concat "~/.emacs.d/custom-"
                         (int-to-string emacs-major-version))))
          (load-file custom-file))

      (message "Loading common .el files")
      (add-to-list 'load-path (expand-file-name "~/.emacs.d/common"))

      ;; Load the common lisp
      (elisp-load-dir "~/.emacs.d/common")

      ;; Load the Emacs or XEmacs specific lisp
      (if (featurep 'xemacs)
          (progn
            (message "Loading XEmacs .el files")
            (elisp-load-dir "~/.emacs.d/xemacs"))
        (progn
          (message "Loading Emacs .el files")
          (elisp-load-dir "~/.emacs.d/emacs")))
      ))

;; Load aquamacs specific lisp
;; http://www.emacswiki.org/emacs/CustomizeAquamacs
(if (featurep 'aquamacs)
    (progn
      (message "Loading Aquamacs .el files")
      (elisp-load-dir "~/.emacs.d/aquamacs")))

(message "Yay! Personal .el files are loaded!")

;; Turn off debugging now that we're done
(setq debug-on-error nil)

;; EOF
