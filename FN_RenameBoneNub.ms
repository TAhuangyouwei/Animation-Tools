fn RenameBoneNub = --重命名末端骨
(
	ArrayNub = for bn in selection where bn.children.count ==0 and classof bn == BoneGeometry and bn.parent != undefined and classOf bn.parent == BoneGeometry and ((findString bn.name "Nub") == undefined)collect bn

	if ArrayNub.count == 0 then 
		messageBox "请选择需要改名的物体!"
	else 
	(
		for Nub in ArrayNub do Nub.name = Nub.name + "Nub"	
	)
)
