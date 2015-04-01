;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;---------------------------------------------------------------------;;
;; package                                                             ;;
;;---------------------------------------------------------------------;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;flymake
;;auto-complete
;;expand-region
;;tabbar
;;anything
;;tuareg-mode
;;



;;flymake
;;(el-get-bundle! flymake) ; don't load this after auto-complete

;;auto-complete
(el-get-bundle auto-complete
  (custom-set-variables `(ac-comphist-file ,(expand-file-name (concat user-emacs-directory "/.achist")))))
;;expand-region
(el-get-bundle! expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region)
;;tabbar
(el-get-bundle! tabbar)
(tabbar-mode 1)
(tabbar-mwheel-mode -1)
(setq tabbar-buffer-groups-function nil)
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
(setq tabbar-separator '(1.5))
(set-face-attribute
 'tabbar-default nil
 :family "Comic Sans MS"
 :background "LightSteelBlue4"
 :foreground "gray72"
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background "LightSteelBlue4"
 :foreground "grey72"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "LightSteelBlue2"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box nil)
(set-face-attribute
 'tabbar-separator nil
 :height 1.1)
(defvar my-tabbar-displayed-buffers
  '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
  "*Regexps matches buffer names always included tabs.")
(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
         (re (regexp-opt my-tabbar-displayed-buffers))
         (cur-buf (current-buffer))
         (tabs (delq nil
                     (mapcar (lambda (buf)
                               (let ((name (buffer-name buf)))
                                 (when (or (string-match re name)
                                           (not (memq (aref name 0) hides)))
                                   buf)))
                             (buffer-list)))))
    ;; Always include the current buffer.
    (if (memq cur-buf tabs)
        tabs
      (cons cur-buf tabs))))

(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
(global-set-key (kbd "<S-s-right>") 'tabbar-forward-tab)
(global-set-key (kbd "<S-s-left>") 'tabbar-backward-tab)

;; タブ上をマウス中クリックで kill-buffer
(defun my-tabbar-buffer-help-on-tab (tab)
  "Return the help string shown when mouse is onto TAB."
  (if tabbar--buffer-show-groups
      (let* ((tabset (tabbar-tab-tabset tab))
             (tab (tabbar-selected-tab tabset)))
        (format "mouse-1: switch to buffer %S in group [%s]"
                (buffer-name (tabbar-tab-value tab)) tabset))
    (format "\
mouse-1: switch to buffer %S\n\
mouse-2: kill this buffer\n\
mouse-3: delete other windows"
            (buffer-name (tabbar-tab-value tab)))))

(defun my-tabbar-buffer-select-tab (event tab)
  "On mouse EVENT, select TAB."
  (let ((mouse-button (event-basic-type event))
        (buffer (tabbar-tab-value tab)))
    (cond
     ((eq mouse-button 'mouse-2)
      (with-current-buffer buffer
        (kill-buffer)))
     ((eq mouse-button 'mouse-3)
      (delete-other-windows))
     (t
      (switch-to-buffer buffer)))
    ;; Don't show groups.
    (tabbar-buffer-show-groups nil)))

(setq tabbar-help-on-tab-function 'my-tabbar-buffer-help-on-tab)
(setq tabbar-select-tab-function 'my-tabbar-buffer-select-tab)

;;anything
(el-get-bundle! anything)
(el-get-bundle! anything-config)
(global-set-key "\C-x\C-b" 'anything-filelist+)
(global-set-key "\M-y" 'anything-show-kill-ring)
(global-set-key (kbd "C-a") 'anything)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)

;;tuareg-mode
(el-get-bundle tuareg-mode)

;(el-get-bundle! flycheck)
;(add-hook 'after-init-hook #'global-flycheck-mode)
;(el-get-bundle! flycheck-pos-tip)
;(eval-after-load 'flycheck
;  '(custom-set-variables
;   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
