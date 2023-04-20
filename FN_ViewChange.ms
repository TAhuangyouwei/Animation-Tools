fn ProgrammeView =  --程序视图
(
	viewport.ResetAllViews()

	viewport.setLayout #layout_2v 

	viewport.activeViewportEx  1

	actionMan.executeAction 0 "40410"  -- Views: Extended Views 7
)

fn AnimView =  --动画视图
(
	viewport.ResetAllViews()
	max tool maximize
)