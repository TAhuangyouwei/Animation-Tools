try (DestroyDialog FacialRigDemo )catch ()
gc()
fn ctrlCreate = --一键创建单个元素
(

	hpPar = point box:off cross: on  size:1 wirecolor:red 
	hp = point box: on cross:off size:1 wirecolor:red  

	con = circle radius:0.4  wirecolor:yellow pos:[2,0,0] 
	
	bn = BoneSys.createBone [0,0,0] [2,0,0] [0,0,1] 
	
	bn.width = bn.height = 0.5
	
	convertToSplineShape con
	temp1 = copy con
	rotate temp1 (EulerAngles 90 0 0)
	temp2 = copy con
	rotate temp2 (EulerAngles 0 90 0)
	addAndWeld con temp1 0.1
	addAndWeld con temp2 0.1
		
	hp.parent = hpPar
	con.parent = hp 
	
	con.pivot = hp.pos
	
	hp.pos.controller = position_list()
	
	for i = 1 to 10 do 
	(
		hp.pos.controller.Available.controller = Position_XYZ ()
	)
	hpposlst = hp.pos.controller
	
	hpposlst.setName 2 "eyebrow_X"
	hpposlst.setName 3 "eyebrow_Y"
	hpposlst.setName 4 "zuoZuijiao_X"
	hpposlst.setName 5 "zuoZuijiao_Y"
	hpposlst.setName 6 "youZuijiao_X"
	hpposlst.setName 7 "youZuijiao_Y"
	hpposlst.setName 8 "upZuichun_X"
	hpposlst.setName 9 "upZuichun_Y"
	hpposlst.setName 10 "downZuichun_X"
	hpposlst.setName 11 "downZuichun_Y"

	
	
	hp.rotation.controller = rotation_list()
	
	for i = 1 to 10 do 
	(
		hp.rotation.controller.Available.controller = Euler_XYZ ()
	)
	hprotlst = hp.rotation.controller
	
	hprotlst.setName 2 "eyebrow_X"
	hprotlst.setName 3 "eyebrow_Y"
	hprotlst.setName 4 "zuoZuijiao_X"
	hprotlst.setName 5 "zuoZuijiao_Y"
	hprotlst.setName 6 "youZuijiao_X"
	hprotlst.setName 7 "youZuijiao_Y"
	hprotlst.setName 8 "upZuichun_X"
	hprotlst.setName 9 "upZuichun_Y"
	hprotlst.setName 10 "downZuichun_X"
	hprotlst.setName 11 "downZuichun_Y"
	
	
	
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
	
	bn.pos.controller = PositionList()
	bn.pos.controller.Available.controller = Position_Constraint ()
	bnposlst = bn.pos.controller
	bnposlst.SetActive 2
	bnposlst[2].constraints.appendTarget con 50.0
	
	bn.rotation.controller = RotationList()
	bn.rotation.controller.Available.controller = Orientation_Constraint ()
	bnrotlst = bn.rotation.controller
	bnrotlst.SetActive 2
	bnrotlst[2].constraints.appendTarget con 50.0
	
	rotate hpPar (EulerAngles 0 0 -90)

)


fn ctrlCreateNoBone bn = --创建控制器元素集,不创建Bone骨骼
(
		ctrlArray = #()
		hpPar = point box:off cross: on  size:bn.width wirecolor:red 
		hpPar.name = replace bn.name 1 2 "HpPar"
		hp = point box: on cross:off size:bn.width wirecolor:red  
		hp.name = replace bn.name 1 2 "HP"
		con = circle radius:(bn.width*0.6)  wirecolor:yellow pos:[bn.length,0,0]
		con.name = replace bn.name 1 2 "CON"
		convertToSplineShape con
		temp1 = copy con
		rotate temp1 (EulerAngles 90 0 0)
		temp2 = copy con
		rotate temp2 (EulerAngles 0 90 0)
		addAndWeld con temp1 0.1
		addAndWeld con temp2 0.1
			
		hp.parent = hpPar
		con.parent = hp 	
		con.pivot = hp.pos	
		hp.pos.controller = position_list()	
		hpPar.transform = bn.transform	
		
		
		for i = 1 to 10 do 
		(
			hp.pos.controller.Available.controller = Position_XYZ ()
		)
		hpposlst = hp.pos.controller	
		hpposlst.setName 2 "eyebrow_X"
		hpposlst.setName 3 "eyebrow_Y"
		hpposlst.setName 4 "zuoZuijiao_X"
		hpposlst.setName 5 "zuoZuijiao_Y"
		hpposlst.setName 6 "youZuijiao_X"
		hpposlst.setName 7 "youZuijiao_Y"
		hpposlst.setName 8 "upZuichun_X"
		hpposlst.setName 9 "upZuichun_Y"
		hpposlst.setName 10 "downZuichun_X"
		hpposlst.setName 11 "downZuichun_Y"	
		hp.rotation.controller = rotation_list()
		
		for i = 1 to 10 do 
		(
			hp.rotation.controller.Available.controller = Euler_XYZ ()
		)
		hprotlst = hp.rotation.controller	
		hprotlst.setName 2 "eyebrow_X"
		hprotlst.setName 3 "eyebrow_Y"
		hprotlst.setName 4 "zuoZuijiao_X"
		hprotlst.setName 5 "zuoZuijiao_Y"
		hprotlst.setName 6 "youZuijiao_X"
		hprotlst.setName 7 "youZuijiao_Y"
		hprotlst.setName 8 "upZuichun_X"
		hprotlst.setName 9 "upZuichun_Y"
		hprotlst.setName 10 "downZuichun_X"
		hprotlst.setName 11 "downZuichun_Y"	
		
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
		append ctrlArray hpPar
		append ctrlArray hp
		append ctrlArray con	
	
	return ctrlArray
)


fn HP_CreateByCtrl Ctrl = --根据控制器位置创建父物体虚拟体组合
(
		hpPar = point box:off cross: on  size:5 wirecolor:red 
		hpPar.name = replace Ctrl.name 3 2 "HpPar"
		hp = point box: on cross:off size:5 wirecolor:red  
		hp.name = replace Ctrl.name 3 2 "HP"

		hp.parent = hpPar
		hpPar.transform = Ctrl.transform	
		Ctrl.parent = hp 

		Ctrl.Position.controller = position_list ()
		Ctrl.Position.controller.Available.controller = Position_XYZ ()
		Ctrl.Position.controller[1].controller = Bezier_Position ()
		listctrl.setname Ctrl.Position.controller 1 "Frozen Position"
		listctrl.setname Ctrl.Position.controller 2 "Zero Pos XYZ"
		Ctrl.position.controller.SetActive 2 

		Ctrl.rotation.controller = Rotation_list ()
		Ctrl.rotation.controller.Available.controller = Euler_XYZ ()
		listctrl.setname Ctrl.rotation.controller 1 "Frozen Rotation"
		listctrl.setname Ctrl.rotation.controller 2 "Zero Euler XYZ"
		Ctrl.rotation.controller.SetActive 2 
	)




fn EyeCtrlCreate bn= --根据眼球骨骼创建控制器
(

	ctrlArray = #()
	hpPar = point box:off cross: on  size:bn.width wirecolor:red 
	hpPar.name = replace bn.name 1 2 "HpPar"
	hp = point box: on cross:off size:bn.width wirecolor:red  
	hp.name = replace bn.name 1 2 "HP"
	con = circle radius:(bn.width*0.6)  wirecolor:yellow pos:[bn.length,0,0]
	con.name = replace bn.name 1 2 "CON"
	convertToSplineShape con
	temp1 = copy con
	rotate temp1 (EulerAngles 90 0 0)
	temp2 = copy con
	rotate temp2 (EulerAngles 0 90 0)
	addAndWeld con temp1 0.1
	addAndWeld con temp2 0.1
	
	hp.parent = hpPar
	con.parent = hp 	
	hp.pos.controller = position_list()	
	hpPar.transform	= bn.transform
	
	for i = 1 to 10 do 
	(
		hp.pos.controller.Available.controller = Position_XYZ ()
	)
	hpposlst = hp.pos.controller
	
	hpposlst.setName 2 "eyebrow_X"
	hpposlst.setName 3 "eyebrow_Y"
	hpposlst.setName 4 "zuoZuijiao_X"
	hpposlst.setName 5 "zuoZuijiao_Y"
	hpposlst.setName 6 "youZuijiao_X"
	hpposlst.setName 7 "youZuijiao_Y"
	hpposlst.setName 8 "upZuichun_X"
	hpposlst.setName 9 "upZuichun_Y"
	hpposlst.setName 10 "downZuichun_X"
	hpposlst.setName 11 "downZuichun_Y"

	
	
	hp.rotation.controller = rotation_list()
	
	for i = 1 to 10 do 
	(
		hp.rotation.controller.Available.controller = Euler_XYZ ()
	)
	hprotlst = hp.rotation.controller
	
	hprotlst.setName 2 "eyebrow_X"
	hprotlst.setName 3 "eyebrow_Y"
	hprotlst.setName 4 "zuoZuijiao_X"
	hprotlst.setName 5 "zuoZuijiao_Y"
	hprotlst.setName 6 "youZuijiao_X"
	hprotlst.setName 7 "youZuijiao_Y"
	hprotlst.setName 8 "upZuichun_X"
	hprotlst.setName 9 "upZuichun_Y"
	hprotlst.setName 10 "downZuichun_X"
	hprotlst.setName 11 "downZuichun_Y"
	
	
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
	
	bn.pos.controller = PositionList()
	bn.pos.controller.Available.controller = Position_Constraint ()
	bnposlst = bn.pos.controller
	bnposlst.SetActive 2
	bnposlst[2].constraints.appendTarget hp 50.0
	
	bn.rotation.controller = RotationList()
	bn.rotation.controller.Available.controller = LookAt_Constraint ()
	bnrotlst = bn.rotation.controller
	bnrotlst.SetActive 2
	bnrotlst[2].constraints.appendTarget con 50.0
	bnrotlst[2].lookat_vector_length = 0
	bnrotlst[2].upnode_world = off
	bnrotlst[2].pickUpNode = hp
	
	append ctrlArray hpPar
	append ctrlArray hp
	append ctrlArray con

	return ctrlArray
)

fn ctrlCreateGetBonePos bnArray  = --根据骨骼位置，创建所有虚拟体
(
	for bn = 1 to bnArray.count do 
	(
		if findString bnArray[bn].name "BN_Eye_L_01" !=undefined or findString bnArray[bn].name "BN_Eye_R_01" !=undefined  then 
		(
			EyeCtrlCreate bnArray[bn]
		)
		else 
		(
			ctrlArray = ctrlCreateNoBone bnArray[bn] --ctrlArray[1] 就是父物体不用判断
			bnArray[bn].pos.controller = PositionList()
			bnArray[bn].pos.controller.Available.controller = Position_Constraint ()
			bnArray[bn].pos.controller.SetActive 2		
			bnArray[bn].pos.controller[2].constraints.appendTarget ctrlArray[3] 50.0
			
			bnArray[bn].rotation.controller = RotationList()
			bnArray[bn].rotation.controller.Available.controller = Orientation_Constraint ()
			bnArray[bn].rotation.controller.SetActive 2
			bnArray[bn].rotation.controller[2].constraints.appendTarget ctrlArray[3] 50.0
		)

		
		
	)

)

fn facialControlSquare=  --创建方形表情控制器
(
	rec=Rectangle length:10 width:10 name:(uniqueName "FaceControl") wireColor:[0,0,200] displayRenderMesh:false render_displayRenderMesh:true render_thickness:0.3
	cir=circle radius:1 name:(uniqueName "FaceControlHandle") wireColor:[200,0,0] displayRenderMesh:false render_displayRenderMesh:true render_thickness:0.3
	cir.parent=rec
	setTransformLockFlags cir #{3..9}
	
	conName=text text:"控制器" size:2 wireColor:[255,255,0] pos:[0,6,0] alignment:2 displayRenderMesh:false  font:"仿宋"
	conName.parent=rec
	addModifier conName (meshSelect())
	setTransformLockFlags conName #{1..9}
	rec.rotation.x_rotation=90
	
		
	cir.Position.controller = position_list ()
	cir.Position.controller.Available.controller = Position_XYZ ()
    cir.Position.controller[1].controller = Bezier_Position ()
    listctrl.setname cir.Position.controller 1 "Frozen Position"
    listctrl.setname cir.Position.controller 2 "Zero Pos XYZ"
    cir.position.controller.SetActive 2 

    cir.rotation.controller = Rotation_list ()
    cir.rotation.controller.Available.controller = Euler_XYZ ()
    listctrl.setname cir.rotation.controller 1 "Frozen Rotation"
    listctrl.setname cir.rotation.controller 2 "Zero Euler XYZ"
    cir.rotation.controller.SetActive 2 

	fl=float_limit()
	cir.pos.controller[2][1].controller=fl
	paramWire.connect rec.baseObject[#width] fl.limits[#upper_limit] "width/2"
	paramWire.connect rec.baseObject[#width] fl.limits[#lower_limit] "-width/2"
	
	fl=float_limit()
	cir.pos.controller[2][2].controller=fl
    paramWire.connect rec.baseObject[#length] fl.limits[#upper_limit] "length/2"
	paramWire.connect rec.baseObject[#length] fl.limits[#lower_limit] "-length/2"
	
	fl=float_limit()
	cir.pos.controller[2][3].controller=fl
	fl.limits[#upper_limit].value=0
	fl.limits[#lower_limit].value=0
)

fn facialControlBar= --创建条形表情控制器
(
	rec=Rectangle length:10 width:1 name:(uniqueName "FaceControl") wireColor:[0,0,200] displayRenderMesh:false render_displayRenderMesh:true render_thickness:0.3
	cir=circle radius:1 name:(uniqueName "FaceControlHandle") wireColor:[200,0,0] displayRenderMesh:false  render_displayRenderMesh:true render_thickness:0.3
	cir.parent=rec 
	setTransformLockFlags cir #{3..9}
	
	conName=text text:"控制器" size:2 wireColor:[255,255,0] pos:[0,6,0] alignment:2 displayRenderMesh:false  font:"仿宋"	
	conName.parent=rec
	addModifier conName (meshSelect())
	setTransformLockFlags conName #{1..9}
	
	rec.rotation.x_rotation=90
	
		
	cir.Position.controller = position_list ()
	cir.Position.controller.Available.controller = Position_XYZ ()
    cir.Position.controller[1].controller = Bezier_Position ()
    listctrl.setname cir.Position.controller 1 "Frozen Position"
    listctrl.setname cir.Position.controller 2 "Zero Pos XYZ"
    cir.position.controller.SetActive 2 

    cir.rotation.controller = Rotation_list ()
    cir.rotation.controller.Available.controller = Euler_XYZ ()
    listctrl.setname cir.rotation.controller 1 "Frozen Rotation"
    listctrl.setname cir.rotation.controller 2 "Zero Euler XYZ"
    cir.rotation.controller.SetActive 2 

	fl=float_limit()
	cir.pos.controller[2][1].controller=fl
	fl.limits[#upper_limit].value=0
	fl.limits[#lower_limit].value=0
	
	fl=float_limit()
	cir.pos.controller[2][2].controller=fl
    paramWire.connect rec.baseObject[#length] fl.limits[#upper_limit] "length/2"
	paramWire.connect rec.baseObject[#length] fl.limits[#lower_limit] "-length/2"
	
	fl=float_limit()
	cir.pos.controller[2][3].controller=fl
	fl.limits[#upper_limit].value=0
	fl.limits[#lower_limit].value=0
)

fn SwitchLayer i = --   切换虚拟体层级
(
	hpArray = for j in objects where classof j == point and j.box == true collect j 
	for k = 1 to hpArray.count do 
	(
		hpArray[k].position.controller.SetActive i
		hpArray[k].rotation.controller.SetActive i
	)
)

fn resetObjectController = --重置当前选中骨骼或场景中骨骼的控制属性
(
	if selection.count == 0 then 
	(
		bnArray = for o in objects where classof o == BoneGeometry collect o 
		if bnArray.count !=0 then  
		(
			for i = 1 to bnArray.count do 
			(
				tempTransform = bnArray[i].transform
				bnArray[i].pos.controller = Position_XYZ ()
				bnArray[i].rotation.controller = Euler_XYZ ()
				
				bnArray[i].transform = tempTransform 
			)
		)
	)
	else
	(
		bnArray = for o in selection where classof o == BoneGeometry collect o 
		if bnArray.count !=0 then  
		(
			for i = 1 to bnArray.count do 
			(
				tempTransform = bnArray[i].transform
				bnArray[i].pos.controller = Position_XYZ ()
				bnArray[i].rotation.controller = Euler_XYZ ()
				
				bnArray[i].transform = tempTransform 
			)
		)
	)

)

fn reNameNub = --重命名末端骨骼
(
	if selection.count != 0 then 
	(
		nubArray = for i in selection where ((classof i == BoneGeometry) and (i.parent != undefined) and (i.children.count == 0) and (classof i.parent ==  BoneGeometry )) collect i 
	)
	else 
	(
		nubArray = for i in objects where ((classof i == BoneGeometry) and (i.parent != undefined) and (i.children.count == 0) and (classof i.parent ==  BoneGeometry )) collect i 
	)
	
	for i in nubArray do i.name = i.name + "Nub"
		
)

fn facialControl =  --创建所有表情UI控制器
(
	strArrayText = #("右眉毛","  左眉毛","右眼皮","眼球","  左眼皮","上嘴唇","右嘴角","  左嘴角","下嘴唇","下巴")
	
	circleCtrlArrayName = #("EyeBrow_R_C","EyeBrow_L_C","Eyelid_R_C","EyeBall_C","Eyelid_L_C","UpLip_C","Lip_R_C","Lip_L_C","DownLip_C","Jaw_C")
	
	ctrlParent = Rectangle length:90 width:40 cornerRadius:0 transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) wirecolor:yellow  cornerRadius:9 render_displayRenderMesh:true render_thickness:0.3
	
	posArray = #([-7,35,0],[7,35,0],[-12,20,0],[0,20,0],[12,20,0],[0,5,0],[-7,-8,0],[7,-8,0],[0,-22,0],[0,-37,0])
	
	for i = 1 to strArrayText.count do 
	(
		rec= Rectangle length:10 width:10 name:(uniqueName "FaceControl") wireColor:[0,0,200] transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) displayRenderMesh:false  render_displayRenderMesh:true render_thickness:0.3
		rec.showFrozenInGray = off
		freeze rec
		if findString strArrayText[i]  "眼皮" != undefined then 
		(
			posArrayTwo = #([-1.35967,0,0.679834],[-1.35967,-2.21518e-07,1.35967],[-2.71934,0,0],[-1.35967,2.21518e-07,-1.35967],[-1.35967,0,-0.679834],[1.35967,0,-0.679834],[1.35967,2.21518e-07,-1.35967],[2.71934,0,0],[1.35967,-2.21518e-07,1.35967],[1.35967,0,0.679834])
			
			cir = splineShape wireColor:[200,0,0]  render_displayRenderMesh:true render_thickness:0.3 name:circleCtrlArrayName[i]
			addnewSpline cir
			for i = 1 to 10 do 
			(
				addKnot cir 1 #corner #line posArrayTwo[i]
			)
			close cir 1
			updateShape cir
		)
		else if findString strArrayText[i] "下巴" != undefined then 
		(
			posArrayFour = #([0,-1.78284e-07,1.0943],[-0.437719,0,0.656578],[-0.218859,0,0.656578],[-0.218859,0,0.218859],[-0.656578,0,0.218859],[-0.656578,0,0.437719],[-1.0943,0,0],[-0.656578,0,-0.437719],[-0.656578,0,-0.218859],[-0.218859,0,-0.218859],\
			[-0.218859,0,-0.656578],[-0.437719,0,-0.656578],[0,1.78284e-07,-1.0943],[0.437719,0,-0.656578],[0.218859,0,-0.656578],[0.218859,0,-0.218859],[0.656578,0,-0.218859],[0.656578,0,-0.437719],[1.0943,0,0],[0.656578,0,0.437719],[0.656578,0,0.218859],\
			[0.218859,0,0.218859],[0.218859,0,0.656578],[0.437719,0,0.656578])
			
			cir = splineShape wireColor:[200,0,0]  render_displayRenderMesh:true render_thickness:0.3 name:circleCtrlArrayName[i]
			addnewSpline cir
			for i = 1 to 24 do 
			(
				addKnot cir 1 #corner #line posArrayFour[i]
			)
			close cir 1
			updateShape cir
		)
		else
		(
			cir= circle radius:1 name:circleCtrlArrayName[i] wireColor:[200,0,0] transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) displayRenderMesh:false render_displayRenderMesh:true render_thickness:0.3
		)
		
		conName=text text:strArrayText[i] size:2 wireColor:[255,255,0] transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,6]) alignment:2 displayRenderMesh:false  font:"仿宋"
		conName.showFrozenInGray = off
		freeze conName
		cir.parent = rec
		rec.parent = ctrlParent
		if findString strArrayText[i] "右" != undefined then 
		(
			in coordsys parent rotate rec (EulerAngles 0 180 0)
		)
		conName.parent = rec
		in coordsys parent rec.pos = posArray[i]
		conName.parent=rec
		addModifier conName (meshSelect())
		setTransformLockFlags conName #{1..9}  --锁死字体的移动旋转缩放
		cir.Position.controller = position_list ()
		cir.Position.controller.Available.controller = Position_XYZ ()
		cir.Position.controller[1].controller = Bezier_Position ()
		listctrl.setname cir.Position.controller 1 "Frozen Position"
		listctrl.setname cir.Position.controller 2 "Zero Pos XYZ"
		cir.position.controller.SetActive 2 

		cir.rotation.controller = Rotation_list ()
		cir.rotation.controller.Available.controller = Euler_XYZ ()
		listctrl.setname cir.rotation.controller 1 "Frozen Rotation"
		listctrl.setname cir.rotation.controller 2 "Zero Euler XYZ"
		cir.rotation.controller.SetActive 2 

		fl=float_limit()
		cir.pos.controller[2][1].controller=fl
		paramWire.connect rec.baseObject[#width] fl.limits[#upper_limit] "width/2"
		paramWire.connect rec.baseObject[#width] fl.limits[#lower_limit] "-width/2"
		
		fl=float_limit()
		cir.pos.controller[2][2].controller=fl
		paramWire.connect rec.baseObject[#length] fl.limits[#upper_limit] "length/2"
		paramWire.connect rec.baseObject[#length] fl.limits[#lower_limit] "-length/2"
		
		fl=float_limit()
		cir.pos.controller[2][3].controller=fl
		fl.limits[#upper_limit].value=0
		fl.limits[#lower_limit].value=0
		
	)

)

fn createFaceBones =  --根据文档中骨骼名称和坐标创建面部骨骼
(
	
	
	boneNamePath = (getdir #defaults + "\boneName.txt")
	file_Name = openFile boneNamePath
	boneName = #()
	while not eof file_Name do(
	   strinNameLine = readline file_Name
		append boneName strinNameLine
		
	)
	close file_Name 


	bonePosPath = (getdir #defaults + "\bonePos.txt")
	file_Pos = openFile bonePosPath
	bonePos = #()
	while not eof file_Pos do(
	   strinPosLine = readline file_Pos
		append bonePos (execute strinPosLine)
		
	)
	close  file_Pos
	
	
	
	
	faceBones = #()
	bn = BoneSys.createBone [0,0,0] [0,-2,0] [0,0,1] 	
	num = boneName.count
	for i = 1 to num do 
	(
		tempBone = copy bn name:boneName[i] transform:bonePos[i]
		append faceBones tempBone
		if tempBone.name != "BN_Head_Root_M01"  then 
		(
			tempBone.boneEnable=true
			tempBone.parent = $BN_Head_Root_M01
		)
		
	)
	$BN_Head_Root_M01.length = 20
	$BN_Jaw_01.length =15
	$BN_EyePupil_L_01.parent = $BN_Eye_L_01
	$BN_EyePupil_R_01.parent = $BN_Eye_R_01


	delete bn 
)

fn getBoneInformation =  --提取骨骼信息
(
	OutfileName  = createFile (getdir #defaults + "boneName.txt")

	OutfilePos  = createFile (getdir #defaults + "bonePos.txt")


	for obj in selection do 
	(
	format "%\n" obj.name to:OutfileName
	format "%\n" obj.transform to:OutfilePos
	)

	close OutfileName
	close OutfilePos
	
)


fn addObjToReact = --反应管理器
(
	--右眉毛
	obj = #($HP_EyeBrow_R_01,$HP_EyeBrow_R_02,$HP_EyeBrow_R_03)
	for i = 1 to 3 do
	(	
-- 		pos.controller[2].controller.x_position.controller
		for j = 1 to 3 do 
		(
			contPos = obj[i][3][1][2][j].controller  = float_Reactor()  --pos 
			contRot = obj[i][3][2][2][j].controller  = float_Reactor()  --rot 
			reactTo contPos $EyeBrow_R_C[3][1][2][1][1].controller
			reactTo contRot $EyeBrow_R_C[3][1][2][1][1].controller
			
			reactTo contPos $EyeBrow_R_C[3][1][2][2][1].controller
			reactTo contRot $EyeBrow_R_C[3][1][2][2][1].controller
		)

	)
	
	
	
)

thk = false
rollout FacialRigDemo "表情绑定"
(
	 
	group "UI控制器"
	(
		button fangCtrl "方形" across:4
		button allCtrl "全"
		button tiaoCtrl "条形"
		button btShapeThick "粗细"
		
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
		on btShapeThick pressed do 
		(
			
			if thk==true then 
			(
				shapeObj = for obj in shapes collect obj 
				shapeObj.render_displayRenderMesh = true 
				shapeObj.render_thickness = 0.3
				thk = false 
			)
			else 
			(
				shapeObj = for obj in shapes collect obj 
				shapeObj.render_displayRenderMesh = false 
				thk = true
			)
			
		)
	)
	
	group "表达式控制器"
	(
		button btCreateByBone "控制器" height:21 width:60 toolTip:"对选择的表情骨骼创建控制器,或者对选择的控制器创建父物体" across:3
		button btCreate "单个创建"  toolTip:"创建一个最小元素"
		button btResetBone "骨骼还原"
		button btFaceBone "创建骨骼" across:2
		button btBonInfor "提取信息" tooltip:"把当前选择的bone骨骼的名称和坐标提取到文档中"
		
		
		on btCreateByBone pressed do 
		(
			with redraw off
			(
				undo off 
				(
						bnArray = for o in selection where classof o == BoneGeometry collect o 
						if bnArray.count !=0 then  
							ctrlCreateGetBonePos bnArray
						else if selection.count !=0 then 
						(
							ctrlArray = for obj in selection where classof obj == SplineShape collect obj
							for obj in ctrlArray do HP_CreateByCtrl obj
						)
						
				)
			)

		)
		
		on btCreate pressed do 
		(
			ctrlCreate()
			print btCreate.width 
			print btCreate.height
		)
		
		on btResetBone pressed do 
		(
			resetObjectController()
		)
		on btFaceBone pressed do 
		(
			createFaceBones()
		)
		on btBonInfor pressed do 
		(
			getBoneInformation()
		)
		
	)
	
	group "骨骼属性"
	(
		spinner spBonewidth "粗细:"  range:[0,999999,0.2] fieldwidth:50 across:2
		spinner spBoneLength "长短:"  range:[0,999999,2] fieldwidth:50
		
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
	
	
	group "场景清理"
	(
		button resetScene "R" across:4 tooltip:"重置场景，不保存"
		button holdScene "H" tooltip:"暂存场景"
		button fetchScene "F"  tooltip:"取回暂存场景"
		button saveScene "S"  tooltip:"保存场景"
		
		on resetScene pressed do resetMaxFile #noPrompt
			on holdScene pressed do holdMaxFile()
				on fetchScene pressed do fetchMaxFile quiet:true
					on saveScene pressed do
					(
						filename = maxFilePath + maxFileName
						saveMaxFile filename saveAsVersion:2019
					)						
		
	)
	
		group "切换虚拟体层级"
	(
		dropdownlist layerName "层级列表" items:#("Position_XYZ","eyebrow_X","eyebrow_Y","zuoZuijiao_X","zuoZuijiao_Y","youZuijiao_X","youZuijiao_Y","upZuichun_X","upZuichun_Y","downZuichun_X","downZuichun_Y")	selection:1 height:12
		
		on layerName selected i do 
		(
			SwitchLayer i
		)
	)
	group "规范骨骼名称"
	(
		dropdownlist boneNamelist "层级列表" items:#("左眉毛","左眼睛","左颧骨","左上嘴唇","上嘴唇","右上嘴唇","左下嘴唇","下嘴唇","右下嘴唇","下巴","鼻子","右眉毛","右眼睛","右颧骨","头")	selection:1 height:16
		
		button btRenameBone "重命名" across:3 toolTip:"选择面部骨骼进行重命名"
		
		button reNameNubBone "末端骨" toolTip:"在末端骨后面加上Nub后缀"
		
		button btPoseSaver "POSE"
		
		on btRenameBone pressed do 
		(
			case boneNamelist.selection of 
			(
				1: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_EyeBrow_L_"  numDigits:2	--左眉毛
				
				2: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_Eye_L_"  numDigits:2		--左眼睛
				
				3: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_CheekBone_L_"  numDigits:2	--左颧骨
				
				4: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_UpLip_L_"  numDigits:2		--左上嘴唇
				
				5: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_UpLip_"  numDigits:2		--上嘴唇
				
				6: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_UpLip_R_"  numDigits:2	--右上嘴唇
				
				7: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_DownLip_L_"  numDigits:2	--左下嘴唇
				
				8: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_DownLip_"  numDigits:2	--下嘴唇
				
				9: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_DownLip_R_"  numDigits:2	--右下嘴唇
				
				10: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_Jaw_"  numDigits:2	--下巴
				
				11: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_Nose_"  numDigits:2	--鼻子
				
				12: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_EyeBrow_R_"  numDigits:2	--右眉毛
				
				13: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_Eye_R_"  numDigits:2	--右眼睛
				
				14: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_CheekBone_R_"  numDigits:2	--右颧骨
				
				15: for i = 1 to selection.count  where classof selection[i] == BoneGeometry do selection[i].name = uniqueName "BN_Head_"  numDigits:2	--头
				
				default: print "none of the above"
			)
		)
		
		on reNameNubBone pressed do 
		(
			reNameNub()
		)
		

		on btPoseSaver pressed do 
		(
-- 			global SalPoseManager
			
			currentFolder = getFilenamePath (getThisScriptFilename())
			rulesScript = pathConfig.appendPath currentFolder "/SalPoseManager.ms"  --规范检查
			fileIn rulesScript
			if SalPoseManager !=undefined then
				SalPoseManager.initiate()
			else
				messageBox "Can't find Sal Pose Manager Script" title:"Script Not Found"
			OK
			
		)
		
	)
	label authorName "作者：HYW" 
)
	
CreateDialog FacialRigDemo 230  420