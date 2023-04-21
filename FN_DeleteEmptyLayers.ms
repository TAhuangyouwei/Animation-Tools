fn DeleteEmptyLayers =  --删除空的层
(
	_defaultlayer = layerManager.getLayer 0
	_defaultlayer.current = true
	
	try
	(	
		_layersNum = layerManager.count - 1  --层的序号是从0开始计数的，所以减1,负号和1一定要分开，要不然报错
		_layers = for i = 1 to _layersNum collect i  --将每个层的引用存储在"_layers"列表中
		_revlayers = #()
		for i in _layers.count to 1 by -1 do append _revlayers _layers[i]   --遍历了"_layers"列表中所有的层，并将每个层的顺序倒序存储在"_revlayers"列表中。

		for j in _revlayers do
		(
			_getlayer = layerManager.getlayer j
			LayerManager.deleteLayerByName _getlayer.name
		)		
	)
	catch()
)

