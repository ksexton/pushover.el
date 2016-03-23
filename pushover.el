;;; pushover.el -- Send notifications from emacs to pushover.net


;;; Commentary:
;;;
;;; Send notifications from Emacs to a mobile device via pushover.net and its
;;; app.  You need your user key (available in the app and from
;;; https://pushover.net if you are logged in), and an application token from
;;; https://pushover.net/apps/build.

;;; Code:

(require 'cl-lib)

(defcustom pushover-token nil
  "Pushover application token.")

(defcustom pushover-user-key nil
  "Pushover user-key.")

(defun pushover-notify (title msg &optional url url-title)
  "Send a notification via pushover.
TITLE is the notification title, MSG is the message body.  URL is
the optional supplementary URL, URL-TITLE is a display title for
the url."
  (interactive "MNotification title (RET for none): \nMNotification body: \nMURL (RET for none): \nMURL title (RET for none): ")
  (cl-flet ((presentp (param) (and param (> (length param) 0))))
    (let ((url-request-method "POST")
          (url-request-data (concat "token=" pushover-token
                                    "&user=" pushover-user-key
                                    "&message=" msg
                                    (when (presentp title)
                                      (concat  "&title=" title))
                                    (when (presentp url)
                                      (concat "&url=" url))
                                    (when (presentp url-title)
                                      (concat "&url_title=" url-title)))))
      (url-retrieve "https://api.pushover.net/1/messages.json" 'pushover-kill-url-buffer))))

(defun pushover-kill-url-buffer (status)
  "Kill the buffer returned by `url-retrieve'."
  (kill-buffer (current-buffer)))

(provide 'pushover)

;;; pushover.el ends here
