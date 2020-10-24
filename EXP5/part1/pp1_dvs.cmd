;Written by: Sadid Muneer (09/27/2017)


;Reinitializing SDE 
(sde:clear)

;Selecting default Boolean expression
;"ABA" is used to subtracts all overlapping regions from the existing regions.
(sdegeo:set-default-boolean "ABA")

;;;;;;;;;;;;Define Variables;;;;;;;;;;;;;;
;( define  VariableName    VariableValue )
(define    LMetal	   1)
(define    LOxide	   30e-3)
(define    LNitride        30e-3)
(define    Height	   1)
(define    TotalLength     2)
(define    DopingLevel     1e16)


;;;;;;;;;;;;Draw Shapes;;;;;;;;;;;;;;
;( sdegeo:create-rectangle ( position x1 y1 z1 ) ( position x2 y2 z2 ) "Material" "RegionName" )

(sdegeo:create-rectangle
  (position 0       0       0)
  (position 1  1  0)
  "Silicon" "R.pSi"
)

(sdegeo:create-rectangle
  (position 1             0       0)
  (position 2       1  0)
  "Silicon" "R.nSi"
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
( sdedr:define-constant-profile     "Const.pSilicon"   "BoronActiveConcentration"   DopingLevel )
( sdedr:define-constant-profile     "Const.nSilicon"   "ArsenicActiveConcentration"   DopingLevel )

;;;;;;;;;;;;Apply Doping;;;;;;;;;;;;;;
;After defining the profile, we 'place' it everywhere the material is silicon
;( sdedr:define-constant-profile-material   PlacementName       ProfileName       Material  )
(  sdedr:define-constant-profile-region   "PlaceCD.pSilicon"   "Const.pSilicon"   "R.pSi")
(  sdedr:define-constant-profile-region   "PlaceCD.nSilicon"   "Const.nSilicon"   "R.nSi")



;;;;;;;;;;;;Define a Window for Meshing;;;;;;;;;;;;;;;
;We will apply meshing on this window
(sdedr:define-refinement-window "RefWin.stack" "Rectangle"
  (position 0            0       0)
  (position TotalLength  Height  0)
)


;;;;;;;;;;;;Define Meshing;;;;;;;;;;;;;;
;Define a meshing strategy with maximum element sizes (xmax, ymax) and minimum element size (xmin, ymin)
(define xmin (/ 1 20))
(define xmax (/ 1 20))
(define ymin (/ 1 20))
(define ymax (/ 1 20))
;( sdedr:define-refinement-size   MeshingName    xmax ymax    xmin ymin )
(sdedr:define-refinement-size "RefDef.stack" xmax ymax    xmin ymin )


;;;;;;;;;;;;Apply Meshing;;;;;;;;;;;;;;
;Apply the mesh over the window
(sdedr:define-refinement-placement "PlaceRF.stack" "RefDef.stack"   "RefWin.stack")


;;;;;;;;;;;;Build the Mesh;;;;;;;;;;;;;;
;Finally, build the mesh
;(sde:build-mesh   OptionalInputs   MeshFileNam)
(sde:build-mesh  "-a"  "Stack_geo_msh")


;;;;;;;;;;;;Save File;;;;;;;;;;;;;;
;(sde:save-model   ModelName      )
( sde:save-model   "Stack_geo")




