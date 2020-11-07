

line x location= 0.0      spacing= 1.0<nm>  tag=SiTop        
line x location= 250.0<nm> spacing= 20.0<nm> tag=SiBottom                       
line y location= 0<um> spacing=50.0<nm>  tag=Left
line y location=1<um>  spacing=20.0<nm>  tag=Right

region Silicon xlo=SiTop xhi=SiBottom ylo=Left yhi=Right
init concentration=1.0e+17<cm-3> field=Boron

AdvancedCalibration

grid set.min.normal.size=1<nm> set.normal.growth.ratio.2d=1.2
mgoals accuracy=1e-5
pdbSet Oxide Grid perp.add.dist 1e-7
pdbSet Grid NativeLayerThickness 1e-7


mask name=mask1 segments= {0.5<um> 1<um>}
photo mask=mask1 thickness=1<um>
implant Arsenic energy=10<keV> dose=1e12 tilt=7<degree>  rotation=0<degree> 
strip PhotoResist
diffuse  temperature=1000<C> time=30<min>


diffuse temperature=1000<C> time=10<min> O2

deposit material=Si type=anisotropic thickness=100<nm> Arsenic concentration=1e+20<cm-3>
mask name=mask2 segments= {0<um> 0.25<um> 0.75<um> 1<um>}
photo mask=mask2 thickness=1<um>
etch material= {Silicon} type= anisotropic thickness=100<nm>
etch material= {Oxide} type= anisotropic thickness= 20<nm>
etch material= {Resist} type= anisotropic thickness= 1<um> 

struct tdr= n1_afterAnneal

grid set.Delaunay.type=boxmethod


contact name=anode box Silicon xlo=-0.01 xhi=0.01 ylo=0 yhi=0.1
contact name=cathode box Silicon xlo=-0.01 xhi=0.01 ylo=0.9 yhi=1
contact name=gate box Silicon xlo=-0.105 xhi=-0.125 ylo=0.25 yhi=0.75



struct tdr= n1

exit


