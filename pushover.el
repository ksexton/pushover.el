;;; pushover.el -- Send notifications from emacs to pushover.net

(defcustom pushover-token nil
  "pushover application token")

(defcustom pushover-user-key nil
  "pushover user-key")

(defun pushover-notify (title msg)
  (let ((url-request-method "POST")
	(url-request-data (concat "token=" pushover-token
				  "&user=" pushover-user-key
				  "&title=" title
				  "&message=" msg)))
    (url-retrieve "https://api.pushover.net/1/messages.json" 'pushover-kill-url-buffer)))

(defun pushover-kill-url-buffer (status)
  "Kill the buffer returned by `url-retrieve'."
  (kill-buffer (current-buffer)))

(provide 'pushover)
