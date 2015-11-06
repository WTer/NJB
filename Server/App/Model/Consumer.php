<?php

class Consumer 
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

	public function post()
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("LoginName", "Password", "DisplayName"));

			$consumer = R::dispense('consumer');
			$consumer->loginname = $requestJson->LoginName;
			$consumer->password = $requestJson->Password;
			$consumer->displayname = $requestJson->DisplayName;
			$consumer->bigportraitpath = 'NULL';
			$consumer->bigportraiturl = 'NULL';
			$consumer->smallportraitpath = 'NULL';
			$consumer->smallportraiturl = 'NULL';
			$consumer->province = 'NULL';
			$consumer->city = 'NULL';
			$consumer->address = 'NULL';
			$consumer->telephone = 'NULL';
			$consumer->lastmodifiedtime = now();
			$id = R::store($consumer);

			$response = R::find('consumer', 'id=?', array($id));
			$this->_app->response->status(200);

			$token = UserToken::Create($consumer->loginname, $consumer->password);
			$RDB = R::dispense('usersession');			
			$RDB->sessionid = $token;
			$RDB->lastmodifiedtime = now();
			R::store($RDB);
			$this->_app->response->headers->set("UserSessionId", $token);

			//echo json_encode(R::exportAll($response));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_ConsumerId($ConsumerId)
	{
		try
		{
			/*$requestBody = $this->_app->request->getBody();
			$requestBody = DecodeBody($requestBody);
			$requestJson = json_decode($requestBody);*/

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			//RequestBodyHandler::verifyJsonBody($requestJson, array("OldPassword", "NewPassword", "DisplayName"));
			RequestBodyHandler::verifyJsonBody($requestJson, array("DisplayName"));

			$consumer = R::getRow('SELECT id, password, displayname FROM consumer WHERE id=?', array($ConsumerId));
			if (!isset($consumer) || empty($consumer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}		

			$consumer = R::findOne('consumer', 'id=?', array($ConsumerId));

			//$consumer->password = $requestJson->NewPassword;
			$consumer->displayname = $requestJson->DisplayName;
			R::store($consumer);
			

			$response = R::find('consumer', 'id=?', array($ConsumerId));
			//echo json_encode(R::exportAll($response));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function putPassword($ConsumerId)
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("OldPassword", "NewPassword"));

			$consumer = R::getRow('SELECT * FROM consumer WHERE id = ? AND password = ?', array($ConsumerId, $requestJson->OldPassword));
			if (!isset($consumer) || empty($consumer))
			{
				throw new RecordNotFoundException("Record not found or passord is incorrect, id:" . $ConsumerId);
			}

			$consumer = R::findOne('consumer', 'id=?', array($ConsumerId));
			$consumer->password = $requestJson->NewPassword;
			R::store($consumer);

			$response = R::find('consumer', 'id=?', array($ConsumerId));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_ConsumerId($ConsumerId)
	{
		try
		{
			$consumer = R::find('consumer', 'id=?', array($ConsumerId));
			if (!isset($consumer) || empty($consumer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			//echo json_encode(R::exportAll($consumer));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($consumer));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_Portrait_ConsumerId($ConsumerId)
	{
		try
		{
			//$paramValue = $this->_app->request->getBody();
			//$data = json_decode($paramValue);
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("BigPortrait", "SmallPortrait"));

			$consumer = R::findOne('consumer', 'id=?', array($ConsumerId));
			if (!isset($consumer) || empty($consumer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			$BigPortraitContent = base64_decode(str_replace(" ", "+", $requestJson->BigPortrait));
			$SmallPortraitContent = base64_decode(str_replace(" ", "+", $requestJson->SmallPortrait));


			/*if (!empty($consumer->bigportraitpath) && 'NULL' != $consumer->bigportraitpath)
			{
				$myfile = fopen($consumer->bigportraitpath, "w");
				fwrite($myfile, $BigPortraitContent);
				fclose($myfile);
			}
			else*/
			{
				$imageArray = Images::GetImagePath($ConsumerId, "consumer", "BigPortrait.jpg");
				if (!is_dir($imageArray[0]))
				{					
					mkdir($imageArray[0], 0777, true);
				}

				$consumer->bigportraitpath = $imageArray[0] . $imageArray[1];
				$consumer->bigportraiturl = $imageArray[2];
				$myfile = fopen($consumer->bigportraitpath, "w");
				fwrite($myfile, $BigPortraitContent);
				fclose($myfile);
			}

			/*if (!empty($consumer->smallportraitpath) && 'NULL' != $consumer->smallportraitpath)
			{
				$myfile = fopen($consumer->smallportraitpath, "w");
				fwrite($myfile, $SmallPortraitContent);
				fclose($myfile);
			}
			else*/
			{
				/*$imageArray = Images::GetImagePath($ConsumerId, "consumer", "SmallPortrait.jpg");
				$consumer->smallportraitpath = $imageArray[0];//"C:\\Apache24\\htdocs\\AppPicture\\" . $ConsumerId . ".ConsumerSmallPortrait.jpg";
				$consumer->smallportraiturl = $imageArray[1];//"http://localhost:8080/AppPicture/" . $ConsumerId . ".ConsumerSmallPortrait.jpg";
				$myfile = fopen($consumer->smallportraitpath, "w");
				fwrite($myfile, $requestJson->SmallPortrait);
				fclose($myfile);*/

				$imageArray = Images::GetImagePath($ConsumerId, "consumer", "SmallPortrait.jpg");
				if (!is_dir($imageArray[0]))
				{					
					mkdir($imageArray[0], 0777, true);
				}

				$consumer->smallportraitpath = $imageArray[0] . $imageArray[1];
				$consumer->smallportraiturl = $imageArray[2];
				$myfile = fopen($consumer->smallportraitpath, "w");
				fwrite($myfile, $BigPortraitContent);
				fclose($myfile);
			}
			R::store($consumer);

			$response = R::find('consumer', 'id=?', array($ConsumerId));
			//echo json_encode(R::exportAll($response),JSON_UNESCAPED_SLASHES);
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_Portrait_ConsumerId($ConsumerId)
	{
		try
		{
			$consumer = R::getRow('SELECT bigportraiturl, smallportraiturl FROM consumer WHERE id = ?', array($ConsumerId));
			if (!isset($consumer) || empty($consumer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			//echo json_encode($consumer, JSON_UNESCAPED_SLASHES);
			echo ResponseJsonHandler::normalizeJsonResponse($consumer);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_RichInfo_ConsumerId($ConsumerId)
	{
		try
		{
			/*$paramValue = $this->_app->request->getBody();
			$data = json_decode($paramValue);*/

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Province", "City", "Address", "Telephone"));

			$consumer = R::findOne('consumer', 'id=?', array($ConsumerId));
			if (!isset($consumer) || empty($consumer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			$consumer->province = $requestJson->Province;
			$consumer->city = $requestJson->City;
			$consumer->address = $requestJson->Address;
			$consumer->telephone = $requestJson->Telephone;
			R::store($consumer);

			$consumer = R::getRow('SELECT province, city, address, telephone  FROM consumer WHERE id = ?', array($ConsumerId));
			//echo json_encode($consumer, JSON_UNESCAPED_UNICODE);
			echo ResponseJsonHandler::normalizeJsonResponse($consumer);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_RichInfo_ConsumerId($ConsumerId)
	{
		try
		{
			$consumer = R::getRow('SELECT province, city, address, telephone FROM consumer WHERE id = ?', array($ConsumerId));
			if (!isset($consumer) || empty($consumer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			//echo json_encode($consumer, JSON_UNESCAPED_UNICODE);
			echo ResponseJsonHandler::normalizeJsonResponse($consumer);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function login($LoginName, $SessionKey)
	{
		try
		{
			// 解密
			//$password = AES::Decrypt($SessionKey);

			$password = $SessionKey;

			$consumer = R::getRow('SELECT id, smallportraiturl FROM consumer WHERE loginname=? AND password=?', array($LoginName, $password));
			if (!isset($consumer) || empty($consumer))
			{
				throw new RecordNotFoundException("Record not found, LoginName:" . $LoginName);
			}

			$token = UserToken::Create($LoginName, $password);
			$RDB = R::dispense('usersession');			
			$RDB->sessionid = $token;
			$RDB->lastmodifiedtime = now();
			R::store($RDB);
			$this->_app->response->headers->set("UserSessionId", $token);

			//echo json_encode($consumer, JSON_UNESCAPED_SLASHES);
			echo ResponseJsonHandler::normalizeJsonResponse($consumer);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function checkLoginName($LoginName)
	{
		try
		{
			$consumer = R::getRow('SELECT id FROM consumer WHERE loginname=?', array($LoginName));
			if (isset($consumer) || !empty($consumer))
			{
				throw new RecordDuplicatedException("Record alredy exists, LoginName:" . $LoginName);
			}
			echo json_encode(array("msg" => "success"));
		}
		catch (Exception $ex)
		{
			//echo $ex;
			//flush();

			return ExceptionHandler::Response($ex, $this->_app);
		}
	}


	
	public function postSmsCode()
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Telephone"));

			$randomCode = rand(1000, 9999);
			$expireInMins = "1";
			$tempId = "46556";

			//发送短信验证码
			$reponseArray = SMS::SendTemplateSMS($requestJson->Telephone, array($randomCode, $expireInMins), $tempId);

			$rdb = R::dispense('consumersmscode');
			$rdb->telephone = $requestJson->Telephone;
			$rdb->code = $randomCode;
			$rdb->expirationtime = date('Y-m-d H:i:s', strtotime("+1 minute"));
			$rdb->statuscode = $reponseArray[0];
			$rdb->smsmessagesid = $reponseArray[1];
			$rdb->datecreated = $reponseArray[2];
			$rdb->lastmodifiedtime = now();
			$id = R::store($rdb);

			echo ResponseJsonHandler::normalizeJsonResponse(array("id" => $id, "smsCode" => $randomCode, "telephone" => $requestJson->Telephone));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function verifySmsCode($SmsCodeId, $UserSmsCode, $Telephone)
	{
		try
		{
			$producer = R::getRow('SELECT id FROM consumersmscode WHERE id=? AND code=? AND telephone=?', array($SmsCodeId, $UserSmsCode, $Telephone));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("SMS code is incorrect, SmsCodeId:" . $SmsCodeId);
			}

			//expirationtime > NOW()
			$producer = R::getRow('SELECT id FROM consumersmscode WHERE id=? AND code=? AND telephone=? AND expirationtime > NOW()', array($SmsCodeId, $UserSmsCode, $Telephone));
			if (!isset($producer) || empty($producer))
			{
				throw new SmsException("SMS expired.");
			}
			echo json_encode(array("msg" => "success"));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
}