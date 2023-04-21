currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_ResetMaterials.ms" --���ò�����
fileIn rulesScript

currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_ResetMaterialsOfModel.ms"  --����ģ�ͣ�������Xform
fileIn rulesScript


currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_StandardCheck.ms"  --�淶���
fileIn rulesScript
	
	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_ViewChange.ms"  --��ͼ�л�
fileIn rulesScript


currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_AddObjectsToLayer.ms"  --�����������Ժ����ƽ����������Ӧ�㼶
fileIn rulesScript

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_BipedEulerQuater.ms"  --ŷ����Ԫ�������л�
fileIn rulesScript

currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_BipedScaleoOn_Off.ms"  --bip��������
fileIn rulesScript

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_BoneScale.ms"  --bone��������
fileIn rulesScript
	

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_CreateTwistBone.ms"  --����Ť������
fileIn rulesScript
	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_RenameBoneNub.ms"  --����ĩ�˹�
fileIn rulesScript

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_ClearMaterials.ms"  --��������
fileIn rulesScript

currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_CleanScene.ms"  --��������
fileIn rulesScript
	
	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_CreateFloor.ms"  --��������
fileIn rulesScript
	
	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_Silhouette_Viewer.ms"  --�鿴��Ӱ
fileIn rulesScript

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_DeleteEmptyLayers.ms"  --ɾ���ղ�
fileIn rulesScript

currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_����ű����������.ms"  --���������������
fileIn rulesScript



try (DestroyDialog AniTools ) catch ()
rollout AniTools "��������"
(
	group "ģ�Ͳ��ʹ淶"
	(
		button btResetMat "���ò��ʱ༭��"  height:21 width:93 tooltip:"���ò������л�Ϊ��ɨ����Ⱦ��" across:2
		button bnResetModelMat "����ģ��"  	height:21 width:93 tooltip:"ֻ������Editable_Poly���壬��������ԭ�㣬�Ҽ��������������"
		on btResetMat pressed do --���ò���
		(
			ResetMaterials()
		)
		on bnResetModelMat pressed do  --������ģ�������ԭ��
		(
			ResetMaterialsOfModel()
		)
		
		on bnResetModelMat rightclick do ResetMaterialsOfModel_centerPivot() --�Ҽ�������ģ��
		
		button btClearMat "�������"  height:21 width:93  tooltip:"���ѡ������Ĳ��ʻ�����������Ĳ���" across:2 --��������   
		
		on btClearMat pressed do 
		(
			clearMaterials()
		)
		
		button btClearScene "��������"   height:21 width:93
		
		on btClearScene pressed do 
		(
			cleanScene()
		)
		
		checkbutton btcreateFloor "��������" height:21 width:93 across:2
		
		on btcreateFloor changed state do
		if state == on then  createFloor state else  createFloor state
		
		
		button bt_check "�淶���" height:21 width:93  tooltip:"�����ͼͨ��������������λ��ģ�����š�����" 
		
		on bt_check pressed do 
		( 

			standardCheck()
		)
	)
	
	-------------------------------------------------------------------------------------------------------------------
	
		group "��ݹ���"
	(
		button btprogram "������ͼ" height:21 width:93 across: 2
		
		on btprogram pressed do 
		(
			ProgrammeView()
		)
		button restore "������ͼ"	height:21 width:93
		
		on restore pressed do 
		(
			AnimView()
		)
		
		button btQuickLook "���ٲ鿴Max�ļ�" height:21 width:93 across: 2
		
		on btQuickLook pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/max�ļ��鿴.ms"  --max�ļ��鿴��
			fileIn rulesScript
		)
		
		button btSkinTools "Ȩ����Ƥ����"
		
		on btSkinTools pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/Ȩ����Ƥ����.ms"  --Ȩ����Ƥ����
			fileIn rulesScript
		)
		
		checkbutton cbt_click "��Ӱ" height:21 width:93 across: 2
		
		on cbt_click changed state do
		(
			Silhouette_Viewer()
		)
		button btFBXtoBip "FBXתBip" height:21 width:93 
		
		on btFBXtoBip pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/AutoFbxtoBip v1.4.mse"  --FBXתBip
			fileIn rulesScript
1
		)
		
		Dropdownlist BoneColorList "������ɫ�б�" items:#("red-�۾�","green-ȹ��","blue-ͷ��","white-����","black-ĩ�˹�","orange-����","yellow-����","brown-����","gray-��") selection:1 height:10 toolTip:"������ѡ��ɫ�б�"
		
		button BoneWireColor "ȷ��" width:90
		
		on BoneWireColor pressed do 
		(
			case of 
			(
				(BoneColorList.selection == 1): $.wirecolor = red
				
				(BoneColorList.selection == 2): $.wirecolor = green
				
				(BoneColorList.selection == 3): $.wirecolor = blue
				
				(BoneColorList.selection == 4): $.wirecolor = white
				
				(BoneColorList.selection == 5): $.wirecolor = black
				
				(BoneColorList.selection == 6): $.wirecolor = orange
				
				(BoneColorList.selection == 7): $.wirecolor = yellow
				
				(BoneColorList.selection == 8): $.wirecolor = brown
				
				(BoneColorList.selection == 9): $.wirecolor = gray		
			)		
		)
		
		button btBoneDivider "�����зֹ���"  height:21 width:93 across:2
		
		on btBoneDivider pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/bonedivider.ms"  --FBXתBip
			fileIn rulesScript
		)

		button btCopyTrans "�켣����" height:21 width:93  
		
		on btCopyTrans pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/���������˶��켣.ms"  --FBXתBip
			fileIn rulesScript
		)
		
		
		button btRecoder "�ο���ʦ"  height:21 width:93 across:2
		
		on btRecoder pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/�ο���ʦv1.06.mse"  --�ָ���Ƥpose
			fileIn rulesScript
		)
		
		button btRepair "�����޸�Repair"  height:21 width:93 tooltip:"�޸�������������"
		
		on btRepair pressed do
		(
			SetDefaultLanguageToChinese()
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/AnimTools.ms"  --FBXתBip
			fileIn rulesScript
			
		)			
		
		

	)
	group "�󶨹���"
	(
		button btObjLayer "�����㼶" height:21 width:93 across: 2  tooltip:"�Ѳ�ͬ���Ե�������벻ͬ�Ĳ㼶"   across:2
		
		on btObjlayer pressed do AddObjectsToLayer()
		
		button reNameNub "����ĩ��" height:21 width:93 tooltip:"bone����ĩ�˹�������"
		on reNameNub pressed do 
		(
			RenameBoneNub()
		)
		
		button bt_resetSkinPose "�ָ���Ƥpose" height:21 width:93 across: 2  tooltip:"�ָ���Tpose"
		
		on bt_resetSkinPose pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/������Ƥpose V1.1.mse"  --�ָ���Ƥpose
			fileIn rulesScript
		)
		button bt_CombineSkin "��Ƥ��ֺϲ�"  height:21 width:93   tooltip:"�ϲ�ʱÿ��ѡ����������"
		
		on bt_CombineSkin pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/Rigging_CombineSkin.ms"  --��Ƥ��ֺϲ�
			fileIn rulesScript
		)
		
		button bt_facialRig  "�����"  height:21 width:93  across:2  tooltip:"����󶨹���"
		
		on bt_facialRig pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/facialRigDemo.ms"  --��Ƥ��ֺϲ�
			fileIn rulesScript
		)
		
		button bt_bodylRig  "�����"  height:21 width:93    tooltip:"����󶨹���"
		
		on bt_bodylRig pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/�Զ��������.ms"  --��Ƥ��ֺϲ�
			fileIn rulesScript
		)
		
		
		
		button bt_clearNullLayer "�����ղ�"
		on bt_clearNullLayer pressed do 
		(
			DeleteEmptyLayers()
		)
		
	)
	
	group "biped"
	(
		button btQuater "��Ԫ��" height:21 width:93 across:2 tooltip:"�л���Quater����ģʽ"
		button btBipScale "Bip����"  height:21 width:93 tooltip:"ֻ������ѡ�е�bip����,����������Ҽ��ر�"
		button btBoneScale "����ƥ��"  height:21 width:93  across:2
		button btTwistCreate "Ť������" height:21 width:93 tooltip:"����Ť������"
		on btQuater pressed do 
		(
			BipedEulerQuater()
		)
		on btBipScale pressed do BipedScaleoOn() --�����������
		
		on btBipScale rightClick do BipedScaleoOff()  --�Ҽ��ر�����
		
		on btBoneScale pressed do 
		(
			boneScale()
		)
		on btTwistCreate  pressed do 
		(
			CreateTwistBone()
		)
		
		button btRestoreBiped "��ԭ���"
		on btRestoreBiped pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/��ԭbip����ۺ��޸���.mse"  --biped��ۻ�ԭ
			fileIn rulesScript
		)
	) 
	
	group "�ο�����"
	(
		button bt_wh "������Ŀ¼" height:21 width:93   tooltip:"������max2008֮ǰ�İ汾"  --across: 2
		
		on bt_wh pressed do 
		(
			currentFolder = @"D:\maxscript\maxscript help"
			ShellLaunch currentFolder ""
		)
	)

	label Author "���ߣ�HYW"
)
CreateDialog AniTools  240 635