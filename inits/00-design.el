(cd "~/")
(set-default-coding-systems 'utf-8-dos)
(define-key global-map [?¥] [?\\])
(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings)
(show-paren-mode 1)
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t)

;; 対応する括弧の色の設定
;;(setq show-paren-style 'expression)
;;(set-face-background 'show-paren-match-face "dark slate gray")
;;(set-face-foreground 'show-paren-match-face "white")
;;(setq-default transient-mark-mode t)

(transient-mark-mode 1)	; 選択範囲をハイライト
(set-face-background 'region "#005566")
 
(show-paren-mode t) ; 対応する括弧をハイライト
;; マッチした場合の色
(set-face-background 'show-paren-match-face "#008844")
(set-face-foreground 'show-paren-match-face "#ffffff")
;; マッチしていない（括弧の対応に不整合がある）場合の色
(set-face-background 'show-paren-mismatch-face "#880000")
(set-face-foreground 'show-paren-mismatch-face "#ffff00")

(set-face-foreground 'font-lock-regexp-grouping-backslash "#666")
(set-face-foreground 'font-lock-regexp-grouping-construct "#f60")
 

;; disable beep
(setq ring-bell-function 'ignore)

;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 90))

;; カレントウィンドウの透明度を変更する (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 90)

;; 最近使ったファイルを表示
;;(require 'recentf)
;;(recentf-mode 1)
;;(setq recentf-max-menu-items 10)
;;(setq recentf-max-saved-items 10)

;; save a place which had been edited to last
;;(when (require 'saveplace nil t)
;;  (setq-default save-place t)
;;  (setq save-place-file "~/.emacs.d/saved-places"))

(when (require 'saveplace nil t)
  (setq-default save-place t)
  (setq save-place-file "~/.emacs.d/saved-places"))

;; スクリプトを保存するとき、自動的にchmod +xを行う
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(line-number-mode t) ; 行番号。tなら表示、nilなら非表示
(column-number-mode t) ; 桁番号。tなら表示、nilなら非表示


(if (boundp 'window-system)
    (setq default-frame-alist
          (append (list
                   ;;'(foreground-color . "white")  ; 文字色
                   ;;'(background-color . "Black")  ; 背景色
                   ;;'(border-color     . "white")  ; ボーダー色
                   ;;'(mouse-color      . "white")  ; マウスカーソルの色
                   ;;'(cursor-color     . "white")  ; カーソルの色
                   '(cursor-type      . box)      ; カーソルの形状
		   '(font . "fontset-14")
                   '(top . 0) ; ウィンドウの表示位置（Y座標）
                   '(left . 0) ; ウィンドウの表示位置（X座標）
                   '(width . 99) ; ウィンドウの幅（文字数）
                   '(height . 61) ; ウィンドウの高さ（文字数）
                   )
                  default-frame-alist)))
(setq initial-frame-alist default-frame-alist )

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-linum-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(el-get-bundle solarized-emacs)
(load-theme 'solarized-dark t)
