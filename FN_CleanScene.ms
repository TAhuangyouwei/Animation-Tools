fn deleteParticalView =  --É¾³ýÁ£×ÓÊÓÍ¼
(
	delete $'particle view*'
	
	delete $'Á£×ÓÊÓÍ¼*'	
)


fn deletePoints =
(
	objs = for obj in objects where( (classof obj == Point) and ((findString obj.name "¡¡×û×ú" !=undefined ) or (findString obj.name "¡Át¡Á¨¹" !=undefined ) or (findString obj.name "??¡Áy¡Á?" !=undefined ))) collect obj 
	delete objs
)


fn deleteDayReca =
(
	z=1

	while z !=undefined do

	(

	x = rootscene

	z = custattributes.getdef x 1

	custAttributes.delete x z

	)

	xx = rootscene.custAttributes
	for i =1 to xx.count do deleteItem xx 1
)

fn cleanScene =
(
	deleteParticalView()
	deletePoints()
	deleteDayReca()
)