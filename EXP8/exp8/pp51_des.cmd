File {
   * input files:
   Grid=   "n8_fps.tdr"
   * output files:
   Plot=   "n51_des.tdr"
   Current="n51_des.plt"
   Output= "n51_des.log"
}

Electrode {
   { Name="source"    Voltage= 0.0 }
   { Name="drain"  Voltage= 0.0 }
   { Name="gate"     Voltage= 0.0 }
   { Name="substrate"     Voltage= 0.0 }

}


Physics{
   EffectiveIntrinsicDensity( OldSlotboom )     
}

Physics(Material="Silicon"){
   Mobility(
      PhuMob
      HighFieldSaturation
      Enormal
   )
   Recombination(
      SRH( DopingDependence )
   )           
}

Plot {
  eDensity hDensity eCurrent hCurrent
  Potential SpaceCharge ElectricField
  eMobility hMobility eVelocity hVelocity
  Doping DonorConcentration AcceptorConcentration
  ConductionBandEnergy ValenceBandEnergy 
  
  *--Heat quantities 
  *Temperature TotalHeat eJouleHeat hJouleHeat
}


Solve {
*- Creating initial guess:
   Coupled(Iterations= 100){ Poisson } 
   Coupled {Poisson Electron Hole}

*- Ramp gate to Vgate
   Quasistationary( 
      InitialStep= 0.1 Increment= 1.5 
      MinStep= 1e-7 MaxStep= 1e-1
      Goal { Name="gate" Voltage=1 } 
   ){ Coupled {Poisson Electron Hole} } 



*- Va sweep 
   NewCurrentFile="IaVa_" 
   Quasistationary( 
      DoZero 
      InitialStep= 0.01 Increment= 1.5 
      MinStep= 1e-7 MaxStep= 1e-1 
      Goal { Name="drain" Voltage= 2.5 } 
   ){ Coupled {Poisson Electron Hole} }
}




