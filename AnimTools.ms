currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_ResetMaterials.ms" --重置材质球
fileIn rulesScript

currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_ResetMaterialsOfModel.ms"  --重置模型，类似于Xform
fileIn rulesScript


currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_StandardCheck.ms"  --规范检查
fileIn rulesScript
	
	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_ViewChange.ms"  --视图切换
fileIn rulesScript


currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_AddObjectsToLayer.ms"  --根据物体属性和名称将物体加入相应层级
fileIn rulesScript

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_BipedEulerQuater.ms"  --欧拉四元素曲线切换
fileIn rulesScript

currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_BipedScaleoOn_Off.ms"  --bip骨骼缩放
fileIn rulesScript

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_BoneScale.ms"  --bone骨骼缩放
fileIn rulesScript
	

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_CreateTwistBone.ms"  --创建扭曲骨骼
fileIn rulesScript
	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_RenameBoneNub.ms"  --命名末端骨
fileIn rulesScript

	
currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_ClearMaterials.ms"  --清理材质
fileIn rulesScript

currentFolder = getFilenamePath (getThisScriptFilename())
rulesScript = pathConfig.appendPath currentFolder "/FN_CleanScene.ms"  --清理场景
fileIn rulesScript
	
	





try (DestroyDialog AniTools ) catch ()
rollout AniTools "动作工具"
(
	group "模型材质规范"
	(
		button btResetMat "重置材质编辑器"  height:21 width:93 tooltip:"重置材质球，切换为线扫描渲染器" across:2
		button bnResetModelMat "重置模型"  	height:21 width:93 tooltip:"只作用于Editable_Poly物体，左键轴点在原点，右键轴点在物体中心"
		on btResetMat pressed do --重置材质
		(
			ResetMaterials()
		)
		on bnResetModelMat pressed do  --左键点击模型轴点在原点
		(
			ResetMaterialsOfModel()
		)
		
		on bnResetModelMat rightclick do ResetMaterialsOfModel_centerPivot() --右键轴点居中模型
		
		button btClearMat "清除材质"  height:21 width:93  tooltip:"清除选择物体的材质或者所有物体的材质" across:2 --清理材质   
		
		button btClearScene "清理场景"   height:21 width:93
		on btClearMat pressed do 
		(
			clearMaterials()
		)
		
		on btClaearScene pressed do 
		(
			cleanScene()
		)
		
		checkbutton btcreateFloor "创建地面" height:21 width:93 across:2
		
		on btcreateFloor changed state do
		if state == on then  createFloor state else  createFloor state
		
		
		button bt_check "规范检查" height:21 width:93  tooltip:"检查贴图通道数量，场景单位，模型缩放、轴向" 
		
		on bt_check pressed do 
		( 

			standardCheck()
		)
	)
	
	-------------------------------------------------------------------------------------------------------------------
	
		group "快捷工具"
	(
		button btprogram "代码视图" height:21 width:93 across: 2
		
		on btprogram pressed do 
		(
			ProgrammeView()
		)
		button restore "动画视图"	height:21 width:93
		
		on restore pressed do 
		(
			AnimView()
		)
		
		button btQuickLook "快速查看Max文件" height:21 width:93 across: 2
		
		on btQuickLook pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/max文件查看.ms"  --max文件查看器
			fileIn rulesScript
		)
		
		button btSkinTools "权重蒙皮工具"
		
		on btSkinTools pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/权重蒙皮工具.ms"  --权重蒙皮工具
			fileIn rulesScript
		)
		
		button btCucoloris "剪影"
		
		on btCucoloris pressed do 
		(
			
		)

		

	)
	group "骨骼工具"
	(
		button btObjLayer "调整层级" tooltip:"把不同属性的物体放入不同的层级"   across:2
		
		on btObjlayer pressed do AddObjectsToLayer()
		
		button reNameNub "命名末端" tooltip:"bone骨骼末端骨重命名"
		on reNameNub pressed do 
		(
			RenameBoneNub()
		)
	)
	
	group "biped"
	(
		button btQuater "四元数" height:21 width:93 across:2 tooltip:"切换到Quater曲线模式"
		button btBipScale "Bip缩放"  height:21 width:93 tooltip:"只作用于选中的bip骨骼,左键开启，右键关闭"
		button btBoneScale "骨骼匹配"  height:21 width:93  across:2
		button btTwistCreate "扭曲骨骼" height:21 width:93 tooltip:"创建扭曲骨骼"
		on btQuater pressed do 
		(
			BipedEulerQuater()
		)
		on btBipScale pressed do BipedScaleoOn() --左键开启缩放
		
		on btBipScale rightClick do BipedScaleoOff()  --右键关闭缩放
		
		on btBoneScale pressed do 
		(
			boneScale()
		)
		on btTwistCreate  pressed do 
		(
			CreateTwistBone()
		)
		
		button btRestoreBiped "还原外观"
		on btRestoreBiped pressed do 
		(
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/还原bip的外观和修改器.mse"  --biped外观还原
			fileIn rulesScript
		)
	) 
	

	label Author "作者：HYW"
)
CreateDialog AniTools  240 400