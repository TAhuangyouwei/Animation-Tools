fn createForearmConer upperArm forearm = --创建手肘骨骼
(
	pt = point cross:on box:on size:20 

	pt.transform = upperArm.transform
	
	posCtrl = Position_Constraint() --位置约束
		
	rotCtrl = Orientation_Constraint()   --旋转约束
		
	pt.pos.controller = posCtrl
		
	pt.rotation.controller = rotCtrl
		
	posConstraintInterface = posCtrl.constraints
		
	rotConstraintInterface = rotCtrl.constraints
		
	posConstraintInterface.appendTarget forearm 50.0
		
	rotConstraintInterface.appendTarget forearm 50.0
	rotConstraintInterface.appendTarget upperArm 50.0
		
	bt = BoneSys.createBone [0,0,0] [10,0,0] [0,0,1]
	bt.transform = pt.transform
	in coordsys local rotate bt (EulerAngles 0 0 90)
	lkCtrl = Link_Constraint ()
	bt.Transform.controller = lkCtrl
	lkCtrl.key_mode = 0
	lkCtrl.addTarget pt 0
	bt.parent = upperArm
)

fn createMuscleBone upperArm forearm muscle = --创建肌肉骨骼
(
	bipedArray =#(upperArm,forearm)

	
	
	if (classof muscle == BoneGeometry) then 
	(
		
		muscleLength = muscle.Length
		pointArray =#()
		for i = 1 to 2 do 
		(
			pt = point cross:on box:on size:5 
			append pointArray pt
			pt.transform = muscle.transform
			if i ==2 then 
			(
				in coordsys local move pt [muscleLength,0,0]
			)
			lkCtrl = Link_Constraint ()
			pt.Transform.controller = lkCtrl
			lkCtrl.key_mode = 0
			lkCtrl.addTarget bipedArray[i] 0
		)
		
		posCtrl = Position_Constraint() --位置约束
			
		rotCtrl =  LookAt_Constraint ()  --旋转约束
		
		
			
		muscle.pos.controller = posCtrl
		
		
		muscle.scale.controller = ScaleXYZ ()
		
		muscle.rotation.controller = rotCtrl
	
		muscle.scale.controller.X_Scale.controller = float_expression()	
		disValue = distance pointArray[1] pointArray[2]
		
		muscle.scale.controller.X_Scale.controller.AddScalarConstant "dis" disValue
		muscle.scale.controller.X_Scale.controller.AddVectorNode  "a" pointArray[1]
		muscle.scale.controller.X_Scale.controller.AddVectorNode  "b" pointArray[2]	
		muscle.scale.controller.X_Scale.controller.setExpression "length(a-b)/dis"
			
		posConstraintInterface = posCtrl.constraints
			
		rotConstraintInterface = rotCtrl.constraints
			
		posConstraintInterface.appendTarget pointArray[1] 50.0
			
		rotConstraintInterface.appendTarget pointArray[2] 50.0
		
		rotCtrl.viewline_length_abs = off
		rotCtrl.upnode_world = off
		if findString upperArm.name "head" ==undefined then 
			rotCtrl.pickUpNode = pointArray[1]
		else 
			rotCtrl.pickUpNode = pointArray[2]
		muscle.parent = upperArm
	)
	
)



fn legCtrl upper lower leg= --腿部控制
(
	pt = point cross:on box:on size:20 
	pt.transform = lower.transform
	ctrlRec = Rectangle length:25 width:15 cornerRadius:3 render_displayRenderMesh:on
	ctrlRec.transform = lower.transform
	ctrlRec.parent = pt
	lkCtrl = Link_Constraint ()
	pt.Transform.controller = lkCtrl
	lkCtrl.key_mode = 0
	lkCtrl.addTarget leg 0
	rotCtrl =  LookAt_Constraint ()  --旋转约束
	upper.rotation.controller = rotCtrl
	rotConstraintInterface = rotCtrl.constraints
	rotConstraintInterface.appendTarget ctrlRec 50.0
	rotCtrl.viewline_length_abs = off
	rotCtrl.upnode_world = off
	rotCtrl.pickUpNode = ctrlRec	
	lower.parent = upper
)

fn createCtrlByBone  bn = --创建脊椎控制器系统
(
	
	
	hpPar = point box:off cross: on  size:10 wirecolor:red transform:bn.transform
	hpPar.name = replace bn.name 1 2 "HpPar"
	hp = point box: on cross:off size:10 wirecolor:red  transform:bn.transform
	hp.name = replace bn.name 1 2 "HP"
	con = circle radius:20  wirecolor:yellow transform:bn.transform
	con.name = replace bn.name 1 2 "CON"
	convertToSplineShape con
	hp.parent = hpPar
	con.parent = hp 
	con.Position.controller = position_list ()
	con.Position.controller.Available.controller = Position_XYZ ()
	con.Position.controller[1].controller = Bezier_Position ()
	listctrl.setname con.Position.controller 1 "Frozen Position"
	listctrl.setname con.Position.controller 2 "Zero Pos XYZ"
	con.position.controller.SetActive 2 

	con.rotation.controller = Rotation_list ()
	con.rotation.controller.Available.controller = Euler_XYZ ()
	listctrl.setname con.rotation.controller 1 "Frozen Rotation"
	listctrl.setname con.rotation.controller 2 "Zero Euler XYZ"
	con.rotation.controller.SetActive 2 
	
	con.Scale.controller = ScaleXYZ()
	
	
)



fn spineBone upper lower muscle = --脊椎骨骼伸缩和控制器联动
(
	if (classof muscle == BoneGeometry) then 
	(

		muscle.parent = undefined 
		posCtrl = Position_Constraint() --位置约束
			
		rotCtrl =  LookAt_Constraint ()  --旋转约束
		
		
			
		muscle.pos.controller = posCtrl
		
		
		muscle.scale.controller = ScaleXYZ ()
		
		muscle.rotation.controller = rotCtrl
	
		muscle.scale.controller.X_Scale.controller = float_expression()	
		muscle.scale.controller.Y_Scale.controller = float_expression()	
		muscle.scale.controller.Z_Scale.controller = float_expression()	
		disValue = distance upper lower
		
		muscle.scale.controller.X_Scale.controller.AddScalarConstant "dis" disValue
		muscle.scale.controller.X_Scale.controller.AddVectorNode  "a" upper
		muscle.scale.controller.X_Scale.controller.AddVectorNode  "b" lower	
		muscle.scale.controller.X_Scale.controller.setExpression "length(a-b)/dis"
		muscle.scale.controller.Y_Scale.controller.AddScalarTarget "conScale_Y" upper[3][3][2].controller
		muscle.scale.controller.Y_Scale.controller.setExpression "conScale_Y"
		muscle.scale.controller.Z_Scale.controller.AddScalarTarget "conScale_Z" upper[3][3][3].controller
		muscle.scale.controller.Z_Scale.controller.setExpression "conScale_Z"
			
		posConstraintInterface = posCtrl.constraints
			
		rotConstraintInterface = rotCtrl.constraints
			
		posConstraintInterface.appendTarget upper 50.0
			
		rotConstraintInterface.appendTarget lower 50.0
		
		rotCtrl.viewline_length_abs = off
		rotCtrl.upnode_world = off
		if findString upper.name "head" ==undefined then 
			rotCtrl.pickUpNode = upper
		else 
			rotCtrl.pickUpNode = lower
	)
	else if (classof muscle == point) then 
	(
		muscle.position.controller = position_expression()	
		muscle.position.controller.AddVectorTarget  "a" upper[3][1][2].controller
		muscle.position.controller.AddVectorTarget  "b" lower[3][1][2].controller
		muscle.position.controller.setExpression "(a+b)*0.5"
	)
)
	


try(DestroyDialog boneFin )catch() 
rollout boneFin "骨骼绑定工具"
(
	button displayBox "显示切换" height:21 width:80  across:2   tooltip:"显示Bone骨骼的鳍和Box显示"
	
	on displayBox pressed do 
	(
		if selection.count != 0 then 
		(
			for obj in selection where classof obj == BoneGeometry do 
			(
				state = obj.boxMode
				obj.boxMode = not state
				obj.frontfin = state
				obj.frontfinsize = 5
			)
		)
		else
		(
			for obj in objects where classof obj == BoneGeometry do 
			(
				state = obj.boxMode
				obj.boxMode = not state
				obj.frontfin = state
				obj.frontfinsize = 5
			)
		)
	)
	
	
	button createConerBone "肘和膝盖" height:21 width:80   tooltip:"依次选择父级和子级"
	
	on createConerBone pressed do 
	(
		upper = #($'Bip001 R UpperArm',$'Bip001 L UpperArm',$'Bip001 R Thigh',$'Bip001 L Thigh')
		lower = #($'Bip001 R Forearm',$'Bip001 L Forearm',$'Bip001 R Calf',$'Bip001 L Calf')
		num = selection.count 
		if num == 0 then 
		(
			for i = 1 to 4 do 
			(
				createForearmConer upper[i] lower[i]
			)
		)
		else 
		(
			for i = 1 to (num/2) do 
			(
				createForearmConer selection[i] selection[num/2+i]
			)
		)
		
	)
	
	button btmuscle "肌肉和脊椎"  height:21 width:80   tooltip:"依次选择3个物体 upper lower muscle" across:2
	
	on btmuscle pressed do 
	(
		objs = selection as array 
		createMuscleBone objs[1] objs[2] objs[3] 
			
	)
	
	on btmuscle rightclick do 
	(
		objs = selection as array 
		spineBone objs[1] objs[2] objs[3] 
		
		print "ABCD"
	)
	
	button btLegCtrl "腿部控制器" tooltip:"顺序选择upper，lower，leg选完一组再选另一组"
	on btLegCtrl pressed do 
	(
		num = selection.count
		temp = num/3
		if num !=0 then --顺序选择，选完一组再选另一组
		(
			for i = 1 to num by 3 do 
				(
					j = i+1
					k = i+2 
					legCtrl (selection[i]) (selection[j]) (selection[k])
				)
		)
	)
	
	button btSpineCtrl "创建脊椎控制器"  tooltip:"创建出来脊椎骨骼的控制器系统"
	
	on btSpineCtrl pressed do 
	(
		undo on 
		(
			bnArray = selection as array 
			for obj in bnArray do createCtrlByBone obj  --创建出来脊椎骨骼的控制器系统
		)
		
	)
		
)
createdialog boneFin 200 80