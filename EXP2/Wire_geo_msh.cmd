Title ""

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.Silicon" {
		Species = "BoronActiveConcentration"
		Value = 1e+18
	}
	Refinement "RefDef.all" {
		MaxElementSize = ( 1 0.775 )
		MinElementSize = ( 1 0.775 )
	}
	Refinement "RefDef.Bridge" {
		MaxElementSize = ( 0.5 0.307 )
		MinElementSize = ( 0.5 0.307 )
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
	Refinement "PlaceRF.Bridge" {
		Reference = "RefDef.Bridge"
		RefineWindow = Rectangle [(7.5 23.4) (12.5 54.1)]
	}
}

