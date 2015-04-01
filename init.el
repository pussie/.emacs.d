(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;fix versions of packages
(el-get-bundle tarao/el-get-lock)
(el-get-lock)

;;
(el-get-bundle init-loader
  (custom-set-variables '(init-loader-show-log-after-init 'error-only)
                        '(init-loader-byte-compile t))
  (init-loader-load))
