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
    :init (progn
            (add-hook 'reason-mode-hook #'lsp-reason-mode-enable))
    :config (progn
              (spacemacs/declare-prefix-for-mode 'reason-mode "mg" "goto")
              (spacemacs/declare-prefix-for-mode 'reason-mode "mp" "peek")
              (spacemacs/declare-prefix-for-mode 'reason-mode "mf" "flycheck")

              (spacemacs/set-leader-keys-for-major-mode 'reason-mode
                "gn" 'lsp-ui-find-next-reference
                "gp" 'lsp-ui-find-prev-reference
                "gd" 'lsp-ui-peek-find-definitions
                "gr" 'xref-find-references
                "pr" 'lsp-ui-peek-find-references
                "r" 'lsp-rename
                "tl" 'lsp-ui-sideline-mode
                "td" 'lsp-ui-doc-mode
                "f" 'lsp-ui-flycheck-list))))

(defun reason--doc-render (str)
  "lol"
  (message str)
  "lol")

(defun reason/init-reason-mode ()
  (use-package reason-mode
    :defer t
    :mode ("\\.rei?\\'" . reason-mode)
    :init
    (progn
      (add-hook 'reason-mode-hook
                (lambda ()
                  (add-hook 'before-save-hook 'reason/refmt-before-save nil t)))

      (push '("reason" . reason-mode) markdown-code-lang-modes)

      (use-package company-lsp
        :defer t
        :init (progn
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
      (spacemacs/declare-prefix-for-mode 'reason-mode "mt" "toggle")

      (spacemacs/set-leader-keys-for-major-mode 'reason-mode
        "=" 'refmt
        "tr" 'spacemacs/toggle-reason-auto-refmt))))

;;; packages.el ends here
