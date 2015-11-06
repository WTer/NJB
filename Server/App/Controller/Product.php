<?php

$app->group('/Product', function () use ($app) 
{
	#
	# ��Ʒ������������Ϣ
	#
	# POST https://<endpoint>/Product/BasicInfo/
	#
	# Request Body 
	# {
	#  "Name":"��Ʒ����",
	#  "Description":"��Ʒ����",
	#  "Type":"��Ʒ���",
	#  "Price":"��Ʒ�۸�",
	#  "OriginalPrice":"��Ʒԭ��",
	#  "Unit":"��Ʒ��λ",
	#  "Freight":"��Ʒ�˷�",
	#  "ProducerId":"������ũ����" 
	# }
	#
	$app->post('/BasicInfo/', function () use ($app) 
	{
		$product = new Product($app);
		echo $product->post_BasicInfo();
	});

	#
	# ��Ʒ�޸ġ�������Ϣ
	#
	# PUT https://<endpoint>/Product/BasicInfo/[ProductId]
	#
	# Request Body 
	# {
	#  "Name":"��Ʒ����",
	#  "Description":"��Ʒ����",
	#  "Type":"��Ʒ���"
	# }
	#
	$app->put('/BasicInfo/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->put_BasicInfo($ProductId);
	});


	#
	# ��Ʒ��ѯ��������Ϣ
	# 
	# GET https://<endpoint>/Product/BasicInfo/[ProductId]
	#
	$app->get('/BasicInfo/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->get_BasicInfo($ProductId);
	});


	#
	# ��Ʒ�б��ѯ��������Ϣ
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
	# ��Ʒ����/�޸ġ�ͼƬ
	#
	# PUT https://<endpoint>/Product/Images/[ProductId]
	# 
	# Request Body 
	# {
	#   "Count":"ͼƬ����",
	#   "List":
	#    [
	#      {"ImageId": "ͼƬID, ������ͼ������Ϊ��",
	#       "Description": "ͼƬ����",
	#       "BigPicture": "��ͼBASE64���봮",
	#       "SmallPicture": "СͼBASE64���봮"},
	#      ����
	#    ]
	# }
	#
	$app->put('/Images/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->put_Images($ProductId);
	});


	#
	# ��Ʒ��ѯ������ͼƬ
	#
	# GET https://<endpoint>/Product/Image/[ProductId]
	#
	# Response Body
	# Content-Type: application/json
	# {  
	#    "id": "ͼƬID",
	#    "Description": "ͼƬ����",
	#    "bigportraiturl": "��ͼBASE64���봮",
	#    "smallportraiturl": "СͼBASE64���봮"},
	# }
	#
	$app->get('/Image/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->get_Image($ProductId);
	});


	#
	# ��Ʒ��ѯ������ͼƬ
	#
	# GET https://<endpoint>/Product/Images/[ProductId]
	#
	# Response Body
	# {
	#  "Count":"ͼƬ����",
	#  "List":
	#   [
	#    { "Id": "ͼƬID",
	#      "Description": "ͼƬ����",
	#      "bigportraiturl": "��ͼBASE64���봮",
	#      "smallportraiturl": "СͼBASE64���봮"},
	#      ����
	#   ]
	# }
	#
	$app->get('/Images/:ProductId', function ($ProductId) use ($app)
	{
		$product = new Product($app);
		echo $product->get_Images($ProductId);
	});


	#
	# ��Ʒ��ѯ������������
	# 
	# GET https://<endpoint>/Product/HotSearchWord/?limit=10
	#
	$app->get('/HotSearchWord/', function () use ($app)
	{
		$product = new Product($app);
		echo $product->getHotSearchWord();
	});
});
