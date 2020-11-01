




line x location= 0.0      spacing= 1.0<nm>  tag=SiTop        
line x location= 50.0<nm> spacing= 10.0<nm>                    
line x location= 0.5<um>  spacing= 50.0<nm>                      
line x location= 2.0<um>  spacing= 0.2<um>                       
line x location= 4.0<um>  spacing= 0.4<um>  tag=SiBottom                        
line y location=-0.50<um> spacing=50.0<nm>  tag=Left
line y location=0.50<um>  spacing=50.0<nm>  tag=Right       



region Silicon xlo=SiTop xhi=SiBottom ylo=Left yhi=Right


init concentration=0.02e15 field=Boron


AdvancedCalibration



grid set.min.normal.size=3<nm> set.normal.growth.ratio.2d=1.4



mask name=gate_mask segments= {-0.2 0.2}
photo mask=gate_mask thickness=1<um>

struct tdr= n31_wResist

implant Arsenic energy=30<keV> dose=1e14 tilt=7<degree>  rotation=0<degree> 
strip PhotoResist


struct tdr= n31_asImplant


diffuse  temperature=1000<C> time=30<min>

struct tdr= n31_afterAnneal


grid set.Delaunay.type=boxmethod 


contact name=top box Silicon xlo=0.0 xhi=0.0 ylo=-0.15 yhi=0.15
contact name=bottom box Silicon xlo=4.0 xhi=4.0 ylo=-0.5 yhi=0.5


struct tdr= n31

exit


