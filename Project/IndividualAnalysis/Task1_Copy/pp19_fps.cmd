
math coord.ucs



line x location= 0.0      spacing= 1.0<nm>  tag=SiTop        
line x location= 50.0<nm> spacing=10.0<nm>                    
line x location= 0.5<um>  spacing=50.0<nm>                      
line x location= 2.0<um>  spacing= 0.2<um>  tag=SiBottom                        
line y location= 0.0      spacing= 0.1*0.36  tag= Mid
line y location= 0.5*0.36 spacing= 0.05*0.36
line y location= 2*0.36   spacing= 0.36      tag= Right 



region Silicon xlo=SiTop xhi=SiBottom ylo=Mid yhi=Right



init concentration=1e18 field=Boron slice.angle= 180 !DelayFullD
pdbSet Silicon Dopant DiffModel ChargedFermi
AdvancedCalibration 



grid set.min.normal.size=1<nm> set.normal.growth.ratio.2d=1.5
mgoals accuracy=1e-5
pdbSet Oxide Grid perp.add.dist 1e-7
pdbSet Grid NativeLayerThickness 1e-7



diffuse temperature=950<C> time=20 O2



set oxidelayer [lindex [layers y=0 Oxide] 1]
puts "DOE: tox [format %.4f [expr [lindex $oxidelayer 1] - [lindex $oxidelayer 0]]]"
struct tdr=n19_MOS1 ; # Saving after gate oxidation



deposit material= {PolySilicon} type=anisotropic thickness= 0.1 



mask name=gate_mask left=-0.36/2 right= 0.36/2
etch material= {PolySilicon} type=anisotropic thickness= 0.15 mask=gate_mask
etch material= {Oxide}       type=anisotropic thickness= 0.06
struct tdr=n19_MOS2 ; # Saving after gate patterning



implant Arsenic dose=1e13 energy=20 tilt=0 rotation=0  
diffuse temperature=1050<C> time=0.1<s> ; # Quick activation 
struct tdr=n19_MOS3 ; # Saving after LDD Implant



implant Boron dose=1e13 energy=30 tilt=30<degree> rotation=0<degree>
implant Boron dose=1e13 energy=30 tilt=30<degree> rotation=90<degree>
implant Boron dose=1e13 energy=30 tilt=30<degree> rotation=180<degree>
implant Boron dose=1e13 energy=30 tilt=30<degree> rotation=270<degree>



diffuse temperature=1050<C> time=5.0<s>
struct tdr=n19_MOS4 ; # Saving after HALO Implant



deposit nitride isotropic thickness= 0.3*0.36
etch  nitride anisotropic thickness= 0.35*0.36
struct tdr=n19_MOS5 ; # Saving after spacer formation



implant Arsenic dose=1e16 energy=10 \
        tilt=7<degree> rotation=-90<degree>  



diffuse temperature=1050<C> time=10.0<s> 
struct tdr=n19_MOS6 ; # Saving after souce/drain implantation



deposit material= {Aluminum} type=anisotropic thickness= 0.05
mask name= contacts_mask left=0.36*1.2
etch material= {Aluminum} type=anisotropic thickness= 0.1 mask=contacts_mask



transform reflect left 

contact name=substrate bottom
contact name=source point y=-0.36*1.5 x=-0.010 replace
contact name=drain  point y=0.36*1.5  x=-0.010 replace
contact name=gate   point y=0         x=-0.050 



struct tdr=n19 !Gas !interfaces
exit




