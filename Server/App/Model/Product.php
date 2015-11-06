<?php

class Product 
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
			/*$requestBody = $app->request->getBody();
			$requestBody = DecodeBody($requestBody);
			$requestJson = json_decode($requestBody);*/

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Name", "Description", "Type", "Price", "OriginalPrice", "Unit", "Freight", "ProducerId"));

			$product = R::dispense('product');
			$product->name = $requestJson->Name;
			$product->description = $requestJson->Description;
			$product->type = $requestJson->Type;
			$product->price = $requestJson->Price;
			$product->originalprice = $requestJson->OriginalPrice;
			$product->unit = $requestJson->Unit;
			$product->freight = $requestJson->Freight;
			$product->producerid = $requestJson->ProducerId;
			$product->lastmodifiedtime = now();
			$id = R::store($product);

			$response = R::find('product', 'id=?', array($id));
			/*$app->response->status(201);
			echo json_encode(R::exportAll($response));*/
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_BasicInfo($ProductId)
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Name", "Description", "Type", "Price", "OriginalPrice", "Unit", "Freight"));

			$product = R::findOne('product', 'id=?', array($ProductId));
			if (!isset($product) || empty($product))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProductId);
			}

			$product->name = $requestJson->Name;
			$product->description = $requestJson->Description;
			$product->type = $requestJson->Type;
			$product->price = $requestJson->Price;
			$product->originalprice = $requestJson->OriginalPrice;
			$product->unit = $requestJson->Unit;
			$product->freight = $requestJson->Freight;
			$product->lastmodifiedtime = now();
			R::store($product);

			$response = R::find('product', 'id=?', array($ProductId));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_BasicInfo($ProductId)
	{
		try
		{
			$product = R::find('product', 'id=?', array($ProductId));
			if (!isset($product) || empty($product))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProductId);
			}

			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($product));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_BasicInfoList()
	{
		try
		{
			// get_BasicInfoList

			//$desc = true;
			//if ($_GET['desc']true

			$records = R::getAll(
				"SELECT a.id, b.id AS producerid "
			  . "FROM `product` a JOIN `producer` b "
			  . "ON a.producerid = b.id "
			  . "WHERE a.name LIKE ? AND a.description LIKE ? AND a.type LIKE ? AND b.province LIKE ? AND b.city LIKE ? AND b.address LIKE ? ORDER BY a.id DESC LIMIT ?,?",
				  array(
				  '%'.$_GET['ProductName'].'%',
				  '%'.$_GET['ProductDesc'].'%',
				  '%'.$_GET['ProductType'].'%',
				  '%'.$_GET['Province'].'%',
				  '%'.$_GET['City'].'%',
				  '%'.$_GET['Address'].'%',
				  (int)$_GET['offset'],
				  (int)$_GET['limit']
			  ));

			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found");
			}

			$Count = count($records);
			$productList = array();
			foreach ($records as $record)
			{
				$prodcutDetail = R::getRow('SELECT id, producerid, name, description, type, price, originalprice, unit, freight, lastmodifiedtime FROM product WHERE id=? LIMIT 1', array($record['id']));
				$prodcutImageDetail = R::getAll('SELECT id, description, bigportraiturl, smallportraiturl FROM productimage WHERE productid=? LIMIT 4', array($record['id']));
				//var_dump($prodcutImageDetail);
				$producerInfo = R::getRow('SELECT displayname, telephone, smallportraiturl FROM producer WHERE id=? LIMIT 1', array($record['producerid']));
				
				$isFavorite = false;
 				$favoriteInfo = (object)null;
				$productcommentInfo = array();
				if ($_GET['UserType'] == "C")
				{
					$favoriteInfo = R::getRow('SELECT id, consumerid AS userId, productid, lastmodifiedtime FROM consumerfavoriteproduct WHERE consumerid=? AND productid=?', array($_GET['UserId'], $record['id']));
					if (!isset($favoriteInfo) || empty($favoriteInfo))
					{
						//echo "FALSE\r\n";
						$isFavorite = false;
						//$favoriteInfo = array();
						//$favoriteInfo = '{}'; 
						//$favoriteInfo = array("id" => "", "userid" => "", "productid" => "", "lastmodifiedtime" => "");
						$favoriteInfo = (object)null;
					}
					else
					{
						//echo "TRUE\\r\n";
						$isFavorite = true;
					}

					$productcommentInfo = R::getAll('SELECT a.id, a.comment, a.lastmodifiedtime, b.displayname, b.smallportraiturl FROM productcomment a JOIN consumer b ON a.consumerid = b.id WHERE productid=? LIMIT 5', array($record['id']));
					if (!isset($productcommentInfo) || empty($productcommentInfo))
					{
						$productcommentInfo = array();
					}
					else
					{
						$productcommentInfo = $productcommentInfo;
					}
				}

				if ($_GET['UserType'] == "P")
				{
					$favoriteInfo = R::getRow('SELECT id, producerid AS userId, productid, lastmodifiedtime FROM  producerfavoriteproduct WHERE producerid=? AND productid=?', array($_GET['UserId'], $record['id']));
					if (!isset($favoriteInfo) || empty($favoriteInfo))
					{
						$isFavorite = false;
						//$favoriteInfo = array();
						//$favoriteInfo = '{}';
						//$favoriteInfo = R::findOne('consumerfavoriteproduct', 'id=?', array(0));
						$favoriteInfo = (object)null;
					}
					else
					{
						$isFavorite = true;
						//$favoriteInfo = array($favoriteInfo);
					}

					$productcommentInfo = R::getAll('SELECT a.id, a.comment, a.lastmodifiedtime, b.displayname, b.smallportraiturl FROM productcomment a JOIN consumer b ON a.consumerid = b.id WHERE productid=? LIMIT 5', array($record['id']));
					if (!isset($productcommentInfo) || empty($productcommentInfo))
					{
						$productcommentInfo = array();
					}
					else
					{
						$productcommentInfo = $productcommentInfo;
					}
				}

				$productList[] = array('ProductInfo' => $prodcutDetail, 'ProductImages' => $prodcutImageDetail, 'ProducerInfo' => $producerInfo, 'IsFavorite' => $isFavorite, 'FavoriteInfo' => $favoriteInfo, 'ProductCommentInfo' => $productcommentInfo);
				//$OrderList[] = array('ProductId' => $record['id']);

				//添加搜索词到热门搜索词表
				if (isset($_GET['ProductName']) && !empty($_GET['ProductName']))
				{
					$rdb = R::dispense('searchword');
					$rdb->name = $_GET['ProductName'];
					//var_dump($prodcutDetail);//->type
					$rdb->type = $prodcutDetail["type"];
					$rdb->searchtime = now();
					R::store($rdb);
				}				
			}
			sendSuccess(array(
				'Count'     => $Count,
				'List' => $productList,
			));

			/*//添加搜索词到热门搜索词表
			if (isset($_GET['ProductName']) && !empty($_GET['ProductName']))
			{
				$rdb = R::dispense('searchword');
				$rdb->name = $_GET['ProductName'];
				$rdb->searchtime = now();
				R::store($rdb);
			}*/			
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getHotSearchWord()
	{
		//get types of searchwords
		$types = R::getAll("SELECT DISTINCT type FROM searchword WHERE type <> '' OR type <> null");
		$Count = count($types);
		$List = array();
		foreach ($types as $type)
		{
			$records = R::getAll("SELECT name, COUNT(name) AS searchcount FROM searchword WHERE type=? GROUP BY name ORDER BY searchcount DESC LIMIT ?", array($type["type"], (int)$_GET['limit']));		
			//$Count = count($records);
			$KeyWords = array();
			foreach ($records as $record)
			{
				$KeyWords[] = array('name' => $record["name"], "searchcount" => $record["searchcount"]);
			}
			//$List[] = array('HotSearchWord' => array("type" => $type["type"], "KeyWords" => $record));
			$List[] = array('HotSearchWord' => array("type" => $type["type"], "KeyWords" => $KeyWords));
		}
		sendSuccess(
			array(
				'Count'  => $Count,
				'List'   => $List,
			));
	}

	public function put_Images($ProductId)
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
				
				//new
				if (empty($row['ImageId']))
				{
					$productimage = R::dispense('productimage');
					$productimage->description = $row['Description'];
					$productimage->productid = $ProductId;
					$productimage->bigportraitpath = 'NULL';
					$productimage->bigportraiturl = 'NULL';
					$productimage->smallportraitpath = 'NULL';
					$productimage->smallportraiturl = 'NULL';
					$productimage->lastmodifiedtime = now();
					$id = R::store($productimage);
					
					// Store pictures
					$productimage = R::findOne('productimage', 'id=?', array($id));

					$imageArray = Images::GetImagePath($id, "product", "BigProduct.jpg");
					if (!is_dir($imageArray[0]))
					{
						mkdir($imageArray[0], 0777, true);
					}
					$productimage->bigportraitpath = $imageArray[0] . $imageArray[1];
					$productimage->bigportraiturl = $imageArray[2];
					$myfile = fopen($productimage->bigportraitpath, "w");
					fwrite($myfile, $BigPictureContent);
					fclose($myfile);

					$imageArray = Images::GetImagePath($id, "product", "SmallProduct.jpg");
					if (!is_dir($imageArray[0]))
					{
						mkdir($imageArray[0], 0777, true);
					}

					$productimage->smallportraitpath = $imageArray[0] . $imageArray[1];
					$productimage->smallportraiturl = $imageArray[2];
					$myfile = fopen($productimage->smallportraitpath, "w");
					fwrite($myfile, $SmallPictureContent);
					fclose($myfile);

					$id = R::store($productimage);
				}
				else
				{
					//echo "aaaaaaa\r\n";
					$productimage = R::findOne('productimage', 'id=?', array($row['ImageId']));
					$productimage->description = $row['Description'];
					$productimage->lastmodifiedtime = now();

					/*$myfile = fopen($productimage->bigportraitpath, "w");
					fwrite($myfile, $BigPictureContent);
					fclose($myfile);

					$myfile = fopen($productimage->smallportraitpath, "w");
					fwrite($myfile, $SmallPictureContent);
					fclose($myfile);
					R::store($productimage);*/

					// Store pictures
					$imageArray = Images::GetImagePath($id, "product", "BigProduct.jpg");
					if (!is_dir($imageArray[0]))
					{
						mkdir($imageArray[0], 0777, true);
					}
					$productimage->bigportraitpath = $imageArray[0] . $imageArray[1];
					$productimage->bigportraiturl = $imageArray[2];
					$myfile = fopen($productimage->bigportraitpath, "w");
					fwrite($myfile, $BigPictureContent);
					fclose($myfile);

					$imageArray = Images::GetImagePath($id, "product", "SmallProduct.jpg");
					if (!is_dir($imageArray[0]))
					{
						mkdir($imageArray[0], 0777, true);
					}

					$productimage->smallportraitpath = $imageArray[0] . $imageArray[1];
					$productimage->smallportraiturl = $imageArray[2];
					$myfile = fopen($productimage->smallportraitpath, "w");
					fwrite($myfile, $SmallPictureContent);
					fclose($myfile);

					$id = R::store($productimage);
				}
			}

			// package response
			$images = R::find('productimage', 'productid=?', array($ProductId));
			$response = new ResponseJSON(["id", "productid", "description", "bigportraiturl", "smallportraiturl"]);
			foreach($images as $image)
			{
				$response->appendData($image);
			}

			//print json_encode($response2->exportResponse())."\n";
			echo $response->exportResponse()."\n";
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_Image($ProductId)
	{
		try
		{
			$result = R::getRow('SELECT id, description, bigportraiturl, smallportraiturl FROM productimage WHERE productid=? LIMIT 1', array($ProductId));
			if (!isset($result) || empty($result))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProductId);
			}

			//echo json_encode($result, );
			echo ResponseJsonHandler::normalizeJsonResponse($result);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_Images($ProductId)
	{
		try
		{
			/*$product = R::find('product', 'ProductId=?', array($ProductId));
			echo json_encode(R::exportAll($product));*/

			$records = R::getAll('SELECT id, description, bigportraiturl, smallportraiturl FROM productimage WHERE productid=?', array($ProductId));
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProductId);
			}

			/*$Count = count($records);
			$OrderList = array();
			foreach ($records as $record)
			{
				$List[] = array('Id' => $record['id'], 'description' => $record['description'], 'bigportraiturl' => $record['bigportraiturl'], 'smallportraiturl' => $record['smallportraiturl']);
			}
			sendSuccess(array(
				'Count'     => $Count,
				'List' => $List,
			));*/

			$response = new ResponseJSON(["id", "description", "bigportraiturl", "smallportraiturl"]);
			foreach( $records as $record)
			{
				$response->appendData($record);
			}

			//print json_encode($response2->exportResponse())."\n";
			echo $response->exportResponse()."\n";

		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
}
