fn Silhouette_Viewer =
(
	global store_amb--=color 0 0 0
	global store_tint--=color 255 255 255
	global tempimpl

	if (ambientColor==color 0 0 0) and (lightTintColor==color 0 0 0) then --关闭剪影
	(
		animButtonState = off
		hideByCategory.bones = off
		hideByCategory.helpers = off 
		
		impl = NitrousGraphicsManager.GetActiveViewportSetting()
		
		if impl != undefined then impl.VisualStyleMode = tempimpl
			
		ambientColor = store_amb
		lightTintColor = store_tint
		redrawViews()
	) 
	else   --显示剪影
	(
		animButtonState = off
		hideByCategory.bones  = on
		hideByCategory.helpers = on 
			
		impl = NitrousGraphicsManager.GetActiveViewportSetting()
		tempimpl = impl.VisualStyleMode
		if impl != undefined then impl.VisualStyleMode = #shaded
		
		store_amb=ambientColor
		store_tint=lightTintColor
		ambientColor=color 0 0 0
		lightTintColor=color 0 0 0
		redrawViews()
	)
)
