<?php

class Producer 
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

	public function post_BasicInfo()
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("LoginName", "Password", "DisplayName", "Province", "City", "Address", "Telephone", "Website"));

			$producer = R::dispense('producer');
			$producer->loginname = $requestJson->LoginName;
			$producer->password = $requestJson->Password;
			$producer->displayname = $requestJson->DisplayName;
			$producer->province = $requestJson->Province;			
			$producer->city = $requestJson->City;
			$producer->address = $requestJson->Address;
			$producer->telephone = $requestJson->Telephone;
			$producer->website = $requestJson->Website;
			$producer->createtime = now();
			$producer->lastmodifiedtime = now();

			$producer->bigportraitpath = "";
			$producer->bigportraiturl = "";
			$producer->smallportraitpath = "";
			$producer->smallportraiturl = "";

			$id = R::store($producer);

			$response = R::find('producer', 'id=?', array($id));
			$this->_app->response->status(200);
			//echo 'aaaaaa:' . UserToken::Create($producer->loginname, $producer->password). "\r\n";

			$token = UserToken::Create($producer->loginname, $producer->password);
			$RDB = R::dispense('usersession');			
			$RDB->sessionid = $token;
			$RDB->lastmodifiedtime = now();
			R::store($RDB);
			$this->_app->response->headers->set("UserSessionId", $token);

			//$dbResult = R::exportAll($response);
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
			//$jsonResponse =  json_encode($dbResult);
			//$jsonResponse = str_replace("[", "", $jsonResponse);
			//echo $jsonResponse;
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_BasicInfo($ProducerId)
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("DisplayName", "Province", "City", "Address", "Telephone", "Website"));

			//$paramValue = $this->_app->request->getBody();
			//$data = json_decode($paramValue);

			$producer = R::findOne('producer', 'id=?', array($ProducerId));
			//$producer = R::getRow('SELECT * FROM producer WHERE id = ? AND password = ?', array($ProducerId, $requestJson->OldPassword));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			//$producer->loginname = $requestJson->LoginName;
			$producer->displayname = $requestJson->DisplayName;
			$producer->province = $requestJson->Province;
			$producer->city = $requestJson->City;
			$producer->address = $requestJson->Address;
			$producer->telephone = $requestJson->Telephone;
			$producer->website = $requestJson->Website;
			R::store($producer);

			$response = R::find('producer', 'id=?', array($ProducerId));
			//echo json_encode(R::exportAll($response));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function putPassword($ProducerId)
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			//var_dump($requestJson);
			RequestBodyHandler::verifyJsonBody($requestJson, array("OldPassword", "NewPassword"));

			$producer = R::getRow('SELECT * FROM producer WHERE id = ? AND password = ?', array($ProducerId, $requestJson->OldPassword));
			//var_dump($producer);
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("Record not found or passord is incorrect, id:" . $ProducerId);
			}

			$producer = R::findOne('producer', 'id=?', array($ProducerId));

			//echo "start to store DB...\r\n";
			$producer->password = $requestJson->NewPassword;
			//echo "start to store DB done.\r\n";
			R::store($producer);

			$response = R::find('producer', 'id=?', array($ProducerId));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_BasicInfo($ProducerId)
	{
		try
		{
			$producer = R::find('producer', 'id=?', array($ProducerId));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			//echo json_encode(R::exportAll($producer));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($producer));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_Portrait($ProducerId)
	{
		try
		{
			//$paramValue = $this->_app->request->getBody();
			//$data = json_decode($paramValue);
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("BigPortrait", "SmallPortrait"));

			$producer = R::findOne('producer', 'id=?', array($ProducerId));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			$BigPortraitContent = base64_decode(str_replace(" ", "+", $requestJson->BigPortrait));
			$SmallPortraitContent = base64_decode(str_replace(" ", "+", $requestJson->SmallPortrait));

			/*if (!empty($producer->bigportraitpath))
			{
				$myfile = fopen($producer->bigportraitpath, "w");
				fwrite($myfile, $BigPortraitContent);
				fclose($myfile);
			}
			else*/
			{
				$imageArray = Images::GetImagePath($ProducerId, "producer", "BigPortrait.jpg");
				if (!is_dir($imageArray[0]))
				{					
					mkdir($imageArray[0], 0777, true);
				}

				$producer->bigportraitpath = $imageArray[0] . $imageArray[1];//"C:\\Apache24\\htdocs\\AppPicture\\" . $ProducerId . ".ProducerBigPortrait.jpg";
				$producer->bigportraiturl = $imageArray[2];//"http://localhost:8080/AppPicture/" . $ProducerId . ".ProducerBigPortrait.jpg";
				$myfile = fopen($producer->bigportraitpath, "w");
				fwrite($myfile, $BigPortraitContent);
				fclose($myfile);
			}

			/*if (!empty($producer->smallportraitpath))
			{
				$myfile = fopen($producer->smallportraitpath, "w");
				fwrite($myfile, $SmallPortraitContent);
				fclose($myfile);
			}
			else*/
			{
				$imageArray = Images::GetImagePath($ProducerId, "producer", "SmallPortrait.jpg");
				if (!is_dir($imageArray[0]))
				{					
					mkdir($imageArray[0], 0777, true);
				}

				$producer->smallportraitpath = $imageArray[0] . $imageArray[1];
				$producer->smallportraiturl = $imageArray[2];
				$myfile = fopen($producer->smallportraitpath, "w");
				fwrite($myfile, $SmallPortraitContent);
				fclose($myfile);
			}

			R::store($producer);

			$response = R::find('producer', 'id=?', array($ProducerId));
			//echo json_encode(R::exportAll($response),JSON_UNESCAPED_SLASHES);	
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_Portrait($ProducerId)
	{
		try
		{
			$producer = R::getRow('SELECT bigportraiturl, smallportraiturl FROM producer WHERE id = ?', array($ProducerId));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			//$producer->bigportraiturl = stripslashes($producer->bigportraiturl);
			//$producer->smallportraiturl = stripslashes($producer->smallportraiturl);

			//echo json_encode($producer,JSON_UNESCAPED_SLASHES/*, JSON_UNESCAPED_UNICODE*/);		
			echo ResponseJsonHandler::normalizeJsonResponse($producer);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_RichInfo($ProducerId)
	{
		try
		{
			//$paramValue = $this->_app->request->getBody();
			//$data = json_decode($paramValue);

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Description", "CreateTime"));

			$producer = R::findOne('producer', 'id=?', array($ProducerId));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			$producer->description = $requestJson->Description;
			$producer->createtime = $requestJson->CreateTime;
			R::store($producer);

			$response = R::find('producer', 'id=?', array($ProducerId));
			//echo json_encode(R::exportAll($response), JSON_UNESCAPED_SLASHES);
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_RichInfo($ProducerId)
	{
		try
		{
			$producer = R::getRow('SELECT description, createtime FROM producer WHERE id = ?', array($ProducerId));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			//echo json_encode($producer);	
			echo ResponseJsonHandler::normalizeJsonResponse($producer);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_Certificate($ProducerId)
	{
		try
		{
			$requestBody = $this->_app->request->getBody();
			$requestObj = new RequestJSON($requestBody);

			while(true)
			{
				$row = $requestObj->getNext();
				if ($row == array())
				{
					break;
				};

				$BigPictureContent = base64_decode(str_replace(" ", "+", $row['BigPicture']));
				$SmallPictureContent = base64_decode(str_replace(" ", "+", $row['SmallPicture']));
				
				// new
				if (empty($row['CertificateId']))
				{
					$certificate = R::dispense('producercertificate');
					$certificate->certficatetime = $row['CertficateTime'];
					$certificate->producerid = $ProducerId;
					$certificate->bigcertificatepath = 'NULL';
					$certificate->bigcertificateurl = 'NULL';
					$certificate->smallcertificatepath = 'NULL';
					$certificate->smallcertificateurl = 'NULL';
					$certificate->lastmodifiedtime = now();
					$id = R::store($certificate);

					// Store pictures
					$certificate = R::findOne('producercertificate', 'id=?', array($id));

					$imageArray = Images::GetImagePath($id, "producercertificate", "BigCertificate.jpg");
					if (!is_dir($imageArray[0]))
					{
						mkdir($imageArray[0], 0777, true);
					}
					$certificate->bigcertificatepath = $imageArray[0] . $imageArray[1];
					$certificate->bigcertificateurl = $imageArray[2];
					$myfile = fopen($certificate->bigcertificatepath, "w");
					fwrite($myfile, $BigPictureContent);
					fclose($myfile);

					$imageArray = Images::GetImagePath($id, "producercertificate", "SmallCertificate.jpg");
					if (!is_dir($imageArray[0]))
					{
						mkdir($imageArray[0], 0777, true);
					}

					$certificate->smallcertificatepath = $imageArray[0] . $imageArray[1];
					$certificate->smallcertificateurl = $imageArray[2];
					$myfile = fopen($certificate->smallcertificatepath, "w");
					fwrite($myfile, $SmallPictureContent);
					fclose($myfile);

					$id = R::store($certificate);
				}
				else
				{
					$certificate = R::findOne('producercertificate', 'id=?', array($row['CertificateId']));
					$certificate->certficatetime = $row['CertficateTime'];
					$certificate->lastmodifiedtime = now();

					/*$myfile = fopen($certificate->bigcertificatepath, "w");
					fwrite($myfile, $BigPictureContent);
					fclose($myfile);

					$myfile = fopen($certificate->smallcertificatepath, "w");
					fwrite($myfile, $SmallPictureContent);
					fclose($myfile);
					R::store($certificate);*/

					// Store pictures
					$imageArray = Images::GetImagePath($row['CertificateId'], "producercertificate", "BigCertificate.jpg");
					if (!is_dir($imageArray[0]))
					{
						mkdir($imageArray[0], 0777, true);
					}
					$certificate->bigcertificatepath = $imageArray[0] . $imageArray[1];
					$certificate->bigcertificateurl = $imageArray[2];
					$myfile = fopen($certificate->bigcertificatepath, "w");
					fwrite($myfile, $BigPictureContent);
					fclose($myfile);

					$imageArray = Images::GetImagePath($row['CertificateId'], "producercertificate", "SmallCertificate.jpg");
					if (!is_dir($imageArray[0]))
					{
						mkdir($imageArray[0], 0777, true);
					}

					$certificate->smallcertificatepath = $imageArray[0] . $imageArray[1];
					$certificate->smallcertificateurl = $imageArray[2];
					$myfile = fopen($certificate->smallcertificatepath, "w");
					fwrite($myfile, $SmallPictureContent);
					fclose($myfile);

					R::store($certificate);
				}
			}

			// package response
			$certs = R::find('producercertificate', 'ProducerId=?', array($ProducerId));
			$response = new ResponseJSON(["id", "certficatetime", "bigcertificateurl", "smallcertificateurl"]);
			foreach( $certs as $cert )
			{
				$response->appendData($cert);
			}

			//print json_encode($response2->exportResponse())."\n";
			echo $response->exportResponse();
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_Certificate($ProducerId)
	{
		try
		{
			$certs = R::find('producercertificate', 'ProducerId=?', array($ProducerId));
			if (!isset($certs) || empty($certs))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			$response = new ResponseJSON(["id", "certficatetime", "bigcertificateurl", "smallcertificateurl"]);
			foreach( $certs as $cert)
			{
				$response->appendData($cert);
			}

			//print json_encode($response2->exportResponse())."\n";
			echo $response->exportResponse()."\n";

		
			//只返回认证证书列表信息,多条认证信息一同返回
			/* List
			$bottles = R::find( 'whisky' );
			if ( !count( $bottles ) ) die( "The cellar is empty!\n" );
			foreach( $bottles as $b )
			{
				echo "* #{$b->id}: {$b->name}\n";
			}
			*/			
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
	
	public function deleteCertificate($CertificateId)
	{
		try
		{
			$record = R::findOne('producercertificate', 'id=?', array($CertificateId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $CertificateId);
			}

			R::trash($record);			
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
			//echo "Login<br>";
			//flush();
			// 解密
			//$password = AES::Decrypt($SessionKey);

			//echo "loginname:" . $LoginName ."<br>";
			//echo "password:" . $password ."<br>";
			//flush();

			$password = $SessionKey;
			$producer = R::getRow('SELECT id, smallportraiturl FROM producer WHERE loginname=? AND password=?', array($LoginName, $password));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("Record not found, LoginName:" . $LoginName);
			}

			$token = UserToken::Create($LoginName, $password);
			$RDB = R::dispense('usersession');			
			$RDB->sessionid = $token;
			$RDB->lastmodifiedtime = now();
			R::store($RDB);
			$this->_app->response->headers->set("UserSessionId", $token);
			//echo json_encode($producer, JSON_UNESCAPED_SLASHES);
			echo ResponseJsonHandler::normalizeJsonResponse($producer);

			/*
			$bottles = R::find( 'whisky' );
			if ( !count( $bottles ) ) die( "The cellar is empty!\n" );
			foreach( $bottles as $b )
			{
				echo "* #{$b->id}: {$b->name}\n";
			}
			*/
			
			/*
			$w = R::load( 'whisky', $opts['attach-to'] );
			if (!$w->id) die( "No such bottle.\n" );

			*/			
		}
		catch (Exception $ex)
		{
			//echo $ex;
			//flush();

			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function checkLoginName($LoginName)
	{
		try
		{
			$producer = R::getRow('SELECT id FROM producer WHERE loginname=?', array($LoginName));
			if (isset($producer) || !empty($producer))
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

			$rdb = R::dispense('producersmscode');
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
			$producer = R::getRow('SELECT id FROM producersmscode WHERE id=? AND code=? AND telephone=?', array($SmsCodeId, $UserSmsCode, $Telephone));
			if (!isset($producer) || empty($producer))
			{
				throw new RecordNotFoundException("SMS code is incorrect, SmsCodeId:" . $SmsCodeId);
			}

			//expirationtime > NOW()
			$producer = R::getRow('SELECT id FROM producersmscode WHERE id=? AND code=? AND telephone=? AND expirationtime > NOW()', array($SmsCodeId, $UserSmsCode, $Telephone));
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