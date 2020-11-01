
File {
*Grid= "n13_fps.tdr"
*Parameter= "pp14_des.par"
*Current= "n14_des.plt"
*Plot= "n14_des.tdr"
*Output = "n14_des.log"

Grid= "n13_fps.tdr"
*Parameter="pp14_des.par"
Current="n14_des.plt"
Plot= "n14_des.tdr"
Output= "n14_des.log"
}


***Contacts were defined with Sentaurus Structure Editor.  Here, we specify which of the imported contacts we want to use, and what their initial values should be.
Electrode {
  *{ Name=ContactName	Voltage=InitialVoltage }
  {Name="top"	Voltage=0.0}
  {Name="bottom"	Voltage=0.0}
}


***Thermodes are contacts with a specified temperature
*Thermode{
  *{ Name=ContactName	Temperature=InitialTemperature }
  *{ Name="top"  Temperature = 300 }
  *{ Name="bottom" Temperature = 300 }
*}


*We can specify which physics we want to use.  For example, here we calculate recombination according to Shockley Read Hall, Auger, and Avalanche effects.
Physics {
  *Thermodynamic
  Mobility( DopingDep HighFieldSat Enormal )
  EffectiveIntrinsicDensity( OldSlotboom )
  Recombination( SRH Auger Avalanche )
}


*Specify which variables you want saved in the output files.
Plot {
  eDensity hDensity eCurrent hCurrent
  Potential SpaceCharge ElectricField
  eMobility hMobility eVelocity hVelocity
  Doping DonorConcentration AcceptorConcentration
  ConductionBand ValenceBand equasiFermi hquasiFermi
  
  *--Heat quantities 
  *Temperature TotalHeat eJouleHeat hJouleHeat
}


*We can specify how to solve with different numerical methods, starting conditions, error functions, etc... For now, we are using default settings so this section is blank.
Math{
}


*Finally, we run our sims.  First we solve for a stable initial condition, then we sweep the voltage up.
Solve{
  *Initial Solution with just Poisson, then with Poisson, Electrons, and Hole conservation
  Coupled(Iterations=100){ Poisson }
  Coupled{ Poisson Electron Hole 
	   *Temperature 
         }

  *Using the last solution obtained (initial condition), sweep voltage on "Left" up to 2.
  Quasistationary(
    InitialStep=0.01 MinStep=1e-5 MaxStep=0.05
    Goal{ Name="top" Voltage=-1 }
  )
  {Coupled{ Poisson Electron Hole 
            *Temperature
  }}

}

