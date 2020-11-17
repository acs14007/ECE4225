* -------------------------------------
* NMOS project template Fall 2017
* .cmd file for sdevice
* Author: Sadid Muneer
* 11/09/2017
* -------------------------------------


File {
   * input files:
   Grid=   "n150_fps.tdr"
   * output files:
   Plot=   "n155_des.tdr"
   Current="n155_des.plt"
   Output= "n155_des.log"
}

Electrode {
   { Name="source"    Voltage= 0.0 EqOhmic}
   { Name="drain"     Voltage= 0.0 EqOhmic}
   { Name="gate"      Voltage= 0.0 Barrier = 0}
   { Name="substrate" Voltage= 0.0 EqOhmic}
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

Math { 
   Extrapolate
   Iterations= 20
   ExitOnFailure
}

Plot {
  eDensity hDensity eCurrent hCurrent
  Potential SpaceCharge ElectricField
  eMobility hMobility eVelocity hVelocity
  Doping DonorConcentration AcceptorConcentration
  ConductionBand ValenceBand equasiFermi hquasiFermi  
}

Solve {
*- Creating initial guess:
   Coupled(Iterations= 100){ Poisson } 
   Coupled {Poisson Electron Hole}

*- Ramp to drain to Vg
   Quasistationary( 
      InitialStep= 0.1 Increment= 1.5 
      MinStep= 1e-5 MaxStep= 0.1 
      Goal { Name="gate" Voltage=3 } 
   ){ Coupled {Poisson Electron Hole} } 

*- Vd sweep 
   NewCurrentFile="IdVd_" 
   Quasistationary( 
      DoZero 
      InitialStep= 0.01 Increment= 1.5 
      MinStep= 1e-5 MaxStep= 0.025
      Goal { Name="drain" Voltage= 3 } 
   ){ Coupled {Poisson Electron Hole} }
}



