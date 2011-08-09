;;; parfait-mode.el --- prettifies your code by removing needless clutter
;;
;; Copyright (c) 2011 Quildreen Motta
;;
;; Version 0.1.0
;; Author: Quildreen Motta <quildreen@gmail.com>
;; URL:    http://github.com/killdream/parfait-mode
;;
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of GNU General Public Licence as published by the
;; Free Software Foundation; either version 2, or (at your option) any
;; later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public Licence for more details.
;;
;; You should have received a copy of the GNU General Public Licence
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;;
;;
;;; Commentary
;;
;; See README.md (or http://github.com/killdream/parfait-mode#readme)
;;
;;
;;; Installation
;;
;; In your shell:
;;
;;     $ cd ~/.emacs.d/vendor
;;     $ git clone git://github.com/killdream/parfait-mode
;;
;; In your emacs config:
;;
;;     (add-to-list 'load-path "/path/to/parfait-mode")
;;     (require 'parfait-mode)
;;
;; Load it with `M-x parfait-mode' in any buffer, or hook it to a major mode:
;;
;;     (add-hook 'js3-mode-hook 'parfait-mode)
;;
;;
;;; Acknowledgements
;;
;; The code is based on `lambda-mode' by Mark Triggs <mst@dishevelled.net>
;;
;;; Code

(defvar parfait-symtable '()
  "An association list mapping a regular expression to a replacement
  string.")


(defun parfait-add-symbol (regexp replacement)
  "Adds a mapping to the symbol table.

All words that match the given regexp will be replaced by the string
given as replacement."
  (add-to-list 'parfait-symtable (cons regexp replacement)))


(defun parfait-add-symbols (symbols)
  "Adds a series of mappings to the symbol table."
  (dolist (symbol symbols)
    (parfait-add-symbol (car symbol) (cdr symbol))))


(defun parfait-replace-match (symbol current-overlay)
  "Replaces the matched symbol."
  (unless (and current-overlay
               (eq (overlay-get current-overlay 'type) 'parfait-symbol))
    (let ((overlay (make-overlay (match-beginning 0) (match-end 0))))
      (overlay-put overlay 'type 'parfait-symbol)
      (overlay-put overlay 'evaporate t)
      (overlay-put overlay 'display symbol))))


(defun parfait-fontify (start end)
  "Fontifies a region of the current buffer, mapping symbols according
  to the symtable."
  (save-excursion
    (parfait-unfontify start end)
    (dolist (symbol parfait-symtable)
      (goto-char start)
      (while (re-search-forward (car symbol) end t)
        (parfait-replace-match (cdr symbol)
                               (car (overlays-at (match-beginning 0))))))))


(defun parfait-unfontify (start end)
  "Unfontifies a region of the current buffer, mapping symbols back to
  the actual text in the buffer."
  (mapc #'(lambda (overlay)
            (when (eq (overlay-get overlay 'type) 'parfait-symbol)
              (delete-overlay overlay)))
        (overlays-in start end)))
          

(define-minor-mode parfait-mode
  "Maps parts of the buffer to pretty symbols to remove visual clutter."
  :lighter " Parfait"
  (cond ((not parfait-mode)
         (jit-lock-unregister 'parfait-fontify)
         (parfait-unfontify (point-min) (point-max)))
        (t
         (parfait-fontify (point-min) (point-max))
         (jit-lock-register 'parfait-fontify))))
  
(provide 'parfait-mode)
;;; parfait-mode.el ends here
