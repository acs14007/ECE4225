# Written By Aaron Spaulding
# Based on code written by Sadid Muneer and Md Tashfiq Bin Kashem
# Created for ECE 4225


# Define mesh
line x location= 0.0      spacing= 1.0<nm>  tag=SiTop
line x location= 250<nm> spacing= 20.0<nm>      
line x location= 1<um> spacing= 100.0<nm> tag=SiBottom                       
line y location= 0<um> spacing=20.0<nm>  tag=Left
line y location=1.2<um>  spacing=20.0<nm>  tag=Right


# Define the silicon substrate and simulation
region Silicon xlo=SiTop xhi=SiBottom ylo=Left yhi=Right
init concentration=1.0e+15<cm-3> field=Boron				


# Start advanced calibration
AdvancedCalibration


# Define global meshing settings
grid set.min.normal.size=5<nm> set.normal.growth.ratio.2d=1.5	
mgoals accuracy=1e-5
pdbSet Oxide Grid perp.add.dist 1e-7
pdbSet Grid NativeLayerThickness 1e-7


# Grow an oxide on top of the substrate
diffuse  temperature=1000<C> time=15<min> O2


# Step 3: Deposit Silicon on top of device for our gates
deposit material= {Silicon} type=anisotropic thickness=100<nm> Arsenic concentration= 1e20<cm-3>
struct tdr= n@node@_DepositOxideAndSilicon


# Step 4: We apply a mask and then oxide etch
mask name=gate_mask segments= {0 0.4 0.8 1.2}
photo mask=gate_mask thickness=1<um>
etch material= {Silicon} type= anisotropic thickness= 100<nm>
etch material= {Oxide} type= anisotropic thickness= 30<nm>
etch material= {Resist} type= anisotropic thickness= 1<um>
struct tdr= n@node@_GateEtch


# Step 5: We apply a mask and then implant the source and drain regions
# We can use the same mask as before
photo mask = gate_mask thickness=1<um>
implant Arsenic energy=@energy@<keV> dose=@dose@ tilt=7<degree>  rotation=0<degree> 
etch material= {Resist} type= anisotropic thickness= 1.5<um>
diffuse  temperature=1000<C> time=1<min> 
struct tdr= n@node@_AfterImplant

# Step 6: Build Aluminum Contacts
deposit material= {Aluminum} type=isotropic thickness=30<nm>
mask name=al_mask segments= {0.3 0.9}
photo mask=al_mask thickness=1<um>
etch material= {Aluminum} type= anisotropic thickness= 150<nm>
etch material= {Resist} type= anisotropic thickness= 1.5<um>



# Step 7: Place the contacts
# For source and drain contacts, material name is Aluminum and for gate and substrate, it is Silicon in contact command line
grid set.Delaunay.type=boxmethod
contact name=source box Aluminum xlo=-0.04 xhi=-0.01 ylo=1 yhi=1.2
contact name=drain box Aluminum xlo=-0.04 xhi=-0.01 ylo=0 yhi=0.2
contact name=gate box Silicon xlo=-0.09 xhi=-0.13 ylo=0.4 yhi=0.8
contact name=substrate box Silicon xlo=0.98 xhi=1.020 ylo=0 yhi=1.2


struct tdr= n@node@


exit

