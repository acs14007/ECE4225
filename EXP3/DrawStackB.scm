;Written by: Sadid Muneer (09/27/2017)


;Reinitializing SDE 
(sde:clear)

;Selecting default Boolean expression
;"ABA" is used to subtracts all overlapping regions from the existing regions.
(sdegeo:set-default-boolean "ABA")

;;;;;;;;;;;;Define Variables;;;;;;;;;;;;;;
;( define  VariableName    VariableValue )
(define    LMetal	   30e-3)
(define    LOxide	   30e-3)
(define    LNitride        30e-3)
(define    Height	   10e-3)
(define    TotalLength     (+ LNitride (+ LOxide (+ LMetal (+ LOxide LMetal)))))
(define    DopingLevel     1e20)


;;;;;;;;;;;;Draw Shapes;;;;;;;;;;;;;;
;( sdegeo:create-rectangle ( position x1 y1 z1 ) ( position x2 y2 z2 ) "Material" "RegionName" )

(sdegeo:create-rectangle
  (position 0       0       0)
  (position LMetal  Height  0)
  "Silicon" "R.M1"
)

(sdegeo:create-rectangle
  (position LMetal             0       0)
  (position (* 2 LMetal)       Height  0)
  "SiO2" "R.Ox1"
)

(sdegeo:create-rectangle
  (position (* 2 LMetal)  0       0)
  (position (* 3 LMetal)  Height  0)
  "Si3N4" "R.N"
)

(sdegeo:create-rectangle
  (position (* 3 LMetal)  0       0)
  (position (* 4 LMetal)  Height  0)
  "SiO2" "R.Ox2"
)

(sdegeo:create-rectangle
  (position (* 4 LMetal)  0       0)
  (position (* 5 LMetal)  Height  0)
  "Silicon" "R.M2"
)



;;;;;;;;;;;;Define Contacts;;;;;;;;;;;;;;
;Contacts must be defined (given a name) before they can be applied to an edge.
;(sdegeo:define-contact-set   ContactName   PixelWidth   (color:rgb RValue GValue BValue)   Appearance)
(sdegeo:define-contact-set  "Left"   4  (color:rgb 1 0 0)  "##")
(sdegeo:define-contact-set  "Right"  4  (color:rgb 0 1 0)  "##")


;;;;;;;;;;;;Apply Contacts;;;;;;;;;;;;;;
;In this case, we apply a contact to an edge.  We use (find-edge-id (position x y z)) to find the name of the edge neareast coordinate (x y z)
;(sdegeo:define-2d-contact   EdgeId   "ContactName")
(sdegeo:define-2d-contact
  (find-edge-id (position 0           (/ Height 2)  0))  "Left"
)
( sdegeo:define-2d-contact
  (find-edge-id (position TotalLength (/ Height 2)  0))  "Right"
)


;;;;;;;;;;;;Define Doping;;;;;;;;;;;;;;
;We first define a doping profile, and then apply it to the previously defined region R.Si
;( sdedr:define-constant-profile    ProfileName       DopantType                   DopingLevel )
( sdedr:define-constant-profile     "Const.Silicon"   "BoronActiveConcentration"   DopingLevel )


;;;;;;;;;;;;Apply Doping;;;;;;;;;;;;;;
;After defining the profile, we 'place' it everywhere the material is silicon
;( sdedr:define-constant-profile-material   PlacementName       ProfileName       Material  )
(  sdedr:define-constant-profile-material   "PlaceCD.Silicon"   "Const.Silicon"   "Silicon" )


;;;;;;;;;;;;Define a Window for Meshing;;;;;;;;;;;;;;;
;We will apply meshing on this window
(sdedr:define-refinement-window "RefWin.stack" "Rectangle"
  (position 0            0       0)
  (position TotalLength  Height  0)
)


;;;;;;;;;;;;Define Meshing;;;;;;;;;;;;;;
;Define a meshing strategy with maximum element sizes (xmax, ymax) and minimum element size (xmin, ymin)
(define xmin (/ LMetal 20))
(define xmax (/ LMetal 20))
(define ymin (/ Height 20))
(define ymax (/ Height 20))
;( sdedr:define-refinement-size   MeshingName    xmax ymax    xmin ymin )
(sdedr:define-refinement-size "RefDef.stack" xmax ymax    xmin ymin )


;;;;;;;;;;;;Apply Meshing;;;;;;;;;;;;;;
;Apply the mesh over the window
(sdedr:define-refinement-placement "PlaceRF.stack" "RefDef.stack"   "RefWin.stack")


;;;;;;;;;;;;Build the Mesh;;;;;;;;;;;;;;
;Finally, build the mesh
;(sde:build-mesh   OptionalInputs   MeshFileNam)
(sde:build-mesh  "-a"  "StackB_geo_msh")


;;;;;;;;;;;;Save File;;;;;;;;;;;;;;
;(sde:save-model   ModelName      )
( sde:save-model   "StackB_geo")



