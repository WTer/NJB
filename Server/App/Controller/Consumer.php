<?php

$app->group('/Consumer', function () use ($app) 
{
	#
	# ������ע�ᡪ������Ϣ
	#
	# POST https://<endpoint>/Consumer/BasicInfo/
	#
	# Request Body 
	# {
	#  "LoginName":"��¼����֧���ֻ����ʼ�",
	#  "Password":"��¼���룬������DES256���ܣ�Ȼ�����BASE64����",
	#  "DisplayName":"��ʾ����"
	# }
	#
	$app->post('/BasicInfo/', function () use ($app) 
	{
		$consumer = new Consumer($app);
		echo $consumer->post();
	});

	#
	# �������޸ġ�������Ϣ
	#
	# PUT https://<endpoint>/Consumer/BasicInfo/[ConsumerId]
	#
	$app->put('/BasicInfo/:ConsumerId', function ($ConsumerId) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->put_ConsumerId($ConsumerId);
	});

	#
	# 修改密码
	#
	# PUT https://<endpoint>/Consumer/Password/[ConsumerId]
	$app->put('/Password/:ProducerId', function ($ConsumerId) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->putPassword($ConsumerId);
	});


	#
	# �����߲�ѯ��������Ϣ
	# 
	# GET https://<endpoint>/Consumer/BasicInfo/[ConsumerId]
	#
	$app->get('/BasicInfo/:ConsumerId', function ($ConsumerId) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->get_ConsumerId($ConsumerId);		
	});


	#
	# ������ע��/�޸ġ�ͷ��
	#
	# PUT https://<endpoint>/Consumer/Portrait/[ConsumerId]
	# 
	# Request Body 
	# {
	#   "BigPortrait":"�û���ͷ��BASE64���봮",
	#   "SmallPortrait":"�û�Сͷ��BASE64���봮"
	# }
	#
	$app->put('/Portrait/:ConsumerId', function ($ConsumerId) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->put_Portrait_ConsumerId($ConsumerId);
	});


	#
	# �����߲�ѯ��ͷ��
	#
	# GET https://<endpoint>/Consumer/Portrait/[ConsumerId]
	#
	$app->get('/Portrait/:ConsumerId', function ($ConsumerId) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->get_Portrait_ConsumerId($ConsumerId);
	});

	#
	# ������ע��/�޸ġ���չ��Ϣ
	#
	# PUT https://<endpoint>/Consumer/RichInfo/[ConsumerId]
	#
	$app->put('/RichInfo/:ConsumerId', function ($ConsumerId) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->put_RichInfo_ConsumerId($ConsumerId);
	});

	#
	# �����߲�ѯ����չ��Ϣ
	#
	# GET https://<endpoint>/Consumer/RichInfo/[ConsumerId]
	#
	$app->get('/RichInfo/:ConsumerId', function ($ConsumerId) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->get_RichInfo_ConsumerId($ConsumerId);
	});


	#
	# �����ߵ�¼
	#
	# GET https://<endpoint>/Consumer/LoginName/[LoginName]/SessionKey/[SessionKey]
	#
	$app->get('/LoginName/:LoginName/SessionKey/:SessionKey', function ($LoginName, $SessionKey) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->login($LoginName, $SessionKey);
	});


	#
	# �����߲�ѯ����֤�ֻ��Ƿ����
	#
	# GET https://<endpoint>/Consumer/LoginNameCheck/[LoginName]
	#
	$app->get('/LoginNameCheck/:LoginName', function ($LoginName) use ($app)
	{
		$consumer = new Consumer($app);
		echo $consumer->checkLoginName($LoginName);
	});


	#
	# ������ע�ᡪ���Ͷ�����֤��
	#
	# POST https://<endpoint>/Consumer/SmsCode/
	#
	# Request Body 
	# {
	#  "Telephone":"�绰"
	# }
	#
	$app->post('/SmsCode/', function () use ($app) 
	{
		$consumer = new Consumer($app);
		echo $consumer->postSmsCode();
	});

	#
	# ������ע�ᡪ��֤������
	#
	# GET https://<endpoint>/Consumer/SmsCode/[SmsCodeId]/[UserSmsCode]/[Telephone]
	#
	$app->get('/SmsCode/:SmsCodeId/:UserSmsCode/:Telephone', function ($SmsCodeId, $UserSmsCode, $Telephone) use ($app) 
	{
		$consumer = new Consumer($app);
		echo $consumer->verifySmsCode($SmsCodeId, $UserSmsCode, $Telephone);
	});
});
