<?php

$app->group('/Common', function () use ($app) 
{
	#
	# ����ʡ�м���Ͻ��/���б�
	#
	# GET https://<endpoint>/Common/ProvinceCityList
	#
	$app->get('/ProvinceCityList', function () use ($app)
	{
		$common = new Common($app);
		echo $common->get_ProvinceCityList();
	});
});
