Title "Untitled"

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.pSilicon" {
		Species = "BoronActiveConcentration"
		Value = 1e+16
	}
	Constant "Const.nSilicon" {
		Species = "ArsenicActiveConcentration"
		Value = 1e+16
	}
	Refinement "RefDef.stack" {
		MaxElementSize = ( 0.05 0.05 )
		MinElementSize = ( 0.05 0.05 )
	}
}

Placements {
	Constant "PlaceCD.pSi1licon" {
		Reference = "Const.pSilicon"
		EvaluateWindow {
			Element = region ["R.pSi1"]
		}
	}
	Constant "PlaceCD.nSi1licon" {
		Reference = "Const.nSilicon"
		EvaluateWindow {
			Element = region ["R.nSi1"]
		}
	}
	Constant "PlaceCD.pSi2licon" {
		Reference = "Const.pSilicon"
		EvaluateWindow {
			Element = region ["R.pSi2"]
		}
	}
	Constant "PlaceCD.nSi2licon" {
		Reference = "Const.nSilicon"
		EvaluateWindow {
			Element = region ["R.nSi2"]
		}
	}
	Refinement "PlaceRF.stack" {
		Reference = "RefDef.stack"
		RefineWindow = Rectangle [(0 0) (4 1)]
	}
}

