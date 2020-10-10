
;; Defined Parameters:

;; Contact Sets:
(sdegeo:define-contact-set "Left" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "Right" 4 (color:rgb 0 1 0 )"##" )

;; Work Planes:
(sde:workplanes-init-scm-binding)

;; Defined ACIS Refinements:
(sde:refinement-init-scm-binding)

;; Reference/Evaluation Windows:
(sdedr:define-refeval-window "RefWin.stack" "Rectangle" (position 0 0 0) (position 0.15 0.01 0))

;; Restore GUI session parameters:
(sde:set-window-position 0 0)
(sde:set-window-size 840 800)
(sde:set-window-style "Windows")
(sde:set-background-color 0 127 178 204 204 204)
(sde:scmwin-set-prefs "Liberation Sans" "Normal" 8 100 )
