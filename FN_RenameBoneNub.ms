fn RenameBoneNub = --������ĩ�˹�
(
	ArrayNub = for bn in selection where bn.children.count ==0 and classof bn == BoneGeometry and bn.parent != undefined and classOf bn.parent == BoneGeometry and ((findString bn.name "Nub") == undefined)collect bn

	if ArrayNub.count == 0 then 
		messageBox "��ѡ����Ҫ����������!"
	else 
	(
		for Nub in ArrayNub do Nub.name = Nub.name + "Nub"	
	)
)