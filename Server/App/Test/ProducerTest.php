<?php

use Slim\Slim;

//ProducerTest::Test1();
//$producerTest = new ProducerTest();
//$producerTest->TestPOSTProducerBasicInfo();

class ProducerTest extends Slim
{
	//cURL handler
	private $curlHandler;

	public function __construct(array $userSettings = array())
	{
		parent::__construct($userSettings);

		$this->get('Product/Image/:id', function($id){
            echo "hello $name";
        })->name('id');

		echo '===__construct 0<br>';
		flush();
		$this->curlHandler = curl_init();
		echo '===__construct 1<br>';
		flush();

	}

	function Init()
	{
		$this->curlHandler = curl_init();
	}

	public function __destruct()
	{
		echo '===__destruct 0<br>';
		flush();

		// close and release
		if (isset($this->curlHandler))
		{
			//curl_close($this->curlHandler);
			echo '===__destruct 1<br>';
			flush();
		}
	}

	/**
     * @return \Slim\Http\Response
     */
    public function invoke()
	{
        $this->middleware[0]->call();
        $this->response()->finalize();
        return $this->response();
    }

	public function test007($app)
	{
		$producer = new Producer($app);
		echo $producer->post_BasicInfo();

	}


	//
	//POST https://<endpoint>/Producer/BasicInfo/
	//
	public function TestPOSTProducerBasicInfo()
	{
		echo '===1<br>';
		flush();
		//Init();

		// Setup some options
		curl_setopt($this->curlHandler, CURLOPT_CUSTOMREQUEST, "POST"); //curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($this->curlHandler, CURLOPT_URL, "http://localhost:8080/Producer/BasicInfo/");
		curl_setopt($this->curlHandler, CURLOPT_HEADER, false);
		curl_setopt($this->curlHandler, CURLOPT_RETURNTRANSFER,true);


		// Create body
		$requestBody = array(
			"LoginName" => "LoginNameTest",
			"Password" => "PasswordTest",
			"DisplayName" => "DisplayNameTest",
			"Province" => "ProvinceTest",
			"City" => "CityTest",
			"Address" => "AddressTest",
			"Telephone" => "AddressTest",
			"Website" => "WebsiteTest"
			);
		$requestBodyJson = json_encode($requestBody);
		curl_setopt($this->curlHandler, CURLOPT_POSTFIELDS, $requestBodyJson);
		curl_setopt($this->curlHandler, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Content-Length: ' . strlen($requestBodyJson)));
		echo '===3<br>';
		flush();

		var_dump($this->curlHandler);

		$response = curl_exec($this->curlHandler);

		echo '<br>===4<br>';
		flush();

		curl_close($this->curlHandler);
	}

	function Test1()
	{
		echo "11\r\n";
		// 创建一个新cURL资源
		$ch = curl_init();
		echo "22\r\n";

		// 设置URL和相应的选项
		curl_setopt($ch, CURLOPT_URL, "http://localhost:8080/");
		//curl_setopt($ch, CURLOPT_URL, "http://localhost:8080/Product/BasicInfo/1");
		curl_setopt($ch, CURLOPT_HEADER, false);
		echo "33\r\n";

		// 抓取URL并把它传递给浏览器
		curl_exec($ch);
		echo "44\r\n";

		//关闭cURL资源，并且释放系统资源
		curl_close($ch);
	}

	/*static function startsWith($haystack, $needle)
	{
		// search backwards starting from haystack length characters from the end
		return $needle === "" || strrpos($haystack, $needle, -strlen($haystack)) !== FALSE;
	}

	static function endsWith($haystack, $needle)
	{
		// search forward starting from end minus needle length characters
		return $needle === "" || (($temp = strlen($haystack) - strlen($needle)) >= 0 && strpos($haystack, $needle, $temp) !== FALSE);
	}*/

}



