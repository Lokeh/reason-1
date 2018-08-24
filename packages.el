;;; packages.el --- reason layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Fredrik Dyrkell
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst reason-packages
  '(reason-mode
    company
    company-lsp
    (lsp-reason :location local)))

(defun reason/init-company ())

(defun reason/init-company-lsp ())

(defun reason/init-lsp-reason ()
  (message "Init lsp-reason")
  (use-package lsp-reason
    :demand t
    :init
    (add-hook 'reason-mode-hook #'lsp-reason-mode-enable)))

(defun reason/init-reason-mode ()
  (use-package reason-mode
    :defer t
    :mode ("\\.rei?\\'" . reason-mode)
    :init
    (progn
      (add-hook 'reason-mode-hook
                (lambda ()
                  (add-hook 'before-save-hook 'reason/refmt-before-save nil t)))

      (use-package company-lsp
        :defer t
        :init (progn
                (message "Initialize company reason")
                (spacemacs|add-company-backends
                  :backends company-lsp
                  :modes reason-mode)))

      (spacemacs|add-toggle reason-auto-refmt
        :documentation "Toggle automatic refmt on save."
        :status reason-auto-refmt
        :on (setq reason-auto-refmt t)
        :off (setq reason-auto-refmt nil)))
    :config
    (progn
      ;; (spacemacs/declare-prefix-for-mode 'reason-mode "mc" "compile")
      ;; (spacemacs/declare-prefix-for-mode 'reason-mode "mt" "toggle")
      ;; (spacemacs/declare-prefix-for-mode 'reason-mode "me" "errors/eval")
      ;; (spacemacs/declare-prefix-for-mode 'reason-mode "mg" "goto")
      ;; (spacemacs/declare-prefix-for-mode 'reason-mode "mh" "help/show")
      ;; (spacemacs/declare-prefix-for-mode 'reason-mode "mr" "refactor")
      ;; (spacemacs/declare-prefix-for-mode 'reason-mode "m=" "refmt")

      ;; (spacemacs/set-leader-keys-for-major-mode 'reason-mode
      ;;   "cr" 'refmt
      ;;   "==" 'refmt
      ;;   "tr" 'spacemacs/toggle-reason-auto-refmt)
      )
    ))

;;; packages.el ends here
