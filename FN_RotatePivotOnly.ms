fn RotatePivotOnly obj rotation =  --Ðý×ª×ø±êÖá
(
	local rotValInv=inverse (rotation as quat)
	animate off in coordsys local obj.rotation*=RotValInv
	obj.objectoffsetpos*=RotValInv
	obj.objectoffsetrot*=RotValInv
)

