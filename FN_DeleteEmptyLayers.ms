fn DeleteEmptyLayers =  --ɾ���յĲ�
(
	_defaultlayer = layerManager.getLayer 0
	_defaultlayer.current = true
	
	try
	(	
		_layersNum = layerManager.count - 1  --�������Ǵ�0��ʼ�����ģ����Լ�1,���ź�1һ��Ҫ�ֿ���Ҫ��Ȼ����
		_layers = for i = 1 to _layersNum collect i  --��ÿ��������ô洢��"_layers"�б���
		_revlayers = #()
		for i in _layers.count to 1 by -1 do append _revlayers _layers[i]   --������"_layers"�б������еĲ㣬����ÿ�����˳����洢��"_revlayers"�б��С�

		for j in _revlayers do
		(
			_getlayer = layerManager.getlayer j
			LayerManager.deleteLayerByName _getlayer.name
		)		
	)
	catch()
)
