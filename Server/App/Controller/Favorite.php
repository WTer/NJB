<?php

$app->group('/Favorite', function () use ($app) 
{
	#
	# 农场主新增商品收藏
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
	# 查询农场主商品收藏列表
	#
	# GET https://<endpoint>/Favorite/Producer/[ProducerId]/Product/?offset=0&limit=15
	# 
	$app->get('/Producer/:ProducerId/Product/', function ($ProducerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->get_ProducerId($ProducerId);
	});


	#
	# 农场主商品收藏总数查询
	#
	# GET https://<endpoint>/Favorite/Producer/[ProducerId]/Count/
	#
	$app->get('/Producer/:ProducerId/Count/', function($ProducerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->getProducerFavoriteCount($ProducerId);
	});


	#
	# 消费者新增商品收藏
	#
	# POST https://<endpoint>/Favorite/Consumer/[ConsumerId]/Product/[ProductId]
	#
	$app->post('/Consumer/:ConsumerId/Product/:ProductId', function ($ConsumerId, $ProductId) use ($app) 
	{
		$favorite = new Favorite($app);
		echo $favorite->post_ConsumerId_ProductId($ConsumerId, $ProductId);
	});


	#
	# 查询消费者商品收藏列表
	#
	# GET https://<endpoint>/Favorite/Consumer/[ConsumerId]/Product/?offset=0&limit=15
	#
	$app->get('/Consumer/:ConsumerId/Product/', function ($ConsumerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->get_ConsumerId($ConsumerId);
	});

	#
	# 消费者商品收藏总数查询
	#
	# GET https://<endpoint>/Favorite/Consumer/[ConsumerId]/Count/
	#
	$app->get('/Consumer/:ConsumerId/Count/', function($ConsumerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->getConsumerFavoriteCount($ConsumerId);
	});


	#
	# 消费者新增对农场主的收藏
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
	# 查询消费者对农场主的收藏列表
	#
	# GET https://<endpoint>/Favorite/Consumer/[ConsumerId]/Producer/
	#
	$app->get('/Consumer/:ConsumerId/Producer', function ($ConsumerId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->get_ConsumerId_Producer($ConsumerId);
	});
	

	#
	#删除农场主的商品收藏
	#
	# DELETE https://<endpoint>/Favorite/Producer/Product/[FavoriteId]
	#
	$app->delete('/Producer/Product/:FavoriteId', function ($FavoriteId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->delete_Producer_Product($FavoriteId);
	});


	#
	#删除消费者的商品收藏
	#
	# DELETE https://<endpoint>/Favorite/Consumer/Product/[FavoriteId]
	#
	$app->delete('/Consumer/Product/:FavoriteId', function ($FavoriteId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->delete_Consumer_Product($FavoriteId);
	});

	#
	#删除消费者的农场主收藏
	#
	# DELETE https://<endpoint>/Favorite/Consumer/Producer/[FavoriteId]
	#
	$app->delete('/Consumer/Producer/:FavoriteId', function ($FavoriteId) use ($app)
	{
		$favorite = new Favorite($app);
		echo $favorite->delete_Consumer_Producer($FavoriteId);		
	});

});
