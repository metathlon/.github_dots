;;; ~/.doom.d/nueva_config/org.caputre.config.el -*- lexical-binding: t; -*-

(setq org-capture-templates
'(
    ("t" "To Do Item" entry (file caronte/org-agenda-FILE-tareas)
    "* TODO %^{Description} %^{Tipo: | :trabajo: | :personal: }\n%U\n%?" :prepend t)
    ("r" "Receta Manual" entry (file caronte/org-agenda-FILE-recetas)
    "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
    ("R" "Receta Automatica" entry (file caronte/org-agenda-FILE-recetas)
      "%(org-chef-get-recipe-from-url)" :empty-lines 1)
    ;; ("i" "org-protocol-capture" entry (file caronte/org-agenda-FILE-inbox)
    ;;  "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
    ("e" "email" entry (file caronte/org-agenda-FILE-emails)
    "* TODO %^{Descripcion_Breve} [#C] EMAIL: %a\nFROM: %:from:\nSUBJECT: %:subject\n%U\n" :clock-in t :clock-resume t)
    ;; "* TODO %^{Descripcion_BREVE} [#A] Reply: %a\n%U" :prepend t)
    ;; ("l" "Link" entry (file caronte/org-agenda-FILE-links)
    ;;   "* %? %^L %^g \n%T" :prepend t)

    )
)
