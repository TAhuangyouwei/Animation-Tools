/*


��δ�����һ����� Autodesk 3ds Max ��MaxScript�ű�����Ҫ���ܰ�����ȡ�ض�����ķ����Զ�������ֵ�����Dummy�����Ƿ�����ض������������û�������չʾ�����Ϣ��������ʹ����һϵ�е�ȫ�ֱ�����������Rollout����Ԫ�أ��Լ�����ЩԪ�ص��¼���������ʵ���书�ܡ�

- **ȫ�ֱ���**�����������ű��д洢�ʹ�����Ϣ��
- **����**��ִ���ض���������������ԡ���ȡ��Ϣ�ȡ�
- **Rollout����**�����ڴ����û����棬ʹ�û��ܹ���ű�������

�����е�ע���ṩ�˶�ÿ�����ֹ��ܺ͹���ԭ����˵������������ű�������ṹ���߼���



*/


-- ���������Ѿ����ڵĶԻ����Ա����ظ�����
try(destroyDialog ::nonZeroSpinnerRollout) catch()
try(destroyDialog ::floatScriptsRollout) catch()

-- ����: ��ȡ������Զ�������ֵ
fn getNonZeroSpinnerValues obj =
(
    if not isValidNode obj do return #() -- ���obj�Ƿ�Ϊ��Ч�Ľڵ�
    local nonZeroValues = #() -- �洢����ֵ������
    local custAttributesList = custAttributes.getDefs obj -- ��ȡ������Զ������Զ���

    -- �����Զ������Զ���
    if custAttributesList != undefined then
    (
        for custAttrDef in custAttributesList do
        (
            local custAttrData = custAttributes.get obj custAttrDef -- ��ȡ�Զ�����������
            if custAttrData != undefined do
            (
                local propNames = getPropNames custAttrData -- ��ȡ��������
                -- ������������
                for propName in propNames do
                (
                    local propValue = getProperty custAttrData propName -- ��ȡ����ֵ
                    try
                    (
                        -- ��������Ǹ������ҷ��㣬�����ӵ�������
                        if classOf propValue == Float and abs(propValue) > 0.01 do
                        (
                            local formattedValue = (floor(propValue * 100 + 0.5)) / 100.0 -- ��ʽ��ֵ
                            append nonZeroValues ((propName as string) + ": " + (formattedValue as string))
                        )
                    ) catch()
                )
            )
        )
    )
    nonZeroValues -- ���ط���ֵ����
)



fn isString s =
(
	if findString s "AC_" != undefined then 
		return true 
	else
		return false


)


-- ����: ���Dummy�����Ƿ�����ض�����
fn doesDummyHaveVariable dummyObj varName =
(
    if classOf dummyObj == Dummy do
    (
        -- ���λ�ÿ������ĸ�����
        if isProperty dummyObj #position do
        (
            local posController = dummyObj.position.controller
            if classOf posController == Position_XYZ do
            (
                local posControllers = #(posController.x_position.controller, posController.y_position.controller, posController.z_position.controller)
                -- ����λ�ÿ�����
                for ctrl in posControllers do
                (
                    if classOf ctrl == Float_Script do
                    (
						varNames = filterString ctrl.script "+-*()"  -------------------------���
						newVarName = "AC_" + varName
						for i = 1 to varNames.count do 
						(
							if varNames[i] == newVarName do 
							(
								print varNames[i]
								print newVarName
								return true
							)
						)
                        
                    )
                )
            )
        )

        -- �����ת�������ĸ�����
        if isProperty dummyObj #rotation do
        (
            local rotController = dummyObj.rotation.controller
            if classOf rotController == Euler_XYZ do
            (
                local rotControllers = #(rotController.x_rotation.controller, rotController.y_rotation.controller, rotController.z_rotation.controller)
                -- ������ת������
                for ctrl in rotControllers do
                (
                    if classOf ctrl == Float_Script do
                    (
						varNames = filterString ctrl.script "+-*()"  -------------------------���
						newVarName = "AC_" + varName
						for i = 1 to varNames.count do 
						(
							if varNames[i] == newVarName do 
							(
								print varNames[i]
								print newVarName
								return true
							)
						)
                        
                    )
                )
            )
        )
    )
    false
)

-- ��������: ���������ű����ӵ��б�
fn addScriptToList controller axisName varNames scriptsList objName =
(
	if classOf controller == Float_Script then 
	(
		for varName in varNames do
		(
			if findString controller.script varName != undefined then 
			(
			-- ����ҵ���Ӧ�ı����������ӵ��ű��б�
			append scriptsList (objName + "|" + axisName + "|" + controller.script)
			break -- �ҵ�����ֹѭ��
			)
		)
	)
	else 
	(
		format "Warning: Controller on % is not a Float_Script.\n" axisName
	)
)


fn getUpdatedScriptList varNames =
(
    local scriptsList = #() -- ���ڴ洢��ѡ��������صĽű�

    -- ����ÿ��������
    for varName in varNames do
    (
        -- ���������е�����Dummy����
        for obj in objects where classOf obj == Dummy do
        (
            -- ���Dummy��������ñ�����������������ű�
            if doesDummyHaveVariable obj varName do
            (
                local objName = obj.name
				
				
                -- �Ƚ�Dummy�����������Ϊ�������б�������
                append scriptsList objName

                -- ���λ�ÿ�����
                if isProperty obj #position do
                (
                    local posController = obj.position.controller
                    if classOf posController == Position_XYZ do
                    (
                        -- ����ÿ����Ľű����б�
                        addScriptToList posController.x_position.controller "x_position" varNames scriptsList objName
                        addScriptToList posController.y_position.controller "y_position" varNames scriptsList objName
                        addScriptToList posController.z_position.controller "z_position" varNames scriptsList objName
                    )
                )

                -- �����ת������
                if isProperty obj #rotation do
                (
                    local rotController = obj.rotation.controller
                    if classOf rotController == Euler_XYZ do
                    (
                        -- ����ÿ����Ľű����б�
                        addScriptToList rotController.x_rotation.controller "x_rotation" varNames scriptsList objName
                        addScriptToList rotController.y_rotation.controller "y_rotation" varNames scriptsList objName
                        addScriptToList rotController.z_rotation.controller "z_rotation" varNames scriptsList objName
                    )
                )

                -- ������ſ�����
                if isProperty obj #scale do
                (
                    local scaleController = obj.scale.controller
                    if classOf scaleController == Scale_XYZ do
                    (
                        -- ����ÿ����Ľű����б�
                        addScriptToList scaleController.x_scale.controller "x_scale" varNames scriptsList objName
                        addScriptToList scaleController.y_scale.controller "y_scale" varNames scriptsList objName
                        addScriptToList scaleController.z_scale.controller "z_scale" varNames scriptsList objName
                    )
                )
            )
        )
    )
    scriptsList -- �����ռ����Ľű��б�
)



-- ����: ���б�������ȡ��������
fn getVarNameFromItem item =
(
    local splitItem = filterString item ":"
    if splitItem.count > 0 then return trimRight splitItem[1] else ""
)

-- ����: ���ݱ������ƻ��Dummy����
fn getDummiesBasedOnVariables varNames =
(
    for varName in varNames do
    (
        varObj = for obj in objects where (classOf obj == Dummy and doesDummyHaveVariable obj varName ) collect obj
		return varObj
    )
)


	-- ����: ��ȡ������ͬ��ͨ������
fn getSameName VarName =
(
    local obj = $Animcraft_Master_GRP
    if not isValidNode obj do return 0

    local targetName = replace VarName 1 3 ""
    print ("Looking for: " + targetName)

    local custAttributesList = custAttributes.getDefs obj
    if custAttributesList != undefined then
    (
        for custAttrDef in custAttributesList do
        (
            local custAttrData = custAttributes.get obj custAttrDef
            if custAttrData != undefined do
            (
                local propNames = getPropNames custAttrData
                for i = 1 to propNames.count do
                (
                    local propNameAsString = propNames[i] as string
                    if propNameAsString == targetName do
                    (
                        return i
                    )
                )
            )
        )
    )
    0
)


-- ȫ�ֱ�������
global selectedValue = undefined  -- �洢Non-Zero Spinnersѡ�еı�����
global selectedScript  -- �洢float script ѡ�е��ı�����
global selectedScriptIndex    -- �洢float script ѡ�нű�������
global updatedScript = "" -- �洢���º�Ľű�
global modifyScript -- �洢Ҫ�޸ĵĽű�
global listNum  -- �洢�б���ѡ����ı��
global dummyController = undefined  --�洢����Ľű�������
global updatedScriptList = #()

-- rollout����: �༭����ű��Ի���
rollout editFloatScriptRollout "Edit Float Script" width:300 height:120
(
	-- �ı��༭��������ʾ�ͱ༭�ű�
	editText edtScript "Script" width:280 height:60 pos:[10,10] multiline:true
	-- ���水ť�����ڱ���༭��Ľű�
	button btnSave "Save" width:280 height:20 pos:[10,80]
	-- ���Ի����ʱ����ʼ���ű��༭�������
	on editFloatScriptRollout open do
	(
		if selectedScript != undefined do
		(
			edtScript.text = modifyScript -- ʹ��ѡ�еĽű���ʼ���༭��
		)
	)

-- ��������水ťʱִ�еĲ���
	on btnSave pressed do
	(
		if selectedScript != undefined then  
		(
				-- ��ȡ��ѡ����ص�Dummy����
			local dummyName = (filterString selectedScript "|")[1]
			local theDummy = getNodeByName dummyName
			if theDummy != undefined then 
			(
				local axisFloatScriptName  = (filterString selectedScript "|")[2]
				local posController = theDummy.position.controller
				local rotController = theDummy.rotation.controller
				local scaleController = theDummy.scale.controller
				
				if findString axisFloatScriptName "position" != undefined then
				(
					if isProperty theDummy #position and classOf theDummy.position.controller == Position_XYZ do
					(
						local posController = theDummy.position.controller
						if findString axisFloatScriptName "x" != undefined and classOf posController.x_position.controller == Float_Script do
							dummyController = posController.x_position.controller
						if findString axisFloatScriptName "y" != undefined and classOf posController.y_position.controller == Float_Script do
							dummyController = posController.y_position.controller
						if findString axisFloatScriptName "z" != undefined and classOf posController.z_position.controller == Float_Script do
							dummyController = posController.z_position.controller
					)
				)
				else if findString axisFloatScriptName "rotation" != undefined then
				(
					if isProperty theDummy #rotation and classOf theDummy.rotation.controller == Euler_XYZ do
					(
						local rotController = theDummy.rotation.controller
						if findString axisFloatScriptName "x" != undefined and classOf rotController.x_rotation.controller == Float_Script do
							dummyController = rotController.x_rotation.controller
						if findString axisFloatScriptName "y" != undefined and classOf rotController.y_rotation.controller == Float_Script do
							dummyController = rotController.y_rotation.controller
						if findString axisFloatScriptName "z" != undefined and classOf rotController.z_rotation.controller == Float_Script do
							dummyController = rotController.z_rotation.controller
					)
				)
				else if findString axisFloatScriptName "scale" != undefined then
				(
					if isProperty theDummy #scale and classOf theDummy.scale.controller == Scale_XYZ do
					(
						local scaleController = theDummy.scale.controller
						if findString axisFloatScriptName "x" != undefined and classOf scaleController.x_scale.controller == Float_Script do
							dummyController = scaleController.x_scale.controller
						if findString axisFloatScriptName "y" != undefined and classOf scaleController.y_scale.controller == Float_Script do
							dummyController = scaleController.y_scale.controller
						if findString axisFloatScriptName "z" != undefined and classOf scaleController.z_scale.controller == Float_Script do
							dummyController = scaleController.z_scale.controller
					)
					
				)
				
				if dummyController != undefined then
				(
					oldScript = dummyController.script
					
					-- ��ѡ�нű��������¸�ʽ��
					local words = (filterString selectedScript "|+")
					if listNum != undefined then 
						words[listNum] = edtScript.text

					-- �ع��ű��ַ���
					newstr = ""
					for i = 3 to words.count do (
						newstr += words[i] + "+"
					)
					newstr = trimRight newstr "+" -- �Ƴ����һ������ļӺ�

					dummyController.script = newstr
					updatedScript  = newstr
					
					if selectedValue != undefined then 
					(
						-- �����������������������
						local varNames = #(selectedValue)
						
						-- ���� getUpdatedScriptList ��������������
						updatedScriptList = getUpdatedScriptList varNames
					)
					
					destroyDialog editFloatScriptRollout -- �رձ༭�Ի���
					
					 -- ����floatScriptsRollout ���б�����
					if floatScriptsRollout != undefined then
					(
						
						-- ���������б���
						floatScriptsRollout.lstFloatScripts.items = updatedScriptList
						
					)
					
					redrawViews()
				)
				else messagebox "Controller not found."
				
				
				
			)
			else messagebox "Dummy object not found."
			
		)
		else messagebox "No script selected."
		
		
	)

)	

-- rollout����: ����ű��б���ʾ
rollout floatScriptsRollout "Float Scripts" width:1900 height:340
(
	-- �б���������ʾ���еĸ���ű�
	listBox lstFloatScripts "Scripts" width:1880 height:20 pos:[10,10]
	
	radioButtons 'rdo_trans' "Transform"   height:30 align:#left labels:#("Position", "Rotation", "Scale") columns:3 across:3
	
	radioButtons 'rdo_Axis' "Axis"   height:30 align:#left labels:#("X", "Y", "Z")  columns:3
	
	button btn_add "����" width:200  height:30
	
	
	
	
	
	
	-- �����б����ض���Ľű�
	fn updateFloatScriptItem index newScript =
	(
		if index != undefined and index > 0 and index <= lstFloatScripts.items.count do
		(
		lstFloatScripts.items[index] = newScript -- �����б���
		)
	)
	
	-- ���Ի����ʱִ�еĲ���
	on floatScriptsRollout open do
	(
		lstFloatScripts.width = 1880
		floatScriptsRollout.width = 1900
		if updatedScriptList.count > 0 do
        (
            lstFloatScripts.items = updatedScriptList
            updatedScriptList = #() -- ���ȫ�ֱ����������ظ�����
        )
	)


	
	on floatScriptsRollout resized size do
	(
		-- �����µ��б�����
        local newWidth = (size.x - 20)
		lstFloatScripts.width = newWidth
	)
	

	-- �����б���ѡ��һ����ʱִ�еĲ���
	on lstFloatScripts selected index do
	(
		selectedScript = lstFloatScripts.items[index]
		selectedScriptIndex = index
		
		-- ��ȡ��ѡ����ص�Dummy����
		local dummyName = (filterString selectedScript "|")[1]
		local theDummy = getNodeByName dummyName
		if theDummy != undefined do select theDummy
			
		-- ��selectedScript����modifyScript
		-- ��ȡѡ�нű������в���
		local varScripts = (filterString selectedScript "|+")
		
		-- �����ű���ÿ�����֣�������ѡ�б�����صĽű�
		for i = 1 to varScripts.count do 
		(
			if findString varScripts[i] selectedValue != undefined then
			(
				modifyScript = varScripts[i]  -- ����Ҫ�޸ĵĽű�
			)
		)
	)

	-- �����б���˫��һ����ʱִ�еĲ���
	on lstFloatScripts doubleClicked index do
	(
		selectedScriptIndex = index
		selectedScript = lstFloatScripts.items[index]
		
		-- ��ȡѡ�нű������в���
		local varScripts = (filterString selectedScript "|+")
		
		-- �����ű���ÿ�����֣�������ѡ�б�����صĽű�
		newselectedValue = "AC_" + selectedValue
		for i = 1 to varScripts.count do 
		(
			if findString varScripts[i] newselectedValue != undefined then
			(
				subvarScripts = filterString varScripts[i] "*"
				
				--������Ҫ����һ���жϣ����ַ������

				for part in subvarScripts do
				(
					if isString part then
					(
						--������Ҫ����һ���жϣ����ַ������
						if part == newselectedValue then  -- ʹ��==���ж��ַ����Ƿ���ȫ���
						(
							modifyScript = varScripts[i]  -- ����Ҫ�޸ĵĽű�
							listNum = i  -- ��¼�б��е�λ��
							try (DestroyDialog editFloatScriptRollout) catch()
							CreateDialog editFloatScriptRollout -- �򿪱༭�Ի���
						)
					)
						
				)
				
			)
		)
	)
	
	on btn_add pressed do 
	(
		if selection.count == 1 and classof selection[1] == Dummy then 
		(
			local dummyObj = selection[1]
			local controller = dummyObj[3][rdo_trans.state][rdo_Axis.state].controller
			local custAttributesDefs =  $Animcraft_Master_GRP.custom_attributes
			
			if controller != undefined and classOf controller == Float_Script then
			(
				
				local newVarName = "AC_" + selectedValue
				

				if newVarName != undefined and modifyScript != undefined then
				(
					--�����������ִ��
					
					local existingScript = controller.script
					
					custAttrDefNumber = getSameName newVarName
					
					if custAttrDefNumber != 0 then
					(
						controller.addTarget newVarName custAttributesDefs[custAttrDefNumber]
						
						
						if existingScript != undefined and classOf existingScript == String then
						(
							
							newModifyScript = (filterString modifyScript "*")  
							
							for part in newModifyScript do
							(
								if isString part then
								(
									local fixedPart = substituteString part ")" ""
									
									if fixedPart != undefined then  -- ȷ��fixedPart�Ѷ���
									(
										controller.script = existingScript + "+" + fixedPart
									)
								)
									
							)
						)
						else
						(
							messagebox "Existing script or modify script is invalid."
						)
						
					)
					
					-- ��ȡ���º�Ľű��б�
					updatedScriptList = getUpdatedScriptList #(selectedValue)  -- ����selectedValue������Ҫ���µı�����
					
					-- ���ú���ˢ��floatScriptsRollout���б�����
					if floatScriptsRollout != undefined then
					(
						floatScriptsRollout.lstFloatScripts.items = updatedScriptList
					)
					f
					redrawViews()
					
				)
				else
				(
					messagebox "New variable name or modify script is undefined."
				)
				
			)
			else
			(
				messagebox "Selected controller is not a Float_Script or undefined. Cannot add the script."
			)
		)
		else
		(
			messagebox "Please select one Dummy object."
		)
	)






	
)




fn processController dummyObj controllerType varName =
(
    if isProperty dummyObj controllerType do
    (
        local controller = getProperty dummyObj controllerType
        if classOf controller == Position_XYZ or classOf controller == Euler_XYZ or classOf controller == Scale_XYZ do
        (
            local axesControllers = #(controller[1].controller, controller[2].controller, controller[3].controller)
            for ctrl in axesControllers do
            (
                if classOf ctrl == Float_Script and (findString ctrl.script varName) != undefined do
                    return true
            )
        )
    )
    false
)


-- ��������: ��ʾ��ѡ��������ص�Dummy����ĸ���ű�
fn displayFloatScriptsOfSelectedDummies varNames =
(
	local scriptsList = #() -- ���ڴ洢��ѡ��������صĽű�
	
	-- ����ÿ��������
	for varName in varNames do
	(
		-- ���������е�����Dummy����
		for obj in objects where classOf obj == Dummy do
		(
			-- ���Dummy��������ñ�����������������ű�
			if doesDummyHaveVariable obj varName do
			(
				local objName = obj.name
				append scriptsList objName -- �������������ӵ��б�

				-- ���λ�ÿ�����
				if isProperty obj #position do
				(
					local posController = obj.position.controller
					if classOf posController == Position_XYZ do
					(
						-- ����ÿ����Ľű����б�
						addScriptToList posController.x_position.controller "x_position" varNames scriptsList objName
						addScriptToList posController.y_position.controller "y_position" varNames scriptsList objName
						addScriptToList posController.z_position.controller "z_position" varNames scriptsList objName
					)
				)

				-- �����ת������
				if isProperty obj #rotation do
				(
					local rotController = obj.rotation.controller
					if classOf rotController == Euler_XYZ do
					(
						-- ����ÿ����Ľű����б�
						addScriptToList rotController.x_rotation.controller "x_rotation" varNames scriptsList objName
						addScriptToList rotController.y_rotation.controller "y_rotation" varNames scriptsList objName
						addScriptToList rotController.z_rotation.controller "z_rotation" varNames scriptsList objName
					)
				)

				-- ������ſ�����
				if isProperty obj #scale do
				(
					local scaleController = obj.scale.controller
					if classOf scaleController == Scale_XYZ do
					(
						-- ����ÿ����Ľű����б�
						addScriptToList scaleController.x_scale.controller "x_scale" varNames scriptsList objName
						addScriptToList scaleController.y_scale.controller "y_scale" varNames scriptsList objName
						addScriptToList scaleController.z_scale.controller "z_scale" varNames scriptsList objName
					)
				)
			)
		)
	)
	-- ��������ʾ�ű��б��Ի���
	createDialog floatScriptsRollout  style:#(#style_titlebar, #style_resizing, #style_sysmenu) autoLayoutOnResize:true  lockHeight:on 
	if floatScriptsRollout.lstFloatScripts != undefined do
	(
		floatScriptsRollout.lstFloatScripts.items = scriptsList -- �����б�����
	)

)	



-- Rollout����: ������ť
rollout nonZeroSpinnerRollout "Non-Zero Spinners" width:200 height:265
(
	button btnGetValues "Get Non-Zero Values" width:180 height:25 -- ��ȡ����ֵ��ť
	listBox lstNonZeroValues "Values" width:180 height:10 pos:[10,35] -- ��ʾ����ֵ���б���
	button btnSelectDummies "Select Dummies" width:180 height:25 pos:[10,200] -- ѡ��Dummy����İ�ť
		
	label lblStatus "Status: Ready" -- ��ʾ״̬��Ϣ�ı�ǩ
	label author "����:����Ϊ" -- ������Ϣ��ǩ
	
	-- �������ȡ����ֵ��ťʱִ�еĲ���
	on btnGetValues pressed do
	(
		local selectedObj = $Animcraft_Master_GRP -- ָ��Ҫ���Ķ���
		if isValidNode selectedObj then
		(
			lstNonZeroValues.items = getNonZeroSpinnerValues selectedObj -- ��ȡ����ʾ����ֵ
			if lstNonZeroValues.items.count == 0 then
			(
				lblStatus.text = "No non-zero values found." -- ��ʾδ�ҵ�����ֵ����Ϣ
			)
			else lblStatus.text = "Non-zero values updated." -- ��ʾ����ֵ���µ���Ϣ
		)
		else lblStatus.text = "Invalid or no object selected." -- ��ʾ��Ч��δѡ��������Ϣ
	)

	-- �����ѡ��Dummy����ťʱִ�еĲ���
	on btnSelectDummies pressed do
	(
		if lstNonZeroValues.selected != undefined then
		(
			selectedValue = (FilterString lstNonZeroValues.selected ":")[1] -- ��ȡѡ�еı�����
			local selectedIndices = lstNonZeroValues.selection
			if classOf selectedIndices != Array do
				selectedIndices = #(selectedIndices)  -- ���ֻѡ����һ�������ת��Ϊ����

			-- ȷ������ѡ������������Ч�ģ�����0��
			selectedIndices = for index in selectedIndices where index > 0 collect index

			if selectedIndices.count > 0 then
			(
				-- ��ȡ������ÿ��ѡ�����Ӧ�ı�����
				local extractedVarNames = for index in selectedIndices collect getVarNameFromItem lstNonZeroValues.items[index]
				-- ���ݱ�����ѡ����ص�Dummy���󣬲���ʾ�両��ű�
				varObj = getDummiesBasedOnVariables extractedVarNames  --��ȡ����ű��ֺ��б�����dummy����
				displayFloatScriptsOfSelectedDummies extractedVarNames
			)
			else messagebox "Please select an item from the list."  -- ���û��ѡ���κ������ʾ��ʾ��Ϣ      
		)
		else messagebox "No item is selected." -- ���û��ѡ���κ������ʾ��ʾ��Ϣ
	)
	


)

-- ��������ʾ������ť�Ի���
createdialog nonZeroSpinnerRollout   


	
	