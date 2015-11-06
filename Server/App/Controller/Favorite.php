<?php

$app->group('/Favorite', function () use ($app) 
{
	#
	# ũ����������Ʒ�ղ�
	#
	# POST	https://<endpoint>/Favorite/Producer/[ProducerId]/Product/[ProductId]
	#
	#
	$app->post('/Producer/:ProducerId/Product/:ProductId', function ($ProducerId, $ProductId) use ($app) 
	{
		$favorite = new Favorite($app);
		echo $favorite->post_ProducerId_ProductId($ProducerId, $ProductId);
	});

	#
	# ��ѯũ������Ʒ�ղ��б�
	#
	# GET https://<endpoint>/Favorite/Producer/[ProducerId]/Product/?offset=0&limit=15
	# 
	$app->get('/Producer/:ProducerId/Product/', function ($ProducerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->get_ProducerId($ProducerId);
	});


	#
	# ũ������Ʒ�ղ�������ѯ
	#
	# GET https://<endpoint>/Favorite/Producer/[ProducerId]/Count/
	#
	$app->get('/Producer/:ProducerId/Count/', function($ProducerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->getProducerFavoriteCount($ProducerId);
	});


	#
	# ������������Ʒ�ղ�
	#
	# POST https://<endpoint>/Favorite/Consumer/[ConsumerId]/Product/[ProductId]
	#
	$app->post('/Consumer/:ConsumerId/Product/:ProductId', function ($ConsumerId, $ProductId) use ($app) 
	{
		$favorite = new Favorite($app);
		echo $favorite->post_ConsumerId_ProductId($ConsumerId, $ProductId);
	});


	#
	# ��ѯ��������Ʒ�ղ��б�
	#
	# GET https://<endpoint>/Favorite/Consumer/[ConsumerId]/Product/?offset=0&limit=15
	#
	$app->get('/Consumer/:ConsumerId/Product/', function ($ConsumerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->get_ConsumerId($ConsumerId);
	});

	#
	# ��������Ʒ�ղ�������ѯ
	#
	# GET https://<endpoint>/Favorite/Consumer/[ConsumerId]/Count/
	#
	$app->get('/Consumer/:ConsumerId/Count/', function($ConsumerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->getConsumerFavoriteCount($ConsumerId);
	});


	#
	# ������������ũ�������ղ�
	#
	# POST https://<endpoint>/Favorite/Consumer/[ConsumerId]/Producer/[ProducerId]
	#
	#
	$app->post('/Consumer/:ConsumerId/Producer/:ProducerId', function ($ConsumerId, $ProducerId) use ($app) 
	{
		$favorite = new Favorite($app);
		echo $favorite->post_ConsumerId_ProducerId($ConsumerId, $ProducerId);
	});


	#
	# ��ѯ�����߶�ũ�������ղ��б�
	#
	# GET https://<endpoint>/Favorite/Consumer/[ConsumerId]/Producer/
	#
	$app->get('/Consumer/:ConsumerId/Producer', function ($ConsumerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->get_ConsumerId_Producer($ConsumerId);
	});
	

	#
	#ɾ��ũ��������Ʒ�ղ�
	#
	# DELETE https://<endpoint>/Favorite/Producer/Product/[FavoriteId]
	#
	$app->delete('/Producer/Product/:FavoriteId', function ($FavoriteId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->delete_Producer_Product($FavoriteId);
	});


	#
	#ɾ�������ߵ���Ʒ�ղ�
	#
	# DELETE https://<endpoint>/Favorite/Consumer/Product/[FavoriteId]
	#
	$app->delete('/Consumer/Product/:FavoriteId', function ($FavoriteId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->delete_Consumer_Product($FavoriteId);
	});

	#
	#ɾ�������ߵ�ũ�����ղ�
	#
	# DELETE https://<endpoint>/Favorite/Consumer/Producer/[FavoriteId]
	#
	$app->delete('/Consumer/Producer/:FavoriteId', function ($FavoriteId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->delete_Consumer_Producer($FavoriteId);		
	});

});
