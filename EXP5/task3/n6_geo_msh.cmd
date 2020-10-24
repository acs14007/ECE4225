Title "Untitled"

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.pSilicon" {
		Species = "BoronActiveConcentration"
		Value = 1e+20
	}
	Constant "Const.nSilicon" {
		Species = "ArsenicActiveConcentration"
		Value = 1e+20
	}
	Refinement "RefDef.stack" {
		MaxElementSize = ( 0.05 0.05 )
		MinElementSize = ( 0.05 0.05 )
	}
}

Placements {
	Constant "PlaceCD.pSilicon" {
		Reference = "Const.pSilicon"
		EvaluateWindow {
			Element = region ["R.pSi"]
		}
	}
	Constant "PlaceCD.nSilicon" {
		Reference = "Const.nSilicon"
		EvaluateWindow {
			Element = region ["R.nSi"]
		}
	}
	Refinement "PlaceRF.stack" {
		Reference = "RefDef.stack"
		RefineWindow = Rectangle [(0 0) (2 1)]
	}
}

