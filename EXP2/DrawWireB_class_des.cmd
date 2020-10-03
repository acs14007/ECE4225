*************************
*Written by: Jacob Schoggin (2016)
*Modified by: Sadid Muneer (09/26/2017)
*Modified by: Raihan Sayeed Khan (09/10/2018)
*************************


***Define input and output files
File {
  **Input Files
  *Grid = MeshFile 
  *** The MeshFile will be the "SavedModelNameInSDE_msh.tdr"   
  Grid = "Wire_geo_msh.tdr"		

  **Output Files
  *Current = ContactOutputFile
  Current = "Exp2BOut"
  *Plot =    FieldOutputFile
  Plot = "Exp2BOut"
  *Output =  LogOutputFile
  Output = "Exp2BOut"
}


***Assign both electrode and thermode to contacts defined with Sentaurus Structure Editor (SDE)

Electrode {
	{Name="TopBridge"	Voltage = 0}
	{Name="BottomBridge"	Voltage = 0}
}

Thermode{
  { Name="TopBridge"  Temperature = 300 }
  { Name="BottomBridge" Temperature = 300 }
}


***Assign Physics
***We can specify which physics we want to use. For example, here we calculate recombination according to Shockley Read Hall, Auger, and Avalanche effects.
***Thermodynamic is to solve for temperature
Physics {
  Thermodynamic
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
  *--Heat quantities 
  Temperature TotalHeat eJouleHeat hJouleHeat
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
	   Temperature
	 }

  *Using the last solution obtained (initial condition), sweep voltage on "TopBridge" up to 2.
  Quasistationary(
    InitialStep = 0.01 MinStep = 1e-5 MaxStep = 0.2
    Goal{ Name="TopBridge" Voltage = 2 }
	        )
  {Coupled{ Poisson Electron Hole 
	  Temperature}
  } 
    
}


