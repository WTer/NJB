<?php

$app->group('/Product', function () use ($app) 
{
	#
	# 商品发布—基本信息
	#
	# POST https://<endpoint>/Product/BasicInfo/
	#
	# Request Body 
	# {
	#  "Name":"商品名称",
	#  "Description":"商品描述",
	#  "Type":"商品类别",
	#  "Price":"商品价格",
	#  "OriginalPrice":"商品原价",
	#  "Unit":"商品单位",
	#  "Freight":"商品运费",
	#  "ProducerId":"发布的农场主" 
	# }
	#
	$app->post('/BasicInfo/', function () use ($app) 
	{
		$product = new Product($app);
		echo $product->post_BasicInfo();
	});

	#
	# 商品修改—基本信息
	#
	# PUT https://<endpoint>/Product/BasicInfo/[ProductId]
	#
	# Request Body 
	# {
	#  "Name":"商品名称",
	#  "Description":"商品描述",
	#  "Type":"商品类别"
	# }
	#
	$app->put('/BasicInfo/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->put_BasicInfo($ProductId);
	});


	#
	# 商品查询—基本信息
	# 
	# GET https://<endpoint>/Product/BasicInfo/[ProductId]
	#
	$app->get('/BasicInfo/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->get_BasicInfo($ProductId);
	});


	#
	# 商品列表查询—基本信息
	# 
	# GET https://<endpoint>/Product/BasicInfo/List/?UserId=&UserType=C/P&Province=&City=&Address=&ProductType=&ProductName=&ProductDesc=&offset=0&limit=15&desc=true
	#????????
	#
	$app->get('/BasicInfo/List/', function () use ($app)
	{
		$product = new Product($app);
		echo $product->get_BasicInfoList();
	});


	#
	# 商品发布/修改—图片
	#
	# PUT https://<endpoint>/Product/Images/[ProductId]
	# 
	# Request Body 
	# {
	#   "Count":"图片数量",
	#   "List":
	#    [
	#      {"ImageId": "图片ID, 对于新图，此项为空",
	#       "Description": "图片描述",
	#       "BigPicture": "大图BASE64编码串",
	#       "SmallPicture": "小图BASE64编码串"},
	#      ……
	#    ]
	# }
	#
	$app->put('/Images/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->put_Images($ProductId);
	});


	#
	# 商品查询—单张图片
	#
	# GET https://<endpoint>/Product/Image/[ProductId]
	#
	# Response Body
	# Content-Type: application/json
	# {  
	#    "id": "图片ID",
	#    "Description": "图片描述",
	#    "bigportraiturl": "大图BASE64编码串",
	#    "smallportraiturl": "小图BASE64编码串"},
	# }
	#
	$app->get('/Image/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->get_Image($ProductId);
	});


	#
	# 商品查询—所有图片
	#
	# GET https://<endpoint>/Product/Images/[ProductId]
	#
	# Response Body
	# {
	#  "Count":"图片数量",
	#  "List":
	#   [
	#    { "Id": "图片ID",
	#      "Description": "图片描述",
	#      "bigportraiturl": "大图BASE64编码串",
	#      "smallportraiturl": "小图BASE64编码串"},
	#      ……
	#   ]
	# }
	#
	$app->get('/Images/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->get_Images($ProductId);
	});


	#
	# 商品查询—热门搜索词
	# 
	# GET https://<endpoint>/Product/HotSearchWord/?limit=10
	#
	$app->get('/HotSearchWord/', function () use ($app)
	{
		$product = new Product($app);
		echo $product->getHotSearchWord();
	});
});
