# -------------------------------------
# NMOS project template Fall 2017
# .cmd file for sprocess
# Author: Sadid Muneer
# 11/09/2017
# -------------------------------------

math coord.ucs


# Declare initial grid (half structure)
# -------------------------------------

line x location= 0.0      spacing= 1.0<nm>  tag=SiTop        
line x location= 50.0<nm> spacing=10.0<nm>                    
line x location= 0.5<um>  spacing=50.0<nm>                      
line x location= 2.0<um>  spacing= 0.2<um>  tag=SiBottom                        
line y location= 0.0      spacing= 0.1*@Lg@  tag= Mid
line y location= 0.5*@Lg@ spacing= 0.05*@Lg@
line y location= 2*@Lg@   spacing= @Lg@      tag= Right 


# Silicon substrate definition
# ----------------------------

region Silicon xlo=SiTop xhi=SiBottom ylo=Mid yhi=Right


# Initialize the simulation
# -------------------------

init concentration=@body_doping@ field=Boron slice.angle= 180 !DelayFullD
# turn off 3-stream diffusion for speed
pdbSet Silicon Dopant DiffModel ChargedFermi
AdvancedCalibration 


# Global Mesh settings for automatic meshing in newly generated layers
# --------------------------------------------------------------------

grid set.min.normal.size=1<nm> set.normal.growth.ratio.2d=1.5
mgoals accuracy=1e-5
pdbSet Oxide Grid perp.add.dist 1e-7
pdbSet Grid NativeLayerThickness 1e-7


# Gate oxidation
# --------------

diffuse temperature=950<C> time=@GOxTime@ O2


# Extract oxide thickness, tox
# ----------------------------

set oxidelayer [lindex [layers y=0 Oxide] 1]
puts "DOE: tox [format %.4f [expr [lindex $oxidelayer 1] - [lindex $oxidelayer 0]]]"
struct tdr=n@node@_MOS1 ; # Saving after gate oxidation


# Poly gate deposition
# --------------------

deposit material= {PolySilicon} type=anisotropic thickness= 0.1 


# Poly gate pattern/etch
# ----------------------

mask name=gate_mask left=-@Lg@/2 right= @Lg@/2
etch material= {PolySilicon} type=anisotropic thickness= 0.15 mask=gate_mask
etch material= {Oxide}       type=anisotropic thickness= 0.06
struct tdr=n@node@_MOS2 ; # Saving after gate patterning


# LDD implantation
# ----------------

implant Arsenic dose=@LDD_dose@ energy=@LDD_energy@ tilt=0 rotation=0  
diffuse temperature=1050<C> time=0.1<s> ; # Quick activation 
struct tdr=n@node@_MOS3 ; # Saving after LDD Implant


# Halo implantation: Quad HALO implants
# -------------------------------------

implant Boron dose=@halo_dose@ energy=@halo_energy@ tilt=30<degree> rotation=0<degree>
implant Boron dose=@halo_dose@ energy=@halo_energy@ tilt=30<degree> rotation=90<degree>
implant Boron dose=@halo_dose@ energy=@halo_energy@ tilt=30<degree> rotation=180<degree>
implant Boron dose=@halo_dose@ energy=@halo_energy@ tilt=30<degree> rotation=270<degree>


# RTA of LDD/HALO implants
# ------------------------

diffuse temperature=1050<C> time=5.0<s>
struct tdr=n@node@_MOS4 ; # Saving after HALO Implant


# Nitride spacer
# --------------

deposit nitride isotropic thickness= 0.3*@Lg@
etch  nitride anisotropic thickness= 0.35*@Lg@
struct tdr=n@node@_MOS5 ; # Saving after spacer formation


# Source/drain implantation
# -------------------------

implant Arsenic dose=@source_dose@ energy=@source_energy@ \
        tilt=7<degree> rotation=-90<degree>  


# Final RTA
# ---------

diffuse temperature=1050<C> time=10.0<s> 
struct tdr=n@node@_MOS6 ; # Saving after souce/drain implantation


# Contacts
# --------

deposit material= {Aluminum} type=anisotropic thickness= 0.05
mask name= contacts_mask left=@Lg@*1.2
etch material= {Aluminum} type=anisotropic thickness= 0.1 mask=contacts_mask


# Reflect
# -------

transform reflect left 

contact name=substrate bottom
contact name=source point y=-@Lg@*1.5 x=-0.010 replace
contact name=drain  point y=@Lg@*1.5  x=-0.010 replace
contact name=gate   point y=0         x=-0.050 


# Saving final structure
# ----------------------

struct tdr=n@node@ !Gas !interfaces
exit



