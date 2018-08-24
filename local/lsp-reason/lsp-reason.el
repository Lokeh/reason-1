;;; lsp-ocaml.el --- Reason support for lsp-mode  -*- lexical-binding: t; -*-

(require 'lsp-mode)
(require 'reason-mode)

(defun lsp-reason--render-code (str)
  "Renders markup returned by the reason-language-server"
  (ignore-errors
    (with-temp-buffer
      (delay-mode-hooks (reason-mode))
      (insert str)
      (font-lock-ensure)
      (buffer-string))))

(defun lsp-reason--initialize-client (client)
  (message "Initializing reason client")
  (lsp-provide-marked-string-renderer client "reason" #'lsp-reason--render-code))

(lsp-define-stdio-client lsp-reason-mode
                         "reason"
                         (lambda () default-directory)
                         '("/Users/will/Downloads/reason-language-server/reason-language-server.exe")
                         :initialize #'lsp-reason--initialize-client)

(provide 'lsp-reason)

;;; lsp-reason.el ends here
