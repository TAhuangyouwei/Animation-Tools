fn BipedEulerQuater = --�л�ŷ�����ߺ���Ԫ������
(
	bipedobj = for obj in objects where classof obj == Biped_Object and findString obj.name "Footsteps" == undefined  collect obj 
		
	for i = 1 to bipedobj.count do 
	(
		if (biped.getEulerActive bipedobj[i]) then biped.setQuaternionActive bipedobj[i]
		else (biped.setEulerActive  bipedobj[i] #xyz)
	)
)