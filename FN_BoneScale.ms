fn boneScale = --bone¹Ç÷ÀÆ¥Åä
(
	bipedobj = for obj in selection where classof obj == Biped_Object and findString obj.name "Footsteps" == undefined and obj.name != "Bip001" collect obj 
	
	for i = 1 to bipedobj.count do 
	(
		PosStart= bipedobj[i].transform.pos
		if bipedobj[i].children.count !=0 then 
			PosEnd= bipedobj[i].children[1].transform.pos
		else 
			PosEnd = [PosStart.x+5,PosStart.y,PosStart.z]
		bn = boneSys.createbone PosStart PosEnd  [0,0,1] 
		bn.transform = bipedobj[i].transform
		bn.Transform.controller = Link_Constraint ()
		bn.transform.controller.AddTarget bipedobj[i] 0
		bn.name = replace bipedobj[i].name 1 7 "B_"
	)
)