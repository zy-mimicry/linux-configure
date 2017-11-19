;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; - * - mode : emacs-lisp - * -
;; Note : If you want to use it , install evil-package is needed.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Codes:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mimicry/as-vim-control-u ()
  "Just like vim's C-u in insert mode.
Note that: Just delete to this line , I think it's useful."
  (interactive)
  (progn
    (kill-region (point) (progn
                           (beginning-of-line) (point)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Key map [evil-insert-mode]:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key evil-insert-state-map (kbd "C-u") 'mimicry/as-vim-control-u)
(define-key evil-insert-state-map (kbd "C-h") 'paredit-backward-delete)
(define-key evil-insert-state-map (kbd "C-d") 'paredit-forward-delete)
(define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Key map [evil-normal-mode]:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key evil-normal-state-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-normal-state-map (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)
(define-key evil-normal-state-map (kbd "M-,") 'pop-tag-mark)
(define-key evil-normal-state-map (kbd "C-t") 'read-only-mode)

(provide 'init-mimicry-package)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; - * - end of file - * -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
