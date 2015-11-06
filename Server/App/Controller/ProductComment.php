<?php

$app->group('/ProductComment', function () use ($app) 
{
	#
	# 新增商品论评
	#
	# POST	https://<endpoint>/ProductComment/
	#
	# Request Body 
	# {
	#  "ProductId":"商品ID",
	#  "Comment":"评论内容",
    #  "ConsumerId":"评论用户" 
	# }
	#
	$app->post('/', function () use ($app) 
	{
		$productComment = new ProductComment($app);
		echo $productComment->post();
	});


	#
	# 查询商品评论—总数
	#
	# GET	https://<endpoint>/ProductComment/Count/[ProductId]
	#
	$app->get('/Count/:ProductId', function($ProductId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getCount($ProductId);
	});


	#
	# 查询商品评论列表
	#
	# GET	https://<endpoint>/ProductComment/List/[ProductId]/?offset=0&limit=15
	#
	$app->get('/List/:ProductId/', function($ProductId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getList($ProductId);
	});

	#
	# 查询某个用户的全部商品评论
	#
	# GET	https://<endpoint>/ProductComment/UserCommentList/[ConsumerId]/?offset=0&limit=15
	#
	$app->get('/UserCommentList/:ConsumerId/', function($ConsumerId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getUserCommentList($ConsumerId);
	});

	
	#
	# 查询商品评论—详细信息
	#
	# GET	https://<endpoint>/ProductComment/[CommentId]
	#
	$app->get('/:CommentId', function($CommentId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getCommentId($CommentId);
	});


	#
	# 删除商品评论
	#
	# DELETE	https://<endpoint>/ProductComment/[CommendId]
	#
	$app->delete('/:CommentId', function($CommentId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->delete($CommentId);
	});


	#
	# 查询用户商品评论—总数
	#
	# GET	https://<endpoint>/ProductComment/[ConsumerId]/Count/
	#
	$app->get('/:ConsumerId/Count/', function($ConsumerId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getConsumerCommentCount($ConsumerId);
	});
});
