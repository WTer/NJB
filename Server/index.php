<?php
/**
 * Step 1: Require the Slim Framework
 *
 * If you are not using Composer, you need to require the
 * Slim Framework and register its PSR-0 autoloader.
 *
 * If you are using Composer, you can skip this step.
 */
require 'App/Packages/Slim/Slim.php';
\Slim\Slim::registerAutoloader();

/**
 * Step 2: Instantiate a Slim application
 *
 * This example instantiates a Slim application using
 * its default settings. However, you will usually configure
 * your Slim application now by passing an associative array
 * of setting names and values into the application constructor.
 */
$app = new \Slim\Slim();

/**
 * Step 3: Define the Slim application routes
 *
 * Here we define several Slim application routes that respond
 * to appropriate HTTP request methods. In this example, the second
 * argument for `Slim::get`, `Slim::post`, `Slim::put`, `Slim::patch`, and `Slim::delete`
 * is an anonymous function.
 */

require_once 'App/Exception/IException.php';
require_once 'App/Exception/NJBException.php';
require_once 'App/Exception/DBException.php';
require_once 'App/Exception/RequestBodyException.php';
require_once 'App/Exception/RecordNotFoundException.php';
require_once 'App/Exception/RecordDuplicatedException.php';
require_once 'App/Exception/OrderException.php';
require_once 'App/Exception/SmsException.php';

require_once 'App/Utils/SmsSDK.php';
require_once 'App/Utils/AES.php';
require_once 'App/Utils/ExceptionHandler.php';
require_once 'App/Utils/Protocol.php';
require_once 'App/Utils/RequestJSON.php';
require_once 'App/Utils/ResponseJSON.php';
require_once 'App/Utils/String.php';
require_once 'App/Utils/SMS.php';
require_once 'App/Utils/Time.php';
require_once 'App/Utils/UserToken.php';
require_once 'App/Utils/Images.php';
require_once 'App/Utils/RequestBodyHandler.php';
require_once 'App/Utils/ResponseJsonHandler.php';

	//用户名，密码的验证 done
	//密码的加解密处理 done
	//用户图片，产品图片的分目录存储 done


require_once 'App/Model/Consumer.php';
require_once 'App/Model/Contact.php';
require_once 'App/Model/Favorite.php';
require_once 'App/Model/Order.php';
require_once 'App/Model/Producer.php';
require_once 'App/Model/Product.php';
require_once 'App/Model/ProductComment.php';
require_once 'App/Model/Db.php';
require_once 'App/Model/NJBException.php';
require_once 'App/Model/RequestCheck.php';
require_once 'App/Model/Producer.php';
require_once 'App/Model/Common.php';
require_once 'App/Controller/Consumer.php';
require_once 'App/Controller/Contact.php';
require_once 'App/Controller/Favorite.php';
require_once 'App/Controller/Order.php';
require_once 'App/Controller/Producer.php';
require_once 'App/Controller/Product.php';
require_once 'App/Controller/ProductComment.php';
require_once 'App/Controller/Common.php';



//$ar = Images::GetImagePath("123456", "producer", "bigpothrag.jpg");
//echo $ar[0] ."\r\n";
//echo $ar[1] ."\r\n";

//$ch = curl_init();

//var_dump( Images::GetImagePath("123456", "producer", "bigpothrag.jpg"));
//die();

// View目录放导航
//$app->get('/Certificate/:ProducerId', function ($ProducerId)
//	{
//		CALL Model's funcs
//
// Model放逻辑代码
// 对所有代码加TRY CATCH
// 映射json,db错误到HTTP CODE和消息 
//
set_exception_handler('UnhandledException');

/*try
{
	throw new DBException("DBException - 001");
}
catch (DBException $ex)
{
	echo "--DBException\r\n";
	echo $ex->getMessage();
	die();
}
catch (NJBException $ex)
{
	echo "----NJBException\r\n";
	echo $ex->getMessage();
	die();
}*/

//test
//echo "aaa\r\n";
//echo AES::Decrypt(AES::Encrypt("aaaa")) ."\r\n";
//end of test

/**
 * Step 4: Run the Slim application
 *
 * This method should be called last. This executes the Slim application
 * and returns the HTTP response to the HTTP client.
 */
//var_dump($app->request->headers);

/*echo $_SERVER['REQUEST_METHOD'] . "<br>";
echo $_SERVER['REQUEST_URI'] . "<br>";

if (String::startsWith($_SERVER['REQUEST_URI'], "/Producer/LoginName/") === FALSE)
{
echo "NOT startwith<br>";
}
else
{
echo "startwith:[" . (String::startsWith($_SERVER['REQUEST_URI'], "/Producer/LoginName/") !== TRUE ) . "]<br>";
}
flush();*/

//Check UserSessionId in header for all URIs(except for register and login pages).
if (
 ($_SERVER['REQUEST_METHOD'] == "POST" && !String::startsWith($_SERVER['REQUEST_URI'], "/Producer/BasicInfo/")) &&
 ($_SERVER['REQUEST_METHOD'] == "POST" && !String::startsWith($_SERVER['REQUEST_URI'], "/Consumer/BasicInfo/")) &&
 ($_SERVER['REQUEST_METHOD'] == "GET" && !String::startsWith($_SERVER['REQUEST_URI'], "/Producer/LoginName/")) &&
 ($_SERVER['REQUEST_METHOD'] == "GET" && !String::startsWith($_SERVER['REQUEST_URI'], "/Consumer/LoginName/"))
 )
{
	//echo "TRAP<BR>";
	if (!isset($app->request->headers["UserSessionId"]))
	{
		//echo "HTTP/1.1 403 Forbidden\r\n";
		header("HTTP/1.1 403 Forbidden"); 
		return;
	}
}
//echo "PASS<BR>";
//flush();
//header("HTTP/1.1 200 OK"); 
//return;

//ProducerTest::Test1();

$app->run();


//echo '===0<br>\r\n';
//flush();
//$test = new ProducerTest();
//$test->TestPOSTProducerBasicInfo();
//die();

//$test = new ProducerTest();
//$test->run();


//$_SERVER['PATH_INFO'] = "/Product/Image/1";
//Environment::mock(array(
//            'PATH_INFO' => '/hello/world'
 //       ));        
//$response = $test->invoke();
//$test->test007($app);

//$test->Test1();
//die();