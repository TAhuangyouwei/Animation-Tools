fn mapChannelNum = --ѡ�񳡾���UV��������2������
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
		messageBox ("��ѡ�г�����ģ��UV����1��ģ�ͣ�����"+ (mapChannelNumTemp.count as string) +"��")
	)
)

fn unitCheck =
(
	if units.SystemScale  != 1.0 or units.SystemType != #Centimeters then  --��λ���
	(
		cd = queryBox "��λ�����Ƿ��޸�"  --�����ж�
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
		
		if obj.scale != [1,1,1] then 
		(
			append tempScale obj 
			
		)
	)
	if tempScale.count !=0 then 
	(
		cd = queryBox ("�����������ģ��������"+( tempScale.count as string) +"�����Ƿ�ѡ�������������ģ��")  --�����ж�
		if cd == true then 
		(
			selectmore tempScale
		)
	)
	
	
)


fn objAxis =   --���ģ�������Ƿ�Y������
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
		cd = queryBox ("�����λ���������ģ��������"+( tempAxis.count as string) +"�����Ƿ�ѡ���������ģ��")
		if cd == true then 
		(
			selectmore tempAxis
		)				
		
	)
)


fn standardCheck =
(
			mapChannelNum() --���ģ����ͼͨ������
			unitCheck()		--��鳡����λ
			scaleCheck()	--���ģ���Ƿ�������
			objAxis() 		--���ģ�������Ƿ�Y������
	
)