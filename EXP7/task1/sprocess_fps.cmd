# Written By Aaron Spaulding
# Based on code written by Sadid Muneer
# Created for ECE 4225


# Define mesh
line x location= 0.0      spacing= 1.0<nm>  tag=SiTop        
line x location= 250.0<nm> spacing= 20.0<nm> tag=SiBottom                       
line y location= 0<um> spacing=50.0<nm>  tag=Left
line y location=1<um>  spacing=20.0<nm>  tag=Right

# Define the silicon substrate and simulation
region Silicon xlo=SiTop xhi=SiBottom ylo=Left yhi=Right
init concentration=1.0e+17<cm-3> field=Boron

# Start advanced calibration
AdvancedCalibration

# Define global meshing settings
grid set.min.normal.size=1<nm> set.normal.growth.ratio.2d=1.2
mgoals accuracy=1e-5
pdbSet Oxide Grid perp.add.dist 1e-7
pdbSet Grid NativeLayerThickness 1e-7


# Now we define the mask, implant n-type material, remove the mask and then anneal.
mask name=mask1 segments= {0.5<um> 1<um>}
photo mask=mask1 thickness=1<um>
implant Arsenic energy=@energy@<keV> dose=@dose@ tilt=7<degree>  rotation=0<degree> 
strip PhotoResist
diffuse  temperature=1000<C> time=30<min>


# Now we grow an oxide layer on the entire structure
diffuse temperature=1000<C> time=10<min> O2

#Deposit Silicon, define a mesh ...
deposit material=Si type=anisotropic thickness=100<nm> Arsenic concentration=1e+20<cm-3>
mask name=mask2 segments= {0<um> 0.25<um> 0.75<um> 1<um>}
photo mask=mask2 thickness=1<um>
etch material= {Silicon} type= anisotropic thickness=100<nm>
etch material= {Oxide} type= anisotropic thickness= 20<nm>
etch material= {Resist} type= anisotropic thickness= 1<um> 

struct tdr= n@node@_afterAnneal

grid set.Delaunay.type=boxmethod


#contact name="contact name" "method" "material" "coordinates"
contact name=anode box Silicon xlo=-0.01 xhi=0.01 ylo=0 yhi=0.1
contact name=cathode box Silicon xlo=-0.01 xhi=0.01 ylo=0.9 yhi=1
contact name=gate box Silicon xlo=-0.105 xhi=-0.125 ylo=0.25 yhi=0.75



struct tdr= n@node@

exit

