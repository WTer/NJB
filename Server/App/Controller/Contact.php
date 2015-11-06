<?php

$app->group('/Contact', function () use ($app) 
{
	#
	# 农场主新增消费者联系人
	#
	# POST	https://<endpoint>/Contact/Producer/[ProducerId]/Consumer/[ConsumerId]
	#
	#
	$app->post('/Producer/:ProducerId/Consumer/:ConsumerId', function ($ProducerId, $ConsumerId) use ($app) 
	{
		$contact = new Contact($app);
		echo $contact->post_ProducerId_ConsumerId($ProducerId, $ConsumerId);
	});

	#
	# 查询农场主的消费者联系人列表
	#
	# GET https://<endpoint>/Contact/Producer/[ProducerId]/Consumer
	#
	$app->get('/Producer/:ProducerId/Consumer', function ($ProducerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->get_ProducerConsumer($ProducerId);
	});


	#
	# 农场主的联系人总数查询
	#
	# GET https://<endpoint>/Contact/Producer/[ProducerId]/Count/
	#
	$app->get('/Producer/:ProducerId/Count/', function($ProducerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->getProducerContactCount($ProducerId);
	});

	#
	# 消费者的联系人总数查询
	#
	# GET https://<endpoint>/Contact/Consumer/[ConsumerId]/Count/
	#
	$app->get('/Consumer/:ConsumerId/Count/', function($ConsumerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->getConsumerContactCount($ConsumerId);
	});


	#
	# 农场主新增其他农场主联系人
	#
	# POST	https://<endpoint>/Contact/Producer/[ProducerId]/Producer/[ProducerId]
	#
	#
	$app->post('/Producer/:ProducerId/Producer/:OtherProducerId', function ($ProducerId, $OtherProducerId) use ($app) 
	{
		$contact = new Contact($app);
		echo $contact->post_ProducerId_OtherProducerId($ProducerId, $OtherProducerId);
	});


	#
	# 查询农场主的农场主联系人列表
	#
	# GET https://<endpoint>/Contact/Producer/[ProducerId]/Producer
	#
	$app->get('/Producer/:ProducerId/Producer', function ($ProducerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->get_ProducerId($ProducerId);
	});


	#
	# 消费者新增农场主联系人
	#
	# POST	https://<endpoint>/Contact/Consumer/[ConsumerId]/Producer/[ProducerId]
	#
	#
	$app->post('/Consumer/:ConsumerId/Producer/:ProducerId', function ($ConsumerId, $ProducerId) use ($app) 
	{
		$contact = new Contact($app);
		echo $contact->post_ConsumerId_ProducerId($ConsumerId, $ProducerId);
	});


	#
	# 查询消费者的农场主联系人列表
	#
	# GET https://<endpoint>/Contact/Consumer/[ConsumerId]/Producer
	#
	$app->get('/Consumer/:ConsumerId/Producer', function ($ConsumerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->get_ConsumerId($ConsumerId);
	});


	#
	#删除农场主的消费者联系人
	#
	# DELETE https://<endpoint>/Contact/Producer/Consumer/[ContactId]
	#
	$app->delete('/Producer/Consumer/:ContactId', function ($ContactId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->delete_producercontactconsumer($ContactId);
	});

	
	#
	#删除农场主的其他农场主联系人
	#
	# DELETE https://<endpoint>/Contact/Producer/Producer/[ContactId]
	#
	$app->delete('/Producer/Producer/:ContactId', function ($ContactId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->delete_producercontactproducer($ContactId);
	});


	#
	#删除消费者的农场主联系人
	#
	# DELETE https://<endpoint>/Contact/Consumer/Producer/[ContactId]
	#
	$app->delete('/Consumer/Producer/:ContactId', function ($ContactId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->delete_consumercontactproducer($ContactId);		
	});
});
