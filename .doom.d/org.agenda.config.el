;;; ~/.doom.d/nueva_config/org.agenda.config.el -*- lexical-binding: t; -*-

;; ** Agenda

;; Hay un par de cosas a tener en cuenta en esta sección. Si quieres una agenda
;; /normal/ en la que se ve varios días, te interesa saber qué día es el primero de
;; la semana, para indicarle a la agenda que te saque de lunes a domingo, por
;; ejemplo.

;; Yo la agenda no la uso para eso, yo me organizo en dos nieveles:
;; - Medio/Largo plazo: calendario
;;   Cuando tengo que programar algo que va a durar mucho tiempo (pero un lapso
;;   determinado, por ejemplo cursos que imparto que son varios días a la semana
;;   durante un par de meses), lo programo en el calendario y es allí donde voy a
;;   buscarlo. No son tareas complejas y la propia descripción es suficiente.

;; - Corto/Larguísimo: agenda
;;   El corto plazo, *hoy*, lo veo y gestiono mediante la agenda.
;;   El plazo larguísimo lo gestiono mediante TODOs que veo en la agenda, por
;;   ejemplo /Terminar de programar las funciones comunes de R/, esa tarea no tiene
;;   un plazo de fin determinado, pero quiero tenerla presente, por eso va con un
;;   TODO a la agenda.

;; Es por este sistema de organización por lo que yo uso una agenda en la que veo
;; *UN DIA*, hoy, y varias secciones de TODO. Por esto me da igual en qué día
;; comience la semana, es más, necesito que *NO esté indicado*, para evitar que me
;; muestre ESE día en vez de *hoy*.

;; *** Basic config
;; #+BEGIN_SRC emacs-lisp
;;   ;; -- Metemos en agenda TODOS los archivos que hay en el directorio que he configurado en org.persojnal.el
;;   ;; La idea es que ahí tendré los TODO de proyectos, asesoramientos, personales... y como todo son cosas que hay que hacer... pues tanto da
(after! org
  (setq org-agenda-files
        (find-lisp-find-files caronte/org-agenda-directory"\.org$"))
)
;; #+END_SRC
;; *** Primer día de la semana
;; #+BEGIN_SRC emacs-lisp
;; (after! org
;;     ;; --- si quieres que la semana empice en lunes
;;     (setq org-agenda-start-on-weekday 1)
;; )
;; #+END_SRC

;; *** Mostrar solo un día
;; #+BEGIN_SRC emacs-lisp
(after! org
    ;; --- si quieres que se muestre solo HOY
    (setq org-agenda-start-on-weekday nil)
    (setq org-agenda-start-day "+0d")
    (setq org-agenda-span 1)
)
;; #+END_SRC
;; *** Funciones de control de elementos a mostrar
;; Estas funciones no son necesarias gracias a la super-agenda, pero las dejo aquí por si decidiera
;; usarlas en el futuro.
;; **** Función de gestión de prioridades
;; Con esta función podemos separar las tareas según prioridad
;; #+BEGIN_SRC emacs-lisp
(defun air-org-skip-subtree-if-priority (priority)
  "Saltarse un subtree de la agenda si tiene una prioridad de PRIORIDAD

  PRIORIDAD puede ser uno de los siguientews valores ?A, ?B, or ?C."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-lowest-priority priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))

;; #+END_SRC

;; **** Función para la gestión de hábitos
;; De momento no estoy usando los /hábitos/ de org-mode. Pero por si los uso, he
;; encontrado una función que permite discriminarlos
;; #+BEGIN_SRC emacs-lisp
(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))
;; #+END_SRC

;; ** Super-Agenda
;; La configuración normal de la agenda es *una paliza*. Creo que todo lo que hace
;; la super-agenda puede hacerse con la agenda normal pero sería mucho más esfuerzo
;; del que estoy dispuesto a dedicar, así que es por eso que uso el paquete
;; [[github:https://github.com/alphapapa/org-super-agenda][org-super-agenda]]

;; Este módulo es un trabajo en proceso me temo.

;; *** Hook
;; #+BEGIN_SRC emacs-lisp
(add-hook! 'org-agenda-mode-hook org-super-agenda-mode)
;; #+END_SRC

;; *** Vista personalizada
;; Primero definimos =org-agenda-custom-view= para luego poder llamarlo

;; #+BEGIN_SRC emacs-lisp
(defun org-agenda-custom-view (&optional arg)
  (interactive "P")
  (org-agenda arg "z"))
;; #+END_SRC

;; Lo que pretendemos hacer es algo así, ejemplo de agenda

;;  MAXIMA PRIORIDAD:
;;  * tarea 1
;;  * tarea 2
;;  ========================
;;  AGENDA DEL DIA
;;  ========================
;; Otras tareas de menos prioridad:
;;  * tarea 3
;;  * tarea 4

;;  Uno de los problemas a los que nos enfrentamos es a separar las prioridades

;; **** Vista personalizada
;; #+BEGIN_SRC emacs-lisp
(after! org
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
                          (:name "Siguiente"
                                 ;; :todo "NEXT"
                                 :scheduled future
                                 :order 1)
                          (:name "Fecha limite HOY"
                                 :deadline today
                                 :order 2)
                          (:name "Importante"
                                 ;; :tag "Important"
                                 :priority "A"
                                 :order 6)
                          (:name "Llegas TARDE"
                                 :deadline past
                                 :order 7)
                          (:name "Fecha limite proxima"
                                 :deadline future
                                 :order 8)
                          (:name "Trabajo"
                                 :tag "trabajo"
                                 :order 10)
                          (:name "Emails"
                                 :file-path "EMAILS.org"
                                 :order 12)
                          ;; (:name "Prueba"
                          ;;        ;; :tag "Project"
                          ;;        :auto-ts
                          ;;        :order 14)
                          ;; (:name "Emacs"
                          ;;        :tag "Emacs"
                          ;;        :order 13)
                          ;; (:name "Research"
                          ;;        :tag "Research"
                          ;;        :order 15)
                          (:name "Lista de libros a leer"
                                 :tag "libro"
                                 :order 30)
                          (:name "En espera"
                                 :todo "WAITING"
                                 :order 20)
                          (:name "Cosas que hacer"
                                 :priority< "A"
                                 :order 35)
                          (:name "Trivial"
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
)
;; #+END_SRC
