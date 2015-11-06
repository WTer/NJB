<?php

$app->group('/Producer', function () use ($app) 
{
	#
	# ũ����ע�ᡪ������Ϣ
	#
	# POST https://<endpoint>/Producer/BasicInfo/
	#
	# Request Body 
	# {
	#  "LoginName":"��¼����֧���ֻ����ʼ�",
	#  "Password":"��¼���룬������DES256���ܣ�Ȼ�����BASE64����",
	#  "DisplayName":"��ʾ����",
	#  "Province":"ʡ������",
	#  "City":"��������",
	#  "Address":"��ַ",
	#  "Telephone":"�绰",
	#  "Website":"��վ"
	# }
	#
	# Response Body
	# �����ɹ���
	# HTTP/1.1 201 Created
	# Content-Type: application/json
	# {
	#   "id":"���ش����ɹ���ID",
	#  "SessionKey":"�ỰKEY, ���ں�����������Ľ���",
	#  {
	#     "LoginName": "��¼��",
	#     "DisplayName ": "��ʾ��",
	#     "Province": "ʡ��",
	#     "City": "����"
	#     "Address": "��ַ"
	#     "Telephone":"�绰",
	#     "Website":"��վ"
	#  }
	# }
	#
	# ����ʧ�ܣ�
	# HTTP/1.1 ʧ�ܴ��루409/500��
	# Content-Type: application/json
	# {
	#  "error":"�������",
	#  "reason":"����ԭ��"
	# }
	#
	$app->post('/BasicInfo/', function () use ($app) 
	{
		$producer = new Producer($app);
		echo $producer->post_BasicInfo();
	});


	#
	# ũ�����޸ġ�������Ϣ
	#
	# PUT https://<endpoint>/Producer/BasicInfo/[ProducerId]
	$app->put('/BasicInfo/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->put_BasicInfo($ProducerId);
	});

	#
	# 修改密码
	#
	# PUT https://<endpoint>/Producer/Password/[ProducerId]
	#
	$app->put('/Password/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->putPassword($ProducerId);
	});


	#
	# ũ������ѯ��������Ϣ
	# 
	# GET https://<endpoint>/Producer/BasicInfo/[ProducerId]
	#
	$app->get('/BasicInfo/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->get_BasicInfo($ProducerId);
	});


	#
	# ũ����ע��/�޸ġ�ͷ��
	#
	# PUT https://<endpoint>/Producer/Portrait/[ProducerId]
	#
	# {
	#   "BigPortrait":"�û���ͷ��BASE64���봮",
	#   "SmallPortrait":"�û�Сͷ��BASE64���봮"
	# }
	#
	$app->put('/Portrait/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->put_Portrait($ProducerId);
	});

	#
	# ũ������ѯ��ͷ��
	#
	# GET https://<endpoint>/Producer/Portrait/[ProducerId]
	#
	$app->get('/Portrait/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->get_Portrait($ProducerId);
	});

	#
	# ũ����ע��/�޸ġ���չ��Ϣ
	#
	# PUT https://<endpoint>/Producer/RichInfo/[ProducerId]
	#
	$app->put('/RichInfo/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->put_RichInfo($ProducerId);
	});

	#
	# ũ������ѯ����չ��Ϣ
	#
	# GET https://<endpoint>/Producer/RichInfo/[ProducerId]
	#
	$app->get('/RichInfo/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->get_RichInfo($ProducerId);
	});


	#
	# ũ����ע��/�޸ġ���֤֤��
	#
	# PUT https://<endpoint>/Producer/Certificate/[ProducerId]
	#
	# Request Body 
	# {
	#   "Count":"֤������",
	#   "List":
	#    [
	#     {
	#	    "CertificateId": "֤��ID, ������֤�飬����Ϊ��",
	#       "CertficateTime": "��֤ʱ��",
	#       "BigPicture": "֤���ͼBASE64���봮",
	#       "SmallPicture": "֤��СͼBASE64���봮"
	#     },
	#     ����
	#    ]
	# }
	#
	$app->put('/Certificate/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->put_Certificate($ProducerId);
	});


	#
	# ũ������ѯ����֤֤��
	#
	# GET https://<endpoint>/Producer/Certificate/[ProducerId]
	#
	$app->get('/Certificate/:ProducerId', function ($ProducerId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->get_Certificate($ProducerId);
	});

	#
	# ɾ��ũ������֤֤��
	#
	# DELETE https://<endpoint>/Producer/Certificate/[CertificateId]
	#
	$app->delete('/Certificate/:CertificateId', function ($CertificateId) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->deleteCertificate($CertificateId);		
	});



	#
	# ũ������¼
	#
	# GET https://<endpoint>/Producer/LoginName/[LoginName]/SessionKey/[SessionKey]
	#
	$app->get('/LoginName/:LoginName/SessionKey/:SessionKey', function ($LoginName, $SessionKey) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->login($LoginName, $SessionKey);
		//var_dump($app);
	});

	#
	# ũ������ѯ����֤�ֻ��Ƿ����
	#
	# GET https://<endpoint>/Producer/LoginNameCheck/[LoginName]
	#
	$app->get('/LoginNameCheck/:LoginName', function ($LoginName) use ($app)
	{
		$producer = new Producer($app);
		echo $producer->checkLoginName($LoginName);
	});


	#
	# ũ����ע�ᡪ���Ͷ�����֤��
	#
	# POST https://<endpoint>/Producer/SmsCode/
	#
	# Request Body 
	# {
	#  "Telephone":"�绰"
	# }
	#
	$app->post('/SmsCode/', function () use ($app) 
	{
		$producer = new Producer($app);
		echo $producer->postSmsCode();
	});

	#
	# ũ����ע�ᡪ��֤������
	#
	# GET https://<endpoint>/Producer/SmsCode/[SmsCodeId]/[UserSmsCode]/[Telephone]
	#
	$app->get('/SmsCode/:SmsCodeId/:UserSmsCode/:Telephone', function ($SmsCodeId, $UserSmsCode, $Telephone) use ($app) 
	{
		$producer = new Producer($app);
		echo $producer->verifySmsCode($SmsCodeId, $UserSmsCode, $Telephone);
	});
});

