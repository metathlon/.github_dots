;;; ~/.doom.d/org-super-agenda.conf.el -*- lexical-binding: t; -*-


(setq org-agenda-custom-commands
      '(("z" "Zuper Agenda!"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Hoy"
                                :time-grid t
                                :date today
                                ;; :todo "TODAY"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '(
                          (:name "Next to do"
                                 ;; :todo "NEXT"
                                 :scheduled future
                                 :order 1)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Importante"
                                 ;; :tag "Important"
                                 :priority "A"
                                 :order 6)
                          (:name "Overdue"
                                 :deadline past
                                 :order 7)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Assignments"
                                 :tag "Assignment"
                                 :order 10)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "Emacs"
                                 :tag "Emacs"
                                 :order 13)
                          (:name "Research"
                                 :tag "Research"
                                 :order 15)
                          (:name "To read"
                                 :tag "Read"
                                 :order 30)
                          (:name "Waiting"
                                 :todo "WAITING"
                                 :order 20)
                          (:name "trivial"
                                 :priority<= "C"
                                 :tag ("Trivial" "Unimportant")
                                 ;; :todo ("SOMEDAY" )
                                 :order 90)
                          (:name "Estadistica y metodología"
                                 :tag ("ESTADISTICA" "METODOLOGIA")
                                 :order 80
                                 )
                          (:discard (:tag ("Chore" "Routine" "Daily")))

                          ))))))))


;; (setq org-super-agenda-groups
;;       '((:name "Next Items"
;;                :time-grid t
;;                :tag ("NEXT" "outbox"))
;;         (:name "Important"
;;                :priority "A")
;;         (:name "Quick Picks"
;;                :effort< "0:30")
;;         (:priority<= "B"
;;                      :scheduled future
;;                      :order 1)))
