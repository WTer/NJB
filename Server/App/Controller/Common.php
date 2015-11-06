<?php

$app->group('/Common', function () use ($app) 
{
	#
	# 返回省市及所辖市/区列表
	#
	# GET https://<endpoint>/Common/ProvinceCityList
	#
	$app->get('/ProvinceCityList', function () use ($app)
	{
		$common = new Common($app);
		echo $common->get_ProvinceCityList();
	});
});
