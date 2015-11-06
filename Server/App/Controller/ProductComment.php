<?php

$app->group('/ProductComment', function () use ($app) 
{
	#
	# ������Ʒ����
	#
	# POST	https://<endpoint>/ProductComment/
	#
	# Request Body 
	# {
	#  "ProductId":"��ƷID",
	#  "Comment":"��������",
    #  "ConsumerId":"�����û�" 
	# }
	#
	$app->post('/', function () use ($app) 
	{
		$productComment = new ProductComment($app);
		echo $productComment->post();
	});


	#
	# ��ѯ��Ʒ���ۡ�����
	#
	# GET	https://<endpoint>/ProductComment/Count/[ProductId]
	#
	$app->get('/Count/:ProductId', function($ProductId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getCount($ProductId);
	});


	#
	# ��ѯ��Ʒ�����б�
	#
	# GET	https://<endpoint>/ProductComment/List/[ProductId]/?offset=0&limit=15
	#
	$app->get('/List/:ProductId/', function($ProductId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getList($ProductId);
	});

	#
	# ��ѯĳ���û���ȫ����Ʒ����
	#
	# GET	https://<endpoint>/ProductComment/UserCommentList/[ConsumerId]/?offset=0&limit=15
	#
	$app->get('/UserCommentList/:ConsumerId/', function($ConsumerId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getUserCommentList($ConsumerId);
	});

	
	#
	# ��ѯ��Ʒ���ۡ���ϸ��Ϣ
	#
	# GET	https://<endpoint>/ProductComment/[CommentId]
	#
	$app->get('/:CommentId', function($CommentId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getCommentId($CommentId);
	});


	#
	# ɾ����Ʒ����
	#
	# DELETE	https://<endpoint>/ProductComment/[CommendId]
	#
	$app->delete('/:CommentId', function($CommentId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->delete($CommentId);
	});


	#
	# ��ѯ�û���Ʒ���ۡ�����
	#
	# GET	https://<endpoint>/ProductComment/[ConsumerId]/Count/
	#
	$app->get('/:ConsumerId/Count/', function($ConsumerId) use ($app)
	{
		$productComment = new ProductComment($app);
		echo $productComment->getConsumerCommentCount($ConsumerId);
	});
});
