try(DestroyDialog modelView ) catch()


rollout modelView "资源查看"
(
	edittext edittext_filt "指定关键词" fieldWidth:150 height:20 labelOnTop:true readOnly:false  tooltip:"筛选出包含关键词的文件，关键词是<或者>的关系" across:3 
	edittext edittext_openFolderPath "max文件路径" fieldWidth:150 height:20 labelOnTop:true readOnly:false  tooltip:"文件根目录" offset:[40,0]
	button clearEdit "清空"   tooltip:"清楚路径及列表"  offset:[50,17]
	listbox maxList "max文件列表" items:#() selection:1 height:1  tooltip:"左键双击打开文件,右键单击打开选择的文件夹"
	label author "Author:HYW"

	global maxfiles = #()
	global maxListItems = #()
	global sequences
	
	on edittext_openFolderPath entered txt do 
	(
		maxopenpath = edittext_openFolderPath.text + "\\" + "*.max"
		maxopenpath = trimleft maxopenpath
		maxopenpath = trimRight maxopenpath	
		maxfiles = getFiles maxopenpath	recurse:true 
		sequences = #()  --用于存储文件序列号，方便右键打开对应文件夹
		allwords = edittext_filt.text
		keyWords = filterString allwords "， -"
		
		
		maxListItems = #()
		for i = 1 to maxfiles.count do 
		(	
			maxFilesPath = getFilenamePath maxfiles[i]
			pathArray = filterString maxFilesPath "\\"
			folderName = pathArray[pathArray.count]
			
			if keyWords.count == 0 then 
				append maxListItems (folderName + "\t==>\t" + getFilenameFile(maxfiles[i]))
			else if keyWords.count ==1 then 
			(
				if findString maxfiles[i] keyWords[1] != undefined then 
				(
					append maxListItems (folderName + "\t==>\t" + getFilenameFile(maxfiles[i]))
					append sequences i
					
				)
			)
			else if keyWords.count >=2 then
			(
				
				for j = 1 to keyWords.count do 
				(
					if findString maxfiles[i] keyWords[j] != undefined then 
					(
						append maxListItems (folderName + "\t==>\t" + getFilenameFile(maxfiles[i]))
						append sequences i
						
					)
				)
--目前仅支持关键词取或，不支持取并
				
			)
			
		)
		

		
		maxList.items = maxListItems
		if maxListItems.count < 30 and maxListItems.count > 0 then 
		(
			maxList.height = (maxListItems.count-1)*13 + 19	
			modelView.height = 105 + (maxListItems.count - 1)*13
			author.pos.y = 89 + (maxListItems.count - 1)*13
		)
		else if maxListItems.count == 0 then 
		(
			edittext_openFolderPath.text = ""
			maxList.items = #()
			maxList.height = 19
			modelView .height = 105
			author.pos.y = 89
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
		n1 = maxList.selection
		num = sequences[n1]
-- 		pathConfig.getCurrentProjectFolder()   知识点
		ShellLaunch (getFilenamePath(maxfiles[num])) ""
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