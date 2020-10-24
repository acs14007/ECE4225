*************************
*Written by: Jacob Schoggin (2016)
*Modified by: Sadid Muneer (09/27/2017)
*************************


***This file does not solve for temperature.

***Define input and output files
File {
  **Input Files
  *Grid = MeshFile
  Grid = "Stack_geo_msh.tdr"

  **Output Files
  *Current = ContactOutputFile
  Current = "EXP4Out_rvrse" 
  *Plot =    FieldOutputFile
  Plot = "EXP4Out_rvrse"
  *Output =  LogOutputFile
  Output = "EXP4Out_rvrse"
}


***Assign electrode to contacts defined with Sentaurus Structure Editor (SDE)

Electrode {
	{Name="Left"	Voltage = 0}
	{Name="Right"	Voltage = 0}
}


***Assign Physics
***We can specify which physics we want to use. For example, here we calculate recombination according to Shockley Read Hall, Auger, and Avalanche effects.
***Thermodynamic is to solve for temperature
Physics {
  Mobility( DopingDep HighFieldSat Enormal )
  EffectiveIntrinsicDensity( OldSlotboom )
  Recombination( SRH Auger Avalanche )
}


***Select output quantities
*Specify which variables you want saved in the output files.
Plot {
  eDensity hDensity eCurrent hCurrent
  Potential SpaceCharge ElectricField
  eMobility hMobility eVelocity hVelocity
  Doping DonorConcentration AcceptorConcentration
  ConductionBand ValenceBand equasiFermi hquasiFermi  
}


***Setup numerical method
*We can specify how to solve with different numerical methods, starting conditions, error functions, etc... For now, we are using default settings so this section is blank.
Math{
}


***Setup solver
*Finally, we run our sims.  First we solve for a stable initial condition, then we sweep the voltage up.
Solve{
  *Initial Solution with just Poisson, then with Poisson, Electrons, and Hole conservation
  Coupled(Iterations=100){ Poisson }
  Coupled{ Poisson Electron Hole
	 }

  *Using the last solution obtained (initial condition), sweep voltage on "Left" up to 2.
  Quasistationary(
    InitialStep = 0.01 MinStep = 1e-5 MaxStep = 0.2
    Goal{ Name="Left" Voltage = 1}
	        )
  {Coupled{ Poisson Electron Hole 
	  }
  } 
    
}



