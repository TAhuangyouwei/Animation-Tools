fn ResetMaterialsOfModel =   --重置模型材质
(
	envPath = getdir #defaults + "temp.env"
	if selection.count ==0 then 
	(
		targetModel = for obj in objects where classof obj.baseobject ==Editable_Poly and obj.faces.count != 0 collect obj
		for i = 1 to targetModel.count do 
		(
			if targetModel[i].modifiers[#skin] == undefined then 
			(
				for j = 1 to targetModel[i].modifiers.count do collapseStack targetModel[i]
				tempName = copy targetModel[i].name 
				tempModel = convertToPoly(box())
				tempModel.EditablePoly.attach targetModel[i] tempModel
				tempModel.EditablePoly.SetSelection #Face #{1..6}
				tempModel.EditablePoly.delete #Face
				tempModel.name = tempName
			)
			else
			(
				sliderTime = 0
				boneArr = skinOps.GetBoneNodes targetModel[i].skin
				
				skinOps.SaveEnvelope targetModel[i].modifiers[#Skin] envPath
				
				for j = 1 to targetModel[i].modifiers.count do collapseStack targetModel[i]
				tempName = copy targetModel[i].name 
				tempModel = convertToPoly(box())
				tempModel.EditablePoly.attach targetModel[i] tempModel
				tempModel.EditablePoly.SetSelection #Face #{1..6}
				tempModel.EditablePoly.delete #Face
				tempModel.name = tempName
				addModifier tempModel (skin())
				for i = 1 to boneArr.count do
				(
					if i == boneArr.count then 
						skinOps.addbone tempModel.modifiers[#Skin] boneArr[i] -1
					else 
						skinOps.addbone tempModel.modifiers[#Skin] boneArr[i] 0
				)
				
				skinOps.loadEnvelope tempModel.modifiers[#Skin] envPath
				tempModel.modifiers[#Skin].bone_Limit =4
				
			)

		)
	)
	else
	(
		targetModel = for obj in selection where classof obj.baseobject ==Editable_Poly and obj.faces.count != 0 collect obj
		for i = 1 to targetModel.count do 
		(
			if targetModel[i].modifiers[#skin] == undefined then 
			(
				for j = 1 to targetModel[i].modifiers.count do collapseStack targetModel[i]
				tempName = copy targetModel[i].name 
				tempModel = convertToPoly(box())
				tempModel.EditablePoly.attach targetModel[i] tempModel
				tempModel.EditablePoly.SetSelection #Face #{1..6}
				tempModel.EditablePoly.delete #Face
				tempModel.name = tempName
			)
			else
			(
				sliderTime = 0
				boneArr = skinOps.GetBoneNodes targetModel[i].skin
				
				if (isDirectoryWriteable "E:\\skin") then 
						skinOps.SaveEnvelope targetModel[i].modifiers[#Skin] envPath
					else 
					(
						makeDir "E:\\skin" all:true 
						skinOps.SaveEnvelope targetModel[i].modifiers[#Skin] envPath
					)
				
				
				for j = 1 to targetModel[i].modifiers.count do collapseStack targetModel[i]
				tempName = copy targetModel[i].name 
				tempModel = convertToPoly(box())
				tempModel.EditablePoly.attach targetModel[i] tempModel
				tempModel.EditablePoly.SetSelection #Face #{1..6}
				tempModel.EditablePoly.delete #Face
				tempModel.name = tempName
				addModifier tempModel (skin())
				for i = 1 to boneArr.count do
				(
					if i == boneArr.count then 
						skinOps.addbone tempModel.modifiers[#Skin] boneArr[i] -1
					else 
						skinOps.addbone tempModel.modifiers[#Skin] boneArr[i] 0
				)
				
				skinOps.loadEnvelope tempModel.modifiers[#Skin] envPath
				tempModel.modifiers[#Skin].bone_Limit =4
				
			)

		)
		
	)
---------------------------------------------------------------

)



fn ResetMaterialsOfModel_centerPivot =   --重置模型材质
(
	
	if selection.count ==0 then 
	(
		targetModel = for obj in objects where classof obj.baseobject ==Editable_Poly and obj.faces.count != 0 collect obj
		for i = 1 to targetModel.count do 
		(
			if targetModel[i].modifiers[#skin] == undefined then 
			(
				for j = 1 to targetModel[i].modifiers.count do collapseStack targetModel[i]
				tempName = copy targetModel[i].name 
				tempModel = convertToPoly(box())
				tempModel.EditablePoly.attach targetModel[i] tempModel
				tempModel.EditablePoly.SetSelection #Face #{1..6}
				tempModel.EditablePoly.delete #Face
				tempModel.name = tempName
				CenterPivot tempModel
			)
			else
			(
				sliderTime = 0
				boneArr = skinOps.GetBoneNodes targetModel[i].skin
				
				if (isDirectoryWriteable "E:\\skin") then 
						skinOps.SaveEnvelope obj.modifiers[#Skin] "E:\\skin\\temp.env"
					else 
					(
						makeDir "E:\\skin" all:true 
						skinOps.SaveEnvelope obj.modifiers[#Skin] "E:\\skin\\temp.env"
					)
				
				
				for j = 1 to targetModel[i].modifiers.count do collapseStack targetModel[i]
				tempName = copy targetModel[i].name 
				tempModel = convertToPoly(box())
				tempModel.EditablePoly.attach targetModel[i] tempModel
				tempModel.EditablePoly.SetSelection #Face #{1..6}
				tempModel.EditablePoly.delete #Face
				tempModel.name = tempName
				CenterPivot tempModel
				addModifier targetModel[i] (skin())
				for i = 1 to boneArr.count do
				(
					if i == boneArr.count then 
						skinOps.addbone obj.modifiers[#Skin] boneArr[i] -1
					else 
						skinOps.addbone obj.modifiers[#Skin] boneArr[i] 0
				)
				
				skinOps.loadEnvelope obj.modifiers[#Skin] "E:\\skin\\temp.env"
				obj.modifiers[#Skin].bone_Limit =4
				
			)

		)
	)
	else
	(
		targetModel = for obj in selection where classof obj.baseobject ==Editable_Poly and obj.faces.count != 0 collect obj
		for i = 1 to targetModel.count do 
		(
			if targetModel[i].modifiers[#skin] == undefined then 
			(
				for j = 1 to targetModel[i].modifiers.count do collapseStack targetModel[i]
				tempName = copy targetModel[i].name 
				tempModel = convertToPoly(box())
				tempModel.EditablePoly.attach targetModel[i] tempModel
				tempModel.EditablePoly.SetSelection #Face #{1..6}
				tempModel.EditablePoly.delete #Face
				tempModel.name = tempName
				CenterPivot tempModel
			)
			else
			(
				sliderTime = 0
				boneArr = skinOps.GetBoneNodes targetModel[i].skin
				
				if (isDirectoryWriteable "E:\\skin") then 
						skinOps.SaveEnvelope targetModel[i].modifiers[#Skin] "E:\\skin\\temp.env"
					else 
					(
						makeDir "E:\\skin" all:true 
						skinOps.SaveEnvelope targetModel[i].modifiers[#Skin] "E:\\skin\\temp.env"
					)
				
				
				for j = 1 to targetModel[i].modifiers.count do collapseStack targetModel[i]
				tempName = copy targetModel[i].name 
				tempModel = convertToPoly(box())
				tempModel.EditablePoly.attach targetModel[i] tempModel
				tempModel.EditablePoly.SetSelection #Face #{1..6}
				tempModel.EditablePoly.delete #Face
				tempModel.name = tempName
				CenterPivot tempModel
				addModifier tempModel (skin())
				for i = 1 to boneArr.count do
				(
					if i == boneArr.count then 
						skinOps.addbone tempModel.modifiers[#Skin] boneArr[i] -1
					else 
						skinOps.addbone tempModel.modifiers[#Skin] boneArr[i] 0
				)
				
				skinOps.loadEnvelope tempModel.modifiers[#Skin] "E:\\skin\\temp.env"
				tempModel.modifiers[#Skin].bone_Limit =4
				
			)
		)
		
	)
---------------------------------------------------------------

)