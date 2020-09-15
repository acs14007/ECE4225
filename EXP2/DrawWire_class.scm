;Written by: Jacob Scoggin (2016)
;Modified by: Sadid Muneer (09/26/2017)
;Modified by: Raihan Sayeed Khan (09/10/2018)

;;;;;;;;;;;;Define Variables;;;;;;;;;;;;;;
;( define  VariableName    VariableValue )
(define DopingLevel 1e18)

;Student ID
(define First 1)
(define Second 5)
(define Third 1)
(define Fourth 0)
(define Fifth 4)
(define FirstSecond (+ (* First 10) Second))
(define FourthFifth (+ (* Fourth 10) Fifth))

;Wire parameters
(define WBase 20)
(define HBase1 10)
(define HBase2 (+ 12 (/ FirstSecond 10)))
(define WBridge (+ 5 (/ Third 5)))
(define HBridge (+ 30 (/ FourthFifth 10) ))

;;;;;;;;;;;;Draw Shapes;;;;;;;;;;;;;;
;Fill the rest of the co-ordinates
(define x1 0)
 ; DO THIS for all x and all yyyyy (10 pairs of x and y)
(define y1 0)


;Device size
(define height (- y8 y1))
(define width  (- x2 x1))

;Coordinates of points
;Define the rest of the points
(define N1 ( position x1  y1  0))


;Create polygon
;(sdegeo:create-polygon (list N1 N2 N3 N4 N5 ...) "Material" "RegionName" )
(sdegeo:create-polygon (list N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12) "Silicon" "R.Si")


;;;;;;;;;;;;Define Contacts;;;;;;;;;;;;;;
;Contacts must be defined (given a name) before they can be applied to an edge.
;(sdegeo:define-contact-set   ContactName   PixelWidth   (color:rgb RValue GValue BValue)   Appearance)
(sdegeo:define-contact-set "TopBridge"    4  (color:rgb 1 0 0)  "##")
(sdegeo:define-contact-set "BottomBridge" 4  (color:rgb 0 1 0)  "##")


;;;;;;;;;;;;Apply Contacts;;;;;;;;;;;;;;
;In this case, we apply a contact to an edge.  We use (find-edge-id (position x y z)) to find the name of the edge neareast coordinate (x y z)
;(sdegeo:define-2d-contact   EdgeId   "ContactName")
(sdegeo:define-2d-contact  (find-edge-id (position (+ x1 (/ WBase 2)) y1 0))  "TopBridge"   )
(sdegeo:define-2d-contact  (find-edge-id (position (+ x1 (/ WBase 2)) y8 0))  "BottomBridge")


;;;;;;;;;;;;Define Doping;;;;;;;;;;;;;;
;We first define a doping profile, and then apply it to the previously defined region R.Si
;( sdedr:define-constant-profile    ProfileName       DopantType                   DopingLevel )
(sdedr:define-constant-profile  "Const.Silicon"  "BoronActiveConcentration"  DopingLevel)


;;;;;;;;;;;;Apply Doping;;;;;;;;;;;;;;
;After defining the profile, we 'place' it everywhere the material is silicon
;( sdedr:define-constant-profile-material   PlacementName       ProfileName       Material  )
(sdedr:define-constant-profile-material "PlaceCD.Silicon" "Const.Silicon" "Silicon")


;;;;;;;;;;;;Define Bridge Window;;;;;;;;;;;;;;;
;This window will be used to apply a dense mesh on the bridge
;(sdedr:define-refinement-window "RefWin.Bridge"  "Rectangle"
;  (position x11 y11 0)
;  (position x5  y5  0)
;)


;;;;;;;;;;;;Define Meshing;;;;;;;;;;;;;;
;Define a meshing strategy with maximum element sizes (xmax, ymax) and minimum element size (xmin, ymin)
;First define a coarse mesh for the overall structure
(define xmin (/ width 20))
(define xmax (/ width 20))
(define ymin (/ height 100))
(define ymax (/ height 100))
(sdedr:define-refinement-size  "RefDef.all"  xmax  ymax  xmin  ymin)

;Now define a tight mesh for the bridge
;(define xminBridge (/ WBridge 10))
;(define xmaxBridge (/ WBridge 10))
;(define yminBridge (/ HBridge 100))
;(define ymaxBridge (/ HBridge 100))
;(sdedr:define-refinement-size  "RefDef.Bridge"  xmaxBridge  ymaxBridge  xminBridge  yminBridge)


;;;;;;;;;;;;Apply Meshing;;;;;;;;;;;;;;
;( sdedr:define-refinement-region    PlacementName   MeshingName     RegionName)
;First apply the coarse mesh
(sdedr:define-refinement-region  "PlaceRF.RSi"  "RefDef.all"  "R.Si")
;Now apply the tight mesh
;(sdedr:define-refinement-placement  "PlaceRF.Bridge"  "RefDef.Bridge"  "RefWin.Bridge")
;Alternatively, can use sdedr:define-refinement-material to place mesh in a given material


;;;;;;;;;;;;Build the Mesh;;;;;;;;;;;;;;

;(sde:build-mesh   OptionalInputs   MeshFileNam)
( sde:build-mesh  "-a"  "Wire_geo_msh" )


;;;;;;;;;;;;Save File;;;;;;;;;;;;;;
;(sde:save-model   ModelName)
( sde:save-model   "Wire_geo")

