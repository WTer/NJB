<?php

class Common 
{
	private $_app;
	
	public function __construct($app)
	{
		$this->_app = $app;
	}

	public function __destruct()
	{
		;
	}

	public function get_ProvinceCityList()
	{
		try
		{
			$List = array();

			//{"name":"\u5317\u4eac","citys":[{"10001":"\u5317\u4eac"}]},
			$City = array();
			$District = array();
			$District[] = array('100001' => '海淀');
			$District[] = array('100002' => '朝阳');
			$City[] = array('100000' => '北京', 'District' => $District);
			$Province = array('Province' => '北京', 'City' => $City);			
			$List[] = $Province;


			$City = array();
			$District = array();
			$District[] = array('200001' => '越秀区');
			$District[] = array('200002' => '天河区');
			$City[] = array('200000' => '广州', 'District' => $District);

			$District = array();
			$District[] = array('200011' => '南山区');
			$District[] = array('200022' => '福田区');
			//$City = array();
			$City[] = array('200010' => '深圳', 'District' => $District);
			$Province = array('Province' => '广东', 'City' => $City);

			$List[] = $Province;

			
			
			/*
			$List = array();
			$List[] = array('ProvinceName' => '北京', 'CityName' => array(array('100001' => 'Haidian', '100002' => 'Chaoyang')));
			$List[] = array('ProvinceName' => 'HaiNan', 'CityName' => array(array('200001' => 'Haikou', '200002' => 'Sanya')));
			$List[] = array('ProvinceName' => 'Guangdong', 'CityName' => array(array('300001' => 'Guangzhou', '300002' => 'Shenzhen')));
			*/

			//$List[] = array('HaiNan' => array('Haikou', 'Sanya'));
			//$List[] = array('Guangdong' => array('Guangzhou', 'Shenzhen'));

			$requestBody = array(
				"Count" => 2,
				"List" => $List
				);
			return json_encode($requestBody);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
}