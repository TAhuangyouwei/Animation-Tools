for obj in selection do 
(
	for i = 1 to 2 do 
	(
		count = obj[3][i].count
		while count >1 do 
		(
			obj[3][i].delete 2
			count = obj[3][i].count
		)
	)

)
