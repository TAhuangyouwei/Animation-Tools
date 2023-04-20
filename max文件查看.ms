try(DestroyDialog modelView ) catch()


rollout modelView "资源查看"
(
	edittext edittext_openFolderPath "max文件路径" fieldWidth:330 height:20 labelOnTop:true readOnly:false across:2  tooltip:"文件根目录"
	button clearEdit "清空" offset:[80,17]  tooltip:"清楚路径及列表"
	
	listbox maxList "max文件列表" items:#() selection:1 height:1  tooltip:"左键双击打开文件,右键单击打开选择的文件夹"
	label author "Author:HYW"
	global maxfiles
	global maxListItems
	
	on edittext_openFolderPath entered txt do 
	(
		maxopenpath = edittext_openFolderPath.text + "\\" + "*.max"
		maxopenpath = trimleft maxopenpath
		maxopenpath = trimRight maxopenpath	
		maxfiles = getFiles maxopenpath	recurse:true 
		
		
		maxListItems = #()
		for i = 1 to maxfiles.count do 
		(	
			maxFilesPath = getFilenamePath maxfiles[i]
			pathArray = filterString maxFilesPath "\\"
			folderName = pathArray[pathArray.count]
			
			append maxListItems (folderName + "\t==>\t" + getFilenameFile(maxfiles[i]))
			
		)
		
		maxList.items = maxListItems
		if maxListItems.count < 30 then 
		(
			maxList.height = (maxListItems.count-1)*13 + 19	
			modelView.height = 105 + (maxListItems.count - 1)*13
			author.pos.y = 89 + (maxListItems.count - 1)*13
		)		
		else 
		(
			maxList.height = 396	
			modelView.height = 492
			author.pos.y = 466
		)
			
	)
	

	
	on maxList doubleClicked itm do 
	(
		try
			(
			loadMaxFile maxfiles[maxList.selection] quiet:true 
			viewport.setLayout #layout_1
			viewport.setType #view_front
			max tool zoomextents
			) 
		catch
			(
			messageBox "文件有病毒,请手动打开，杀毒后请另存文件！"
			ShellLaunch (getFilenamePath(maxfiles[maxList.selection])) ""
			)
	)
	
	on maxList rightClick itm do 
	(	
-- 		pathConfig.getCurrentProjectFolder()   知识点
		ShellLaunch (getFilenamePath(maxfiles[maxList.selection])) ""
	)
	
	on clearEdit pressed do 
	(
		edittext_openFolderPath.text = ""
		maxList.items = #()
		maxList.height = 19
		modelView .height = 105
		author.pos.y = 89
	)
)
createdialog modelView width:400 height:105