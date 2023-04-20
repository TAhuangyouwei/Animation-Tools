fn createFloor state = --´´½¨µØ°å
(
	if state == on then 
	(
		if LayerManager.getLayerFromName "floor" == undefined then 
		(
			layer = LayerManager.newLayerFromName "floor"
			animFloor = box length:600 width:600  height:-3 name:"Floor" 
			animFloor.mat = standard()
			layer.addnodes animFloor
		)
		else 
		(
			layer = LayerManager.getLayerFromName "floor"
			animFloor = box length:600 width:600  height:-3 name:"Floor" 
			animFloor.mat = standard()
			layer.addnodes animFloor
		)
	)
	else if $Floor != undefined then 
	(
		delete $Floor
		LayerManager.deleteLayerByName "floor"
	)
		

)