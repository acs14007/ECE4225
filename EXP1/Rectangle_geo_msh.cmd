Title ""

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.Silicon" {
		Species = "BoronActiveConcentration"
		Value = 1e+17
	}
	Refinement "RefDef.all" {
		MaxElementSize = ( 0.025 0.5 )
		MinElementSize = ( 0.025 0.5 )
	}
}

Placements {
	Constant "PlaceCD.Silicon" {
		Reference = "Const.Silicon"
		EvaluateWindow {
			Element = material ["Silicon"]
		}
	}
	Refinement "PlaceRF.RSi" {
		Reference = "RefDef.all"
		RefineWindow = region ["R.Si"]
	}
}

