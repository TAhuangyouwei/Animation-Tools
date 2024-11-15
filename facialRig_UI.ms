try (DestroyDialog FacialRigDemo )catch ()
gc()


currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/createFacialControl_UI_Layout.ms"  --�򿪴���UI�Ľű�
fileIn rulesScript	

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/faceBones.ms"  --�򿪴��������Ľű�
fileIn rulesScript	

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/createFacialExpressionUnit.ms"  --�򿪴����������Ľű�
fileIn rulesScript	
	
	
	

rollout FacialRigDemo "�����"
(
	local listNum = 1
	local ctrlName,targetObj,reactToTarget
	group "UI������"
	(
		button fangCtrl "����" across:3
		button allCtrl "ȫ"
		button tiaoCtrl "����"
		
		on fangCtrl pressed do 
		(
			facialControlSquare()
		)
		
		on allCtrl pressed do 
		(
			with redraw off
			(
				undo off facialControl()
			)
		)
		on tiaoCtrl pressed do 
		(
			facialControlBar()
		)
	)
	
	group "����ʽ������"
	(
		button btCreate "����������" height:21 width:60 toolTip:"��ѡ��ı����������������,���߲�ѡ�������ԭ�㴴��һ�����������" across:2
		button btResetBone "������ԭ"
		button btFaceBone "��������" across:2  tooltip:"��Ĭ��λ�ô���һ���沿����"
		button btBonInfor "��ȡ��Ϣ" tooltip:"�ѵ�ǰѡ���bone���������ƺ�������ȡ��temp�ĵ��У��Ҽ����Դ��ĵ�����·��"
		
		
		on btCreate pressed do 
		(
			with redraw off
			(
				undo off 
				(
					createFacialExpressionUnit()					
				)
			)
		)
		
		
		on btResetBone pressed do 
		(
			resetBoneControllers()
		)
		on btFaceBone pressed do 
		(
			createFaceBonesFromFile()
		)
		on btBonInfor pressed do 
		(
			getBoneInformation()
		)
		on btBonInfor rightclick do 
		(
			tempFloder = getdir #defaults
			ShellLaunch tempFloder ""
		)
	)
	
	group "�޸Ĺ�������"
	(
		spinner spBonewidth "��ϸ:"  range:[0,999999,0.2] fieldwidth:50 across:2
		spinner spBoneLength "����:"  range:[0,999999,2] fieldwidth:50
		
		on spBonewidth changed arg  do 
		(
			if selection.count ==0 then 
			(
				for obj in objects where classof obj == BoneGeometry and findString obj.name "BN_" != undefined do obj.width = obj.height = spBonewidth.value
 			)
			else 
				for obj in selection where classof obj == BoneGeometry do obj.width = obj.height = spBonewidth.value
			
			
		)
		
		on spBoneLength changed arg  do 
		(
			if selection.count ==0 then 
			(
				for obj in objects where classof obj == BoneGeometry and findString obj.name "BN_" != undefined do obj.length = spBoneLength.value
 			)
			else 
				for obj in selection where classof obj == BoneGeometry do obj.length = spBoneLength.value
			
			
		)
		
		
	)
	
	
	group "��������"
	(
		button resetScene "R" across:4 tooltip:"���ó�����������"
		button holdScene "H" tooltip:"�ݴ泡��"
		button fetchScene "F"  tooltip:"ȡ���ݴ泡��"
		button saveScene "S"  tooltip:"���泡��"
		
		on resetScene pressed do resetMaxFile #noPrompt
		on holdScene pressed do holdMaxFile()
		on fetchScene pressed do fetchMaxFile quiet:true
		on saveScene pressed do
		(
			filename = maxFilePath + maxFileName
			saveMaxFile filename saveAsVersion:2019
		)						
		
	)
	
	group "�л�������㼶"
	(
		dropdownlist layerName "�㼶�б�" items:#("Position_XYZ","eyebrow_X","eyebrow_Y","zuoZuijiao_X","zuoZuijiao_Y","youZuijiao_X","youZuijiao_Y","upZuichun_X","upZuichun_Y","downZuichun_X","downZuichun_Y")	selection:1 height:12
		
		on layerName selected controllerLayerNum do 
		(
			SwitchLayer controllerLayerNum
			listNum = layerName.selection
			ctrlName = layerName.selected			
		)
		

		
		pickbutton pk_target "ʰȡ������" tooltip:"ʰȡ��Ϊ��Ӧ������Ŀ��Ŀ���������"  width:80 across:2
		
		on pk_target picked obj do
		(
			if obj != undefined do
			(
				pk_target.text = obj.name
				targetObj = obj
			)
		)
		
		button btn_react "����" tooltip:"������Ӧ��������������ϵ" width:80
		on btn_react pressed do 
		(
			-- ȷ�� targetObj �� obj ����Ч�Ķ���
			if targetObj != undefined do
			(
				
				for obj in selection do 
				(
					
					if isValidNode obj do
					(
						for i = 1 to 2 do 
						(
							for k = 1 to 3 do 
							(
								-- ȷ������ listNum ����Ч��
								if listNum != undefined and listNum != 1 do
								(
									
									-- ���ڳ��Է��ʿ�����
									local targetController = obj[3][i][listNum][k].controller
									
									local ReactionName = undefined 
									
									if classOf targetController != Float_Reactor do
									(
										targetController = float_Reactor ()
										obj[3][i][listNum][k].controller = targetController
										
										if findString ctrlName "_X" != undefined then
										(
											reactToTarget = targetObj[3][1][2][1][1].controller
											ReactionName = ctrlName
										)											
										else if findString ctrlName "_Y" != undefined then 
										(
											reactToTarget = targetObj[3][1][2][2][1].controller
											ReactionName = ctrlName
										)											
											
										if reactToTarget != undefined do
										(
											reactTo targetController reactToTarget
											
											if ReactionName != undefined then setReactionName targetController 1 ReactionName
											
											targetController.delete 1
										)
									
									)
								)
							)
						)
						
						
						
						
					)
				)
			)
		)
	)
	group "�淶��������"
	(
		dropdownlist boneNamelist "�㼶�б�" items:#("��üë","���۾�","��ȧ��","�����촽","���촽","�����촽","�����촽","���촽","�����촽","�°�","����","��üë","���۾�","��ȧ��","ͷ")	selection:1 height:16
		
		button btRenameBone "������" across:2 toolTip:"ѡ���沿��������������"
		
		button btPoseSaver "POSE"
		
		on btRenameBone pressed do 
		(
			renameBoneGeometry boneNamelist.selection
		)
		
		on reNameNubBone pressed do 
		(
			reNameNub()
		)
		

		on btPoseSaver pressed do 
		(
			
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/SalPoseManager.ms"  --�淶���
			fileIn rulesScript
			if SalPoseManager !=undefined then
				SalPoseManager.initiate()
			else
				messageBox "Can't find Sal Pose Manager Script" title:"Script Not Found"
			
		)
		
	)
	label authorName "���ߣ�HYW" 
)
	
CreateDialog FacialRigDemo 230  420