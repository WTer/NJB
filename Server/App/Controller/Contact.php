<?php

$app->group('/Contact', function () use ($app) 
{
	#
	# ũ����������������ϵ��
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
	# ��ѯũ��������������ϵ���б�
	#
	# GET https://<endpoint>/Contact/Producer/[ProducerId]/Consumer
	#
	$app->get('/Producer/:ProducerId/Consumer', function ($ProducerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->get_ProducerConsumer($ProducerId);
	});


	#
	# ũ��������ϵ��������ѯ
	#
	# GET https://<endpoint>/Contact/Producer/[ProducerId]/Count/
	#
	$app->get('/Producer/:ProducerId/Count/', function($ProducerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->getProducerContactCount($ProducerId);
	});

	#
	# �����ߵ���ϵ��������ѯ
	#
	# GET https://<endpoint>/Contact/Consumer/[ConsumerId]/Count/
	#
	$app->get('/Consumer/:ConsumerId/Count/', function($ConsumerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->getConsumerContactCount($ConsumerId);
	});


	#
	# ũ������������ũ������ϵ��
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
	# ��ѯũ������ũ������ϵ���б�
	#
	# GET https://<endpoint>/Contact/Producer/[ProducerId]/Producer
	#
	$app->get('/Producer/:ProducerId/Producer', function ($ProducerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->get_ProducerId($ProducerId);
	});


	#
	# ����������ũ������ϵ��
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
	# ��ѯ�����ߵ�ũ������ϵ���б�
	#
	# GET https://<endpoint>/Contact/Consumer/[ConsumerId]/Producer
	#
	$app->get('/Consumer/:ConsumerId/Producer', function ($ConsumerId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->get_ConsumerId($ConsumerId);
	});


	#
	#ɾ��ũ��������������ϵ��
	#
	# DELETE https://<endpoint>/Contact/Producer/Consumer/[ContactId]
	#
	$app->delete('/Producer/Consumer/:ContactId', function ($ContactId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->delete_producercontactconsumer($ContactId);
	});

	
	#
	#ɾ��ũ����������ũ������ϵ��
	#
	# DELETE https://<endpoint>/Contact/Producer/Producer/[ContactId]
	#
	$app->delete('/Producer/Producer/:ContactId', function ($ContactId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->delete_producercontactproducer($ContactId);
	});


	#
	#ɾ�������ߵ�ũ������ϵ��
	#
	# DELETE https://<endpoint>/Contact/Consumer/Producer/[ContactId]
	#
	$app->delete('/Consumer/Producer/:ContactId', function ($ContactId) use ($app)
	{
		$contact = new Contact($app);
		echo $contact->delete_consumercontactproducer($ContactId);		
	});
});
