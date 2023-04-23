fn mapChannelNum = --选择场景中UV数量大于2的物体
(
	mapChannelNumTemp = #()
	for obj in objects where classof obj.baseobject == Editable_Poly do
		(
			num = polyop.getNumMaps obj
			if num >2 then 
			(
				append mapChannelNumTemp obj 
				
			)
		)
	 
	if mapChannelNumTemp.count != 0 then 
	(
		clearSelection()
		select mapChannelNumTemp
		messageBox ("已选中场景中模型UV大于1的模型，共有"+ (mapChannelNumTemp.count as string) +"个")
	)
)

fn unitCheck =
(
	if units.SystemScale  != 1.0 or units.SystemType != #Centimeters then  --单位检查
	(
		cd = queryBox "单位错误，是否修复"  --条件判断
		if cd == true then 
		(
			units.DisplayType = #Metric
			units.MetricType = #meters
			units.SystemScale  = 1.0
			units.SystemType = #Centimeters
		)
		
	)
)

fn scaleCheck =
(
	tempScale =#()
	for obj in objects where classof obj.baseobject == Editable_Poly do
	(
		
		if abs(obj.scale.x - 1) > e^-5 or abs(obj.scale.x - 1) > e^-5  or abs(obj.scale.x - 1) > e^-5  then 
		(
			append tempScale obj 
			
		)
	)
	if tempScale.count !=0 then 
	(
		cd = queryBox ("缩放有问题的模型数量有"+( tempScale.count as string) +"个，是否选中缩放有问题的模型")  --条件判断
		if cd == true then 
		(
			selectmore tempScale
		)
	)
	
	
)


fn objAxis =   --检查模型轴向是否Y轴向上
(
	tempAxis =#()			
	for obj in objects where classof obj.baseobject == Editable_Poly do 
	(
		if obj.rotation != (quat 0.707107 0 0 0.707107) then 
		(
			append tempAxis obj 
			
		)
		else if obj.position != [0,0,0] then 
		(
			if abs (obj.position.x) <0.0001 or abs (obj.position.y )<0.0001 or abs (obj.position.z) <0.0001 then 
				obj.position =[0,0,0]
			else 
				append tempAxis obj 
		
		)
	)
	if tempAxis.count !=0 then 
	(
		cd = queryBox ("轴向或位置有问题的模型数量有"+( tempAxis.count as string) +"个，是否选中有问题的模型")
		if cd == true then 
		(
			selectmore tempAxis
		)				
		
	)
)


fn standardCheck =
(
			mapChannelNum() --检查模型贴图通道数量
			unitCheck()		--检查场景单位
			scaleCheck()	--检查模型是否有缩放
			objAxis() 		--检查模型轴向是否Y轴向上
	
)