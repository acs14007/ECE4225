;;;;;;;;;;;;Define Variables;;;;;;;;;;;;;;
;( define  VariableName    VariableValue )
(  define    Width             10       )
(  define    Length         (/ Width 20) )
(  define    DopingLevel       1e17      )



;;;;;;;;;;;;Draw Shapes;;;;;;;;;;;;;;
;( sdegeo:create-rectangle ( position x1 y1 z1 ) ( position x2 y2 z2 ) "Material" "RegionName" )
;( sdegeo:create-rectangle ( position 0 0 0 ) ( position Width Length 0 ) "Silicon" "R.Si" )

;End of lines don't matter! The following lines are the same as the above if you remove the comment marker ';' from each line
;(sdegeo:create-rectangle
;  (position x1 y1 z1)
;  (position x2 y2 z2)
;  "Material" "RegionName"
;)

( sdegeo:create-rectangle
  ( position   0       0     0 )
  ( position Length  Width   0 )
  "Silicon"   "R.Si"
)


;;;;;;;;;;;;Define Contacts;;;;;;;;;;;;;;
;Contacts must be defined (given a name) before they can be applied to an edge.
;(sdegeo:define-contact-set    ContactName     PixelWidth    ( color:rgb RValue GValue BValue )    Appearance )
( sdegeo:define-contact-set    "Left"          4             ( color:rgb   1      0      0 )          "##"    )
( sdegeo:define-contact-set    "Right"         4             ( color:rgb   0      1      0 )          "##"    )


;;;;;;;;;;;;Apply Contacts;;;;;;;;;;;;;;
;In this case, we apply a contact to an edge.  We use (find-edge-id (position x y z)) to find the name of the edge neareast coordinate (x y z)
;(sdegeo:define-2d-contact   EdgeId                                                      "ContactName"   )
( sdegeo:define-2d-contact   ( find-edge-id (position (/ Length 2) 0.0         0.0) )      "Left"          )
( sdegeo:define-2d-contact   ( find-edge-id (position (/ Length 2)   Width   0.0) )      "Right"         )
;( sdegeo:define-2d-contact   ( find-edge-id (position (/ Length 2) 0.0         0.0) )      "Left"          )
;( sdegeo:define-2d-contact   ( find-edge-id (position (/ Length 2)   Width   0.0) )      "Right"         )


;;;;;;;;;;;;Define Doping;;;;;;;;;;;;;;
;We first define a doping profile, and then apply it to the previously defined region R.Si
;( sdedr:define-constant-profile    ProfileName       DopantType                   DopingLevel )
( sdedr:define-constant-profile     "Const.Silicon"   "BoronActiveConcentration"   DopingLevel )


;;;;;;;;;;;;Apply Doping;;;;;;;;;;;;;;
;After defining the profile, we 'place' it everywhere the material is silicon
;( sdedr:define-constant-profile-material   PlacementName       ProfileName       Material  )
(  sdedr:define-constant-profile-material   "PlaceCD.Silicon"   "Const.Silicon"   "Silicon" )


;;;;;;;;;;;;Define Meshing;;;;;;;;;;;;;;
;Define a meshing strategy with maximum element sizes (xmax, ymax) and minimum element size (xmin, ymin)
(define xmin (/ Length 20))
(define xmax (/ Length 20))
(define ymin (/ Width 20))
(define ymax (/ Width 20))
;( sdedr:define-refinement-size   MeshingName    xmax ymax    xmin ymin )
(  sdedr:define-refinement-size   "RefDef.all"   xmax ymax    xmin ymin )


;;;;;;;;;;;;Apply Meshing;;;;;;;;;;;;;;
;( sdedr:define-refinement-region    PlacementName   MeshingName     RegionName )
(  sdedr:define-refinement-region    "PlaceRF.RSi"   "RefDef.all"    "R.Si"     )
;Alternatively, can use sdedr:define-refinement-material to place mesh in a given material

;Finally, build the mesh
;(sde:build-mesh    OptionalInputs    MeshFileName        )
( sde:build-mesh    "-a"              "Rectangle_geo_msh" )


;;;;;;;;;;;;Save File;;;;;;;;;;;;;;
;(sde:save-model   ModelName      )
( sde:save-model   "Rectangle_geo")

