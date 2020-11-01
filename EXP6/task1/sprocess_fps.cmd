# --------------------------------------------------- #
# Created by Sadid Muneer (sadid@engr.uconn.edu)
# Oct 12, 2016
# Modified: 2017/10/19
# Modified: Raihan Khan (10/08/2018)
# --------------------------------------------------- #
# 2D Vertical pn junction diode
# --------------------------------------------------- #


# math coord.ucs


# Declare initial grid (mesh)
# The argument spacing defines the spacing between two grid lines at the specified location.
# Between two locations defined in the line command, Sentaurus Process expands or compresses the grid spacing linearly.
# The default unit of length is micrometer unless specified explicitly by giving the units in angle brackets
# A line can be labeled with the tag argument for later use in the region command.
# ** In sprocess, postive x points downwards, positive y points to the right. 
# --------------------

# line "x/y" location=" " spacing= " "  tag=" "
line x location= 0.0      spacing= 1.0<nm>  tag=SiTop        
line x location= 50.0<nm> spacing= 10.0<nm>                    
line x location= 0.5<um>  spacing= 50.0<nm>                      
line x location= 2.0<um>  spacing= 0.2<um>                       
line x location= 4.0<um>  spacing= 0.4<um>  tag=SiBottom                        
line y location=-0.50<um> spacing=50.0<nm>  tag=Left
line y location=0.50<um>  spacing=50.0<nm>  tag=Right       


# Silicon substrate definition
# ----------------------------
#region "material" xlo="1st x-coordinate" xhi="2nd x-coordinate" ylo="1st y-coordinate" yhi="2nd y-coordinate"
# The arguments xlo and xhi take tags as values, which are defined in the line commands.

region Silicon xlo=SiTop xhi=SiBottom ylo=Left yhi=Right


# Initialize the simulation
# -------------------------
# init concentration="concentration value" field="concentration type/material"
# init concentration=1.0e+15<cm-3> field=Boron
init concentration=@sub_doping@ field=Boron


AdvancedCalibration


# Global Mesh settings for automatic meshing in newly generated layers
# --------------------------------------------------------------------
# The initial grid is valid until the first command that changes the geometry
# For such cases, a remeshing strategy must be defined
#set.min.normal.size determines the grid spacing of the first layer starting from the interface. More precisely, the  first layer cannot be larger than 0.5*set.min.normal.size.
# set.normal.growth.ratio.2d determines how fast the grid spacing can increase from one layer to another in a 2D mesh.

grid set.min.normal.size=3<nm> set.normal.growth.ratio.2d=1.4


# Implanting dopant
# -----------------
	# a) define mask
# mask name="mask name" segments= {"start" "end"}
# photo mask=gate_mask thickness=1<um>
	# b) implant dopant
# implant "dopant name" energy="energy value" dose="dose value"
	# Get rid of photoresist
# strip PhotoResist

mask name=gate_mask segments= {-0.2 0.2}
photo mask=gate_mask thickness=1<um>

# Saving "with resist" profile
# -----------------------------
struct tdr= n@node@_wResist

implant Arsenic energy=@energy@<keV> dose=@dose@ tilt=7<degree>  rotation=0<degree> 
strip PhotoResist


# Saving "as implanted" profile
# -----------------------------
struct tdr= n@node@_asImplant


# Thermal annealing
# Annealing activates the dopants. 
# -----------------
# diffuse  temperature="temperature value" time="anneal time"
diffuse  temperature=1000<C> time=30<min>

# Saving "after annealed" profile
# -------------------------------
struct tdr= n@node@_afterAnneal


# remeshing for device simulation
# -------------------------------
grid set.Delaunay.type=boxmethod 


# Creating contact
# box: Specifies a box-type contact that consists of elements at the surface of one region or material inside the box, defined for the contact.
# ----------------
#contact name="contact name" "method" "material" "coordinates"
contact name=top box Silicon xlo=0.0 xhi=0.0 ylo=-0.15 yhi=0.15
contact name=bottom box Silicon xlo=4.0 xhi=4.0 ylo=-0.5 yhi=0.5


# Saving tdr for device simulation
# --------------------------------
struct tdr= n@node@

exit

