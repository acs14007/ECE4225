Title "Untitled"

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.Silicon" {
		Species = "BoronActiveConcentration"
		Value = 1e+20
	}
	Refinement "RefDef.stack" {
		MaxElementSize = ( 0.0015 0.0005 )
		MinElementSize = ( 0.0015 0.0005 )
	}
}

Placements {
	Constant "PlaceCD.Silicon" {
		Reference = "Const.Silicon"
		EvaluateWindow {
			Element = material ["Silicon"]
		}
	}
	Refinement "PlaceRF.stack" {
		Reference = "RefDef.stack"
		RefineWindow = Rectangle [(0 0) (0.09 0.01)]
	}
}

