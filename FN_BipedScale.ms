fn BipedScale = --bip¹Ç÷ÀËõ·Å
(
	bipedobj = for obj in selection where classof obj == Biped_Object and findString obj.name "Footsteps" == undefined  collect obj 
	for i = 1 to bipedobj.count do 
	(
		if bipedobj[i].transform.controller.Biped_SubAnim.controller.BipScaleList[1].name == "Available" then 
		bipedobj[i].transform.controller.Biped_SubAnim.controller.BipScaleList.controller.Available.controller = ScaleXYZ ()
	)
	
	$bip001.transform.controller.enableSubAnims = on 
)