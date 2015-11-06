<?php
$app->group('/Order', function () use ($app) 
{
	#
	# 新增订单
	#
	# POST	https://<endpoint>/Order/ConsumerId/[ConsumerId]/ProductId/[ProductId]
	#
	# Request Body 
	#
	# {
	#   "Count":"订购量",
    #   "Unit":"单位(个，只，斤)",
    #   "Description":"说明和要求",
	#   "ConsigneeId":"收货人ID"
	# }
	#
	$app->post('/ConsumerId/:ConsumerId/ProductId/:ProductId', function($ConsumerId, $ProductId) use ($app)
	{
		$order = new Order($app);
		echo $order->post_Consumer_Product($ConsumerId, $ProductId);
	});


	#
	# 订单详情查询
	#
	# GET	https://<endpoint>/Order/[OrderId]
	#
	$app->get('/:OrderId', function($OrderId) use ($app)
	{
		$order = new Order($app);
		echo $order->get_OrderId($OrderId);
	});


	#
	# 农场主订单列表查询
	#
	# GET	https://<endpoint>/Order/Producer/[ProducerId]/?status=0&offset=0&limit=15
	#
	$app->get('/Producer/:ProducerId/', function($ProducerId) use ($app)
	{
		$order = new Order($app);
		echo $order->get_ProducerId($ProducerId);
	});


	#
	# 农场主订单总数查询
	#
	# GET	https://<endpoint>/Order/Producer/[ProducerId]/Count/
	#
	$app->get('/Producer/:ProducerId/Count/', function($ProducerId) use ($app)
	{
		$order = new Order($app);
		echo $order->getProducerOrderCount($ProducerId);
	});


	#
	# 农场主订单总数查询 - 所有状态各自的总数
	#
	# GET	https://<endpoint>/Order/Producer/[ProducerId]/Count/Detail/
	#
	$app->get('/Producer/:ProducerId/Count/Detail/', function($ProducerId) use ($app)
	{
		$order = new Order($app);
		echo $order->getProducerOrderDetailCount($ProducerId);
	});


	#
	# 消费者订单列表查询
	#
	# GET	https://<endpoint>/Order/Consumer/[ConsumerId]/?status=0&offset=0&limit=15
	#
	$app->get('/Consumer/:ConsumerId/', function($ConsumerId) use ($app)
	{
		$order = new Order($app);
		echo $order->get_ConsumerId($ConsumerId);

	});


	#
	# 消费者订单总数查询
	#
	# GET	https://<endpoint>/Order/Consumer/[ConsumerId]/Count/
	#
	$app->get('/Consumer/:ConsumerId/Count/', function($ConsumerId) use ($app)
	{
		$order = new Order($app);
		echo $order->getConsumerOrderCount($ConsumerId);
	});

	#
	# 消费者订单总数查询 - 所有状态各自的总数
	#
	# GET	https://<endpoint>/Order/Consumer/[ConsumerId]/Count/Detail/
	#
	$app->get('/Consumer/:ConsumerId/Count/Detail/', function($ConsumerId) use ($app)
	{
		$order = new Order($app);
		echo $order->getConsumerOrderDetailCount($ConsumerId);
	});



	#
	# 修改订单详情
	#
	# PUT https://<endpoint>/Order/[OrderId]
	#
	# Request Body 
	#
	# {
	#   "Count":"订购量",
    #   "Unit":"单位(个，只，斤)",
    #   "Description":"说明和要求" 
    # }
	#
	$app->put('/:OrderId', function ($OrderId) use ($app)
	{
		$order = new Order($app);
		echo $order->put_OrderId($OrderId);
	});

	#
	# 订单状态变更
	#
	# PUT https://<endpoint>/Order/Status/[OrderId]
	#
	# Request Body
	#
	# {
    #   "OldStatus":"订单当前状态",
    #   "NewStatus":"订单新状态",
    #   "ProducerId":"农场主ID" 
    #   "ConsumerId":"消费者ID" 
    # }
	#
	#Status:
	# 0: 订单待确认
	# 1: 确认
	# 2: 取消
	# 
	# 订单确认功能 仅农场主可调用，
	# 已确认的订单不能取消。
	# 客户端进行界面功能调整和检查，服务湍也会进行相应合法性检查。
	#
	$app->put('/Status/:OrderId', function ($OrderId) use ($app)
	{
		$order = new Order($app);
		echo $order->put_OrderStatus($OrderId);
	});


	///后面再把收货人单独写成一个文件
	#
	# 增加收货人
	#
	# POST https://<endpoint>/Order/Consignee/[ConsumerId]
	#
	# Request Body 
	#
	# {
	#   "Name":"收货人姓名",
    #   "Telephone":"收货人电话",
	#   "Address":"收货人地址",
	#   "IsDefault":"true/false"
	# }
	$app->post('/Consignee/:ConsumerId/', function($ConsumerId) use ($app)
	{
		$order = new Order($app);
		echo $order->post_Consignee($ConsumerId);
	});

	#
	# 修改收货人信息
	#
	# PUT https://<endpoint>/Order/Consignee/[ConsigneeId]
	#
	# Request Body 
	#
	# {
	#   "Name":"收货人姓名",
    #   "Telephone":"收货人电话",
	#   "Address":"收货人地址",
	#   "IsDefault":"true/false"
	# }
	$app->put('/Consignee/:ConsigneeId/', function($ConsigneeId) use ($app)
	{
		$order = new Order($app);
		echo $order->put_Consignee($ConsigneeId);
	});

	#
	# 查询收货人详细信息
	#
	# GET https://<endpoint>/Order/Consignee/[ConsigneeId]
	#
	$app->get('/Consignee/:ConsigneeId/', function($ConsigneeId) use ($app)
	{
		$order = new Order($app);
		echo $order->get_Consignee($ConsigneeId);
	});

	#
	# 查询消费者的收货人列表
	#
	# GET https://<endpoint>/Order/Consignee/Consumer/[ConsumerId]
	#
	$app->get('/Consignee/Consumer/:ConsumerId/', function($ConsumerId) use ($app)
	{
		$order = new Order($app);
		echo $order->get_ConsumerConsignee($ConsumerId);
	});


	#
	# 删除收货人
	#
	# DELETE https://<endpoint>/Order/Consignee/[ConsigneeId]
	#
	$app->delete('/Consignee/:ConsigneeId', function ($ConsigneeId) use ($app)
	{
		$order = new Order($app);
		echo $order->delete_Consignee($ConsigneeId);		
	});


	#
	# 查询热门快递
	# 
	# GET https://<endpoint>/Order/HotExpress/?limit=10
	#
	$app->get('/HotExpress/', function () use ($app)
	{
		$order = new Order($app);
		echo $order->getHotExpress();
	});

});