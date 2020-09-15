File {
  *Input Files
  *Grid = MeshFile
  Grid = "Rectangle_geo_msh.tdr"

  *Output Files
  *Current = ContactOutputFile
  Current = "Class1Out"
  *Plot =    FieldOutputFile
  Plot = "Class1Out"
  *Output =  LogOutputFile
  Output = "Class1Out"
}


*Electrodes are contacts where you will specify voltage, current, etc...
Electrode {
  *{ Name=ContactName	Voltage=InitialVoltage }
}


*Thermodes are contacts with a specified temperature
*Thermode{
  *{ Name=ContactName	Temperature=InitialTemperature }
*}


*Specify which physics you want to solve for (carrier mobility, field breakdown, thermodynamics, etc...)
Physics { 

}


*Specify which variables you want to save to look at later
Plot {
  eDensity hDensity eCurrent hCurrent
  Potential SpaceCharge ElectricField
  eMobility hMobility eVelocity hVelocity
  Doping DonorConcentration AcceptorConcentration
  ConductionBand ValenceBand equasiFermi hquasiFermi

}


*Specify how the numerical solver works
Math{

}


*Simulations
Solve{
  *Find initial values first
  *Coupled{PhysicsToSolveFor}

  *Then ramp up variables
  *Quasistationary(
    *InitialStep=?? MinStep=?? MaxStep=??
    *Goal{ Name=ContactName Voltage=DesiredVoltage }
  *){ Coupled{PhysicsToSolveFor} } 
}
