(defun reason/refmt-before-save ()
  "Before save hook for automatic refmt."
  (when reason-auto-refmt
      (refmt)))
