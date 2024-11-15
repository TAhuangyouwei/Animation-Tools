global copiedBoneNames = #() -- �洢��������
global copiedWeights = #() -- �洢Ȩ����Ϣ
global copiedVertexWeights = #() -- �洢ÿ�������Ȩ����Ϣ����
global copiedVertexBoneNames = #() -- �洢ÿ������Ĺ�����������
global allVertices = #() -- �洢�ܵ㼯��
global selectedVertices = #() -- ��ʼ��Ϊһ��������
global copiedVertexGroups = #() -- �洢�����������
global pasteVertsGroups = #() -- �洢ճ���������

global currentCloseVerticesPairIndex
currentCloseVerticesPairIndex = 1




try(DestroyDialog skinWeightsRollout)catch()
rollout skinWeightsRollout "Ƥ��Ȩ�ع���" width:160 height:200
(
	fn refreshWeightToolsPanel skinModifier = 
	(
		max modify mode -- �л����޸����
		vertNumbers = skinOps.getSelectedVertices skinModifier
		skinOps.SelectVertices  skinModifier #{}
		skinOps.SelectVertices skinModifier vertNumbers
		if (skinOps.isWeightToolOpen skinModifier) == 1 then 
		(
			skinOps.closeWeightTool  skinModifier
			skinOps.WeightTool  skinModifier
		)

	)
	
	

	fn findModifier obj modType =
	(
		if obj != undefined then 
		(
			for mod in obj.modifiers where classOf mod == modType do return mod
			return undefined
		)
	)

	fn getCurrentSelectedVertices skinMod = 
	(
		return skinOps.GetSelectedVertices skinMod
	)

	
		
	fn inverseSelection skinMod totalVertices =
	(
		currentSelection = getCurrentSelectedVertices skinMod
		newSelection = #() -- ��ʼ��һ�����������ڴ洢���յ���ѡ�ж��㼯

		-- �����ܵ㼯����δ����ǰѡ�еĶ���
		for vert in totalVertices do
		(
			if (findItem currentSelection vert) == 0 then -- �����ǰ���㲻��currentSelection��
			(
				append newSelection vert -- �������ӵ�newSelection��
			)
		)

		-- ����skin modifier�Ķ���ѡ��״̬
		skinOps.SelectVertices skinMod newSelection
	)
	
	-- ��ȷ����BoneMap�ṹ��
	struct BoneMap
	(
		map = #(),
		fn addBone boneName boneID = (append map #(boneName, boneID)),
		fn getBoneID boneName = (for bonePair in map where bonePair[1] == boneName do return bonePair[2])
	)


	-- ����BoneNameIDMap�ĺ���
	fn createBoneNameIDMap skinModifier =
	(
		local myBoneMap = BoneMap()
		local boneNodes = skinOps.GetBoneNodes skinModifier
		for i = 1 to boneNodes.count do
		(
			local boneName = boneNodes[i].name
			myBoneMap.addBone boneName i
		)
		return myBoneMap
	)


	-- ȷ����ʹ��createBoneNameIDMap֮ǰ�Ѿ�������BoneMap�ṹ��
	-- �����ڵ���createBoneNameIDMapʱ������ȷ����ӳ�䲢ʹ�����ķ���

	fn ensureAllBonesExist sourceMod targetMod =
	(
		local sourceBones = skinOps.GetBoneNodes sourceMod
		local targetBones = skinOps.GetBoneNodes targetMod
		local targetBoneNames = for bone in targetBones collect bone.name

		for sourceBone in sourceBones do
		(
			if not (findItem targetBoneNames sourceBone.name) > 0 do
			(
				skinOps.addBone targetMod sourceBone 1
			)
		)
	)



	fn autoStitchOptimized node1 node2 threshold =
	(
		local skinMod1 = findModifier node1 Skin
		local skinMod2 = findModifier node2 Skin

		if skinMod1 == undefined or skinMod2 == undefined do
		(
			messagebox "One or both objects do not have a Skin modifier."
			return undefined
		)

		ensureAllBonesExist skinMod1 skinMod2

		local boneMap1 = createBoneNameIDMap skinMod1
		local boneMap2 = createBoneNameIDMap skinMod2

		local vertsPos1 = for i = 1 to skinOps.GetNumberVertices skinMod1 collect (polyOp.getVert node1.baseobject i)
		local vertsPos2 = for i = 1 to skinOps.GetNumberVertices skinMod2 collect (polyOp.getVert node2.baseobject i)
		
		local closeVerticesCount = 0
		local transferredWeightsCount = 0

		for i = 1 to vertsPos1.count do
		(
			for j = 1 to vertsPos2.count do
			(
				if distance vertsPos1[i] vertsPos2[j] <= threshold do
				(
					local boneCount = skinOps.GetVertexWeightCount skinMod1 i
					local copiedBoneIDs = #()
					local copiedWeights = #()

					for k = 1 to boneCount do
					(
						local weight = skinOps.GetVertexWeight skinMod1 i k
						local boneID1 = skinOps.GetVertexWeightBoneID skinMod1 i k
						local boneName = skinOps.GetBoneName skinMod1 boneID1 0
						local targetBoneID = boneMap2.getBoneID(boneName)

						if targetBoneID != undefined do
						(
							append copiedBoneIDs targetBoneID
							append copiedWeights weight
						)
					)

					if copiedBoneIDs.count > 0 do
					(
						skinOps.ReplaceVertexWeights skinMod2 j copiedBoneIDs copiedWeights
						closeVerticesCount += 1
						transferredWeightsCount += copiedWeights.count
					)
				)
			)
		)

		format "Total close vertices pairs found: %\n" closeVerticesCount
		format "Total weights transferred: %\n" transferredWeightsCount
	)





    group "���ο���"
    (
        button btnCopy "����Ȩ��"  width:140 height:30
        button btnPaste "ճ��Ȩ��"  width:140 height:30
		


    )
    group "��������"
    (
		
		button btnRecordCopy "Record Copy" width:110 height:30	across:2	
		button btnBatchCopy "����"  width:40 height:30 offset:[20,0]
		button btnRecordPaste "Record Paste" width:110 height:30 pos:[12,154] across:2
		button btnBatchPaste "ճ��"  width:40 height:30 offset:[20,0]
		button btnAutoStitch "�Զ����" width:150 height:30



		on btnAutoStitch pressed do  --�Զ�����Ȩ��
		(
			if selection.count == 2 then
			(
				autoStitchOptimized selection[1] selection[2] 0.1
			)
			else messagebox "��ѡ��������������Զ���ϡ�"
		)
		
		
		
    )
	group "��洢"
	(		

		
		
		button btnSaveAllVertices "All Verts" width:140 height:30
				
		on btnSaveAllVertices pressed do
		(
			local skinMod = findModifier selection[1] Skin
			if skinMod != undefined then
			(
				local currentSelection = getCurrentSelectedVertices skinMod
				if currentSelection.count == 0 and allVertices.count > 0 then
				(
					-- ���û��ѡ�еĶ�����allVertices�д洢����ѡ��allVertices�еĵ�
					skinOps.SelectVertices skinMod allVertices
				)
				else
				(
					-- �����ѡ�еĶ����allVerticesΪ�գ������allVertices
					allVertices = currentSelection
				)
			)
			else
			(
				messagebox "No skin modifier found on selected object."
			)
			completeRedraw()

		)

		on btnSaveAllVertices rightclick  do
		(
			allVertices = #() -- ���allVertices
		)

		
		-- �洢��ѡ��Selected Verts
		button btnSaveSelectedVertices "Selected Verts" width:140 height:30
		on btnSaveSelectedVertices pressed do 
		(
			local skinMod = findModifier selection[1] Skin
			if skinMod != undefined then
			(
				local currentSelection = getCurrentSelectedVertices skinMod
				if currentSelection.count == 0 and selectedVertices.count > 0 then
				(
					-- ���û��ѡ�еĶ�����selectedVertices�д洢����ѡ��selectedVertices�еĵ�
					skinOps.SelectVertices skinMod selectedVertices
				)
				else
				(
					-- �����ѡ�еĶ����selectedVerticesΪ�գ������selectedVertices
					selectedVertices = currentSelection
				)
			)
			completeRedraw()

		)

		on btnSaveSelectedVertices rightclick  do
		(
			selectedVertices = #() -- ���Selected Verts
		)


		-- ѡ��allVertices�г�ȥselectedVertices�ĵ�
		button btnSelectInverse "ѡ��Inverse" width:140 height:30
		on btnSelectInverse pressed do
		(
			local skinMod = findModifier selection[1] Skin
			if skinMod != undefined then
			(
				local inverseSelection = for vert in allVertices where not (findItem selectedVertices vert > 0) collect vert -- ����
				skinOps.SelectVertices skinMod inverseSelection
			)
			else
			(
				messagebox "No skin modifier found on selected object."
			)
			completeRedraw()

		)

		
		

	)
	group "״̬��Ϣ"
	(
		label cpoyVertsNumber "��ǰCopy��������0" offset:[0,5]
		
		label pasteVertsNumber "Paste��������0"  offset:[0,5]
		
		on btnRecordCopy pressed do
		(
			local skinMod = findModifier selection[1] Skin
			if skinMod != undefined then
			(
				local currentSelection = getCurrentSelectedVertices skinMod
				for vert in currentSelection do
				(
					append copiedVertexGroups vert -- ֱ����������ֵ����������
				)
				cpoyVertsNumber.text = "Copied vertex groups: " + (copiedVertexGroups.count as string)
			)
			else messagebox "Please select a mesh with a Skin modifier."
		)

		
		on btnRecordPaste pressed do
		(
			local skinMod = findModifier selection[1] Skin
			if skinMod != undefined then
			(
				local currentSelection = getCurrentSelectedVertices skinMod
				append pasteVertsGroups currentSelection
				format "Recorded selection group: %\n" currentSelection
				pasteVertsNumber.text = "Paste������" + (pasteVertsGroups.count as string)
			)
			else messagebox "Please select a mesh with a Skin modifier."
			
		)
		
		
		on btnCopy pressed do
		(
			copiedBoneNames = #()
			copiedWeights = #()
			skinModifier = selection[1].modifiers[#skin]
			vertNumbers = skinOps.getSelectedVertices skinModifier --��ȡѡ�еĵ�
			if vertNumbers.count != 0 then 
			(
				vertBoneCount = skinOps.GetVertexWeightCount skinModifier vertNumbers[1] --��ȡ��ǰѡ�е��м�������Ӱ��
				cpoyVertsNumber.text = "ֻcopy��һ��ѡ��Ķ���"   					-- ���¿�����������ǩ���ı�
				pasteVertsNumber.text = "Paste����0" 
			)
			else 
			(
				cpoyVertsNumber.text = "��ǰCopy��������0"
				pasteVertsNumber.text = "Paste����0" 
				return undefined
			)
				
				
			for weightTool_ListNumber = 1 to vertBoneCount do 
			(
				vertWeight = skinOps.GetVertexWeight skinModifier vertNumbers[1] weightTool_ListNumber  --��ȡ������Ȩ����Ϣ 
				
				boneID = skinOps.GetVertexWeightBoneID skinModifier vertNumbers[1]  weightTool_ListNumber  --��ȡ����ID 
				
				
				append copiedWeights vertWeight
				listID = skinOps.GetListIDByBoneID skinModifier boneID
				
				boneNode = skinOps.GetBoneNode skinModifier boneID --��ȡѡ��Ĺ�������
				
				boneName = skinOps.GetBoneName skinModifier boneID 0  --������boneID,����weightTool_ListNumber
				append copiedBoneNames boneName 
				
				
				

			)
			
		)
	
		
		on btnPaste pressed do
		(
			with undo "Paste Single Vertex Weight" on
			(
				skinModifier = selection[1].modifiers[#skin]
				targetVertNumbers = skinOps.getSelectedVertices skinModifier --��ȡѡ�еĵ�����ճ������
				updatedSkinBoneNodes = skinOps.GetBoneNodes skinModifier
				copiedBoneIDs =#()
				
				
				missingBoneNodes = #()
				-- ����copiedBoneNames�е�ÿ����������
				for boneName in copiedBoneNames do
				(
					local found = false
					for boneNode in updatedSkinBoneNodes do
					(
						if boneNode.name == boneName then
						(
							found = true
							break
						)
					)
					-- ���û���ҵ��������ӵ���ʱ�б���
					if not found do append missingBoneNodes (getNodeByName boneName)
				)
				
				-- ����ÿ��ȱʧ�Ĺ������������ӵ�skinModifier��
				for boneNode in missingBoneNodes do
				(
					-- ���������boneNode��һ����Ч�Ĺ����ڵ����
					skinOps.addBone skinModifier boneNode 1
				)
				
				-- ���»�ȡ���º�Ĺ����ڵ��б�
				updatedSkinBoneNodes = skinOps.GetBoneNodes skinModifier
				
				for boneName in copiedBoneNames do 
				(
					for boneIndex = 1 to updatedSkinBoneNodes.count do --ͨ�����ƶԱȻ�ȡboneID ��Ȼ���ٰ�BoneID ת����copiedBoneIDs��
					(
						if updatedSkinBoneNodes[boneIndex].name == boneName then
						(
							append copiedBoneIDs boneIndex    
						)
					)
				)
				
				for vertNumber in targetVertNumbers do 
					skinOps.ReplaceVertexWeights skinModifier vertNumber copiedBoneIDs copiedWeights
				
				refreshWeightToolsPanel skinModifier
				pasteVertsNumber.text = "Paste����"  + ( targetVertNumbers.count as string )
			)
		)
		
		
		
		on btnBatchCopy pressed do
		(
			
			copiedVertexWeights = #() -- ���ã��Ա�洢�µĿ�������Ȩ����Ϣ
			copiedVertexBoneNames = #() -- ���ã��Ա�洢�µĿ����������������Ϣ
			-- ע�⣺���ﲻ��Ҫ���� copiedVertexGroups����Ϊ������ btnRecordCopy ����

			skinModifier = findModifier selection[1] Skin
			if skinModifier == undefined do 
			(
				messagebox "ѡ�еĶ���û��Skin Modifier!"
				return undefined 
			)

			-- ����Ƿ��Ѿ���¼�˿�������
			if copiedVertexGroups.count == 0 do
			(
				cpoyVertsNumber.text = "Copy������Ϊ��0"
				messagebox "No copy vertex recorded."
				return undefined
			)
			cpoyVertsNumber.text = "Copy������Ϊ��" + (copiedVertexGroups.count as string)
			-- ������¼��ÿ������
			for vert in copiedVertexGroups do
			(
				local vertWeights = #() -- �洢��ǰ�����Ȩ����Ϣ
				local vertBoneNames = #() -- �洢��ǰ����Ĺ���������Ϣ
				local vertBoneCount = skinOps.GetVertexWeightCount skinModifier vert
				
				for i = 1 to vertBoneCount do
				(
					local vertWeight = skinOps.GetVertexWeight skinModifier vert i
					local boneID = skinOps.GetVertexWeightBoneID skinModifier vert i
					local boneName = skinOps.GetBoneName skinModifier boneID 0
					append vertWeights vertWeight
					append vertBoneNames boneName
				)
				
				append copiedVertexWeights vertWeights
				append copiedVertexBoneNames vertBoneNames
			)
			
			messagebox ("Batch copy completed. " + (copiedVertexGroups.count as string) + " vertices copied.")

		)


		
		
		
		
				
		on btnBatchPaste pressed do
		(
			with undo "Batch Paste Vertex Weights" on
			(
				
				skinModifier = findModifier selection[1] Skin
				if skinModifier == undefined do 
				(
					messagebox "ѡ�еĶ���û��Skin Modifier!"
					return undefined
				)
				if pasteVertsGroups.count == 0 do
				(
					messagebox "No paste vertex groups recorded."
					return undefined
				)
				updatedSkinBoneNodes = skinOps.GetBoneNodes skinModifier
				for groupIndex = 1 to pasteVertsGroups.count do
				(
					local pasteGroup = pasteVertsGroups[groupIndex]
					local copyIndex = groupIndex
					if copyIndex > copiedVertexWeights.count then
						copyIndex = copiedVertexWeights.count -- ȷ���������ᳬ���������ݵķ�Χ
					
					local vertWeights = copiedVertexWeights[copyIndex]
					local vertBoneNames = copiedVertexBoneNames[copyIndex]
					local vertexBoneIDs = for boneName in vertBoneNames collect (findItem (for bn in updatedSkinBoneNodes collect bn.name) boneName)
					for vert in pasteGroup do
					(
						if vert <= skinOps.GetNumberVertices skinModifier do
						(
							skinOps.ReplaceVertexWeights skinModifier vert vertexBoneIDs vertWeights
						)
					)
				)
				
				refreshWeightToolsPanel skinModifier
				pasteVertsGroups = #() -- �洢ճ���������
			)
		)


		
	)
	

	
)

createdialog skinWeightsRollout 180 435