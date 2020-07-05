(defconst bazel-packages
  '(
    bazel-mode
    )
  "Packages for bazel.")

(defun bazel/init-bazel-mode ()
  (use-package bazel-mode
    :mode (("\\.bzl\\'"      . bazel-mode)
           ("\\.bazel\\'"    . bazel-mode)
           ("\\.BUILD\\'"    . bazel-mode)
           ("BUILD\\'"       . bazel-mode)
           ("WORKSPACE\\'"   . bazel-mode))
    )
  )
