fn AddObjectsToLayer =  --把相应物体加入相对应层级
(
	hpArray = for i in objects where classof i == point and i.box == true and i.cross ==false collect i 
	
	hpParArray = for i in objects where classof i == point and i.box == false collect i 

	bnArray = for i in objects where classof i == BoneGeometry and findstring i.name "Twist" == undefined  collect i  
	
	conArray = for i in objects where classof i == SplineShape collect i  
		
	bipArray = for i in objects where classof i == Biped_Object collect i 

	skinArray = for i in objects where i.modifiers[skin] !=undefined collect i 
		
	boneNubArray = for bn in objects where bn.children.count ==0 and classof bn == BoneGeometry and ((findString bn.name "Nub") != undefined)  and bn.parent != undefined and classOf bn.parent == BoneGeometry collect bn
	
	twistBones = for obj in objects where ( classof obj == BoneGeometry and findstring obj.name "Twist" != undefined )collect obj  
	
	
	layerHP = LayerManager.getLayerFromName "HP" --查看是否存在同名层
	
	if hpArray.count != 0 then 
	(
		if layerHP == undefined then 				-- 加入HPlayer 
		(	
			layerHP = LayerManager.newLayerFromName "HP"
			layerHP.addnodes hpArray
			
		)
		else
		(	
			layerHP.addnodes hpArray

		)
	)

	
	layerhpPar = LayerManager.getLayerFromName "HP_Par"

	if hpParArray.count != 0 then 
	(
		if layerhpPar == undefined then 					-- 加入HPParlayer 
		(
		layerhpPar = LayerManager.newLayerFromName "HP_Par"
		layerhpPar.addnodes hpParArray
		
		)
		else
		(	
			layerhpPar.addnodes hpParArray
		)
	)

	
	layerBN = LayerManager.getLayerFromName "Bone"

	if BNArray.count != 0 then 
	(
		if layerBN == undefined then 						-- 加入BNlayer 
		(
		layerBN = LayerManager.newLayerFromName "Bone"
		layerBN.addnodes BNArray
		
		)
		else
		(	
			layerBN.addnodes BNArray
				
		)
	)

	
	layerCON = LayerManager.getLayerFromName "CON"

	if CONArray.count != 0 then 
	(
		if layerCON == undefined then 							-- 加入CONlayer 
		(
			layerCON = LayerManager.newLayerFromName "CON"
			layerCON.addnodes CONArray
			
		)
		else
		(	
			layerCON.addnodes CONArray
				
		)
	)

	
	layerBiped = LayerManager.getLayerFromName "Biped"

	if bipArray.count != 0 then 
	(
		if layerBiped == undefined then 						-- 加入Bipedlayer 
		(
		layerBiped = LayerManager.newLayerFromName "Biped"
		layerBiped.addnodes bipArray
		
		)
		else
		(	
			layerBiped.addnodes bipArray
		)
	)

	
	layerSkin = LayerManager.getLayerFromName "AM_CH_SZ_01" --查看是否存在同名层

		if skinArray.count != 0 then 
		(
			if layerSkin == undefined then 							-- 加入lAM_CH_SZ_01layer 
			(
				layerSkin = LayerManager.newLayerFromName "AM_CH_SZ_01"
				layerSkin.addnodes skinArray
				
			)
			else
			(	
				layerSkin.addnodes skinArray			
			)
	)

	if boneNubArray.count != 0 then 
	(
		layerboneNub = LayerManager.getLayerFromName "0"
		layerboneNub.addnodes boneNubArray		
	)
	
	layerBNtst = LayerManager.getLayerFromName "BN_Twist"

	if twistBones.count != 0 then 
	(
		if layerBNtst == undefined then 						
		(
		layerBNtst = LayerManager.newLayerFromName "BN_Twist"
		layerBNtst.addnodes twistBones
		)
		else
		(
			layerBNtst.addnodes twistBones
		)
	)
	
)