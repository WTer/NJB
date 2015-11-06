<?php

class Order 
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

	public function post_Consumer_Product($ConsumerId, $ProductId)
	{
		try
		{
			//$requestBody = $app->request->getBody();
			//$requestJson = json_decode($requestBody, true);

			/*if (empty($requestJson)) {
				sendFail(array(
					'error'  => '1000',
					'reason' => '请求的消息体为空，或者不是合法的JSON内容．',
				));
				return;
			}*/

			/*$Count       = null;
			$Unit        = null;
			$Description = null;
			if (isset($requestJson['Count'])) {
				$Count = $requestJson['Count'];
			}
			if (isset($requestJson['Unit'])) {
				$Unit = $requestJson['Unit'];
			}
			if (isset($requestJson['Description'])) {
				$Description = $requestJson['Description'];
			}

			if (is_null($Count) || is_null($Unit) || is_null($Description)) {
				sendFail(array(
					'error'  => '1000',
					'reason' => '请求的消息体内容不全',
				));
				return;
			}*/

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Count", "Unit", "Description", "ConsigneeId"));

			$obj = R::dispense('orders');
			$obj->productid        = $ProductId;
			$obj->consumerid       = $ConsumerId;
			$obj->count            = $requestJson->Count;
			$obj->unit             = $requestJson->Unit;
			$obj->status           = 0;
			$obj->externallink     = '';
			$obj->description      = $requestJson->Description;
			$obj->consigneeid          = $requestJson->ConsigneeId;
			$obj->lastmodifiedtime = now();
			$id = R::store($obj);

			//sendSuccess(json_encode(R::exportAll($obj)));	

			//新增联系人
			$rdbProduct = R::getRow("SELECT producerid FROM product WHERE id = ?", [$ProductId]);
			//1. 农场主-》消费者
			$rdbContact = R::getRow("SELECT id FROM producercontactconsumer WHERE producerid = ? AND consumerid = ?", [$rdbProduct['producerid'], $ConsumerId]);
			if (!isset($rdbContact) || empty($rdbContact))
			{
				$rdb = R::dispense('producercontactconsumer');
				$rdb->producerid = $rdbProduct['producerid'];
				$rdb->consumerid = $ConsumerId;
				$rdb->lastmodifiedtime = now();
				R::store($rdb);
			}
			//2. 消费者-》农场主
			$rdbContact = R::getRow("SELECT id FROM consumercontactproducer WHERE producerid = ? AND consumerid = ?", [$rdbProduct['producerid'], $ConsumerId]);
			if (!isset($rdbContact) || empty($rdbContact))
			{
				$rdb = R::dispense('consumercontactproducer');
				$rdb->consumerid = $ConsumerId;
				$rdb->producerid = $rdbProduct['producerid'];
				$rdb->lastmodifiedtime = now();
				R::store($rdb);
			}
			
			$response = R::find('orders', 'id=?', array($id));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_OrderId($OrderId)
	{
		try
		{
			$record = R::getRow("SELECT * FROM `orders` WHERE id = ?", [$OrderId]);
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $OrderId);
			}

			sendSuccess($record);				
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_ProducerId($ProducerId)
	{
		try
		{
			/*$records = R::getAll(
				"SELECT a.id "
			  . "FROM `orders` a Join `product` as b "
			  . "ON a.ProductId = b.id "
			  . "WHERE b.ProducerId = ?", [$ProducerId]);
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			$Count = count($records);
			$OrderList = array();
			foreach ($records as $record)
			{
				$OrderList[] = array('OrderId' => $record['id']);
			}
			sendSuccess(array(
				'Count'     => $Count,
				'List' => $OrderList,
			));*/
			
			$records = R::getAll("SELECT a.id, a.consumerid, a.count, a.unit, a.description, a.status, a.consigneeid, a.lastmodifiedtime AS ordertime, b.id AS productid, b.producerid, b.name, b.description, b.type, b.price, b.originalprice, b.unit, b.freight, b.lastmodifiedtime FROM orders a JOIN product b ON a.productid = b.id WHERE b.producerid = ? AND a.status = ? ORDER BY a.id DESC LIMIT ?,?", [$ProducerId, $_GET['status'], (int)$_GET['offset'], (int)$_GET['limit']]);

			$OrderCount = R::getRow('SELECT COUNT(id) AS totalCount FROM orders WHERE status=?', [$_GET['status']]);

			$Count = count($records);
			$OrderTotalCount = $OrderCount['totalCount'];
			$List = array();
			foreach ($records as $record)
			{
				$prodcutImageDetail = R::getRow('SELECT id, bigportraiturl, smallportraiturl FROM productimage WHERE productid=? LIMIT 1', array($record['productid']));
				$consigneeInfo = R::getRow('SELECT * FROM consignee WHERE id=? LIMIT 1', array($record['consigneeid']));
				$List[] = array('OrderInfo' => $record, 'ProductImage' => $prodcutImageDetail, 'ConsigneeInfo' => $consigneeInfo);
			}
			sendSuccess(array(
				'OrderTotalCount'  => $OrderTotalCount,
				'Count'       => $Count,
				'List' => $List,
			));
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
			/*$records = R::getAll(
					"SELECT id "
				  . "FROM `orders` "
				  . "WHERE consumerid = ?", [$ConsumerId]);
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			$Count = count($records);
			$OrderList = array();
			foreach ($records as $record)
			{
				$OrderList[] = array('OrderId' => $record['id']);
			}
			sendSuccess(array(
				'Count'     => $Count,
				'List' => $OrderList,
			));*/

			$records = R::getAll("SELECT a.id, a.consumerid, a.count, a.unit, a.description, a.status, a.consigneeid, a.lastmodifiedtime AS ordertime, b.id AS productid, b.producerid, b.name, b.description, b.type, b.price, b.originalprice, b.unit, b.freight, b.lastmodifiedtime FROM orders a JOIN product b ON a.productid = b.id WHERE a.consumerid = ? AND a.status = ? ORDER BY a.id DESC LIMIT ?,?", [$ConsumerId, $_GET['status'], (int)$_GET['offset'], (int)$_GET['limit']]);

			$OrderCount = R::getRow('SELECT COUNT(id) AS totalCount FROM orders WHERE status=?', [$_GET['status']]);

			$Count = count($records);
			$OrderTotalCount = $OrderCount['totalCount'];
			$List = array();
			foreach ($records as $record)
			{
				$prodcutImageDetail = R::getRow('SELECT id, bigportraiturl, smallportraiturl FROM productimage WHERE productid=? LIMIT 1', array($record['productid']));
				$consigneeInfo = R::getRow('SELECT * FROM consignee WHERE id=? LIMIT 1', array($record['consigneeid']));
				$List[] = array('OrderInfo' => $record, 'ProductImage' => $prodcutImageDetail, 'ConsigneeInfo' => $consigneeInfo);
			}
			sendSuccess(array(
				'OrderTotalCount'  => $OrderTotalCount,
				'Count'       => $Count,
				'List' => $List,
			));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getConsumerOrderCount($ConsumerId)
	{
		try
		{
			$OrderCount = R::getRow('SELECT COUNT(id) AS totalCount FROM orders WHERE consumerid=?', [$ConsumerId]);
			//var_dump($OrderCount);
			echo ResponseJsonHandler::normalizeJsonResponse($OrderCount);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getConsumerOrderDetailCount($ConsumerId)
	{
		try
		{
			$result = array('pending' => 0, 'confirmed' => 0, 'cancelled' => 0);
			$OrderCount = R::getAll('SELECT status, COUNT(id) AS totalCount FROM orders WHERE consumerid=? GROUP BY status ORDER BY status ASC', [$ConsumerId]);
			if (isset($OrderCount) && !empty($OrderCount))
			{
				//var_dump($OrderCount[0]);
				if (isset($OrderCount[0]["totalCount"]) && !empty($OrderCount[0]["totalCount"]))
				{
					if ($OrderCount[0]["status"] == "0")
					{
						//echo "0======<br>";
						$result['pending'] = $OrderCount[0]["totalCount"];
					}
					else if ($OrderCount[0]["status"] == "1")
					{
						//echo "0======<br>";
						$result['confirmed'] = $OrderCount[0]["totalCount"];
					}
					else if ($OrderCount[0]["status"] == "2")
					{
						//echo "0======<br>";
						$result['cancelled'] = $OrderCount[0]["totalCount"];
					}
				}
				if (isset($OrderCount[1]["totalCount"]) && !empty($OrderCount[1]["totalCount"]))
				{
					//echo "1======<br>";
					//$result['confirmed'] = $OrderCount[1]["totalCount"];
					if ($OrderCount[1]["status"] == "0")
					{
						//echo "0======<br>";
						$result['pending'] = $OrderCount[1]["totalCount"];
					}
					else if ($OrderCount[1]["status"] == "1")
					{
						//echo "0======<br>";
						$result['confirmed'] = $OrderCount[1]["totalCount"];
					}
					else if ($OrderCount[1]["status"] == "2")
					{
						//echo "0======<br>";
						$result['cancelled'] = $OrderCount[1]["totalCount"];
					}
				}
				if (isset($OrderCount[2]["totalCount"]) && !empty($OrderCount[2]["totalCount"]))
				{
					//echo "2======<br>";
					//$result['cancelled'] = $OrderCount[2]["totalCount"];
					if ($OrderCount[2]["status"] == "0")
					{
						//echo "0======<br>";
						$result['pending'] = $OrderCount[2]["totalCount"];
					}
					else if ($OrderCount[2]["status"] == "1")
					{
						//echo "0======<br>";
						$result['confirmed'] = $OrderCount[2]["totalCount"];
					}
					else if ($OrderCount[2]["status"] == "2")
					{
						//echo "0======<br>";
						$result['cancelled'] = $OrderCount[2]["totalCount"];
					}
				}
			}
			echo ResponseJsonHandler::normalizeJsonResponse($result);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getProducerOrderCount($ProducerId)
	{
		try
		{
			$OrderCount = R::getRow('SELECT COUNT(a.id) AS totalCount FROM orders a JOIN product b ON a.productid = b.id WHERE b.producerid=?', [$ProducerId]);
			//var_dump($OrderCount);
			echo ResponseJsonHandler::normalizeJsonResponse($OrderCount);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getProducerOrderDetailCount($ProducerId)
	{
		try
		{
			$result = array('pending' => 0, 'confirmed' => 0, 'cancelled' => 0);
			$OrderCount = R::getAll('SELECT status, COUNT(a.id) AS totalCount FROM orders a JOIN product b ON a.productid = b.id WHERE b.producerid=? GROUP BY status ORDER BY status ASC', [$ProducerId]);
			if (isset($OrderCount) && !empty($OrderCount))
			{
				if (isset($OrderCount[0]["totalCount"]) && !empty($OrderCount[0]["totalCount"]))
				{
					if ($OrderCount[0]["status"] == "0")
					{
						//echo "0======<br>";
						$result['pending'] = $OrderCount[0]["totalCount"];
					}
					else if ($OrderCount[0]["status"] == "1")
					{
						//echo "0======<br>";
						$result['confirmed'] = $OrderCount[0]["totalCount"];
					}
					else if ($OrderCount[0]["status"] == "2")
					{
						//echo "0======<br>";
						$result['cancelled'] = $OrderCount[0]["totalCount"];
					}
				}
				if (isset($OrderCount[1]["totalCount"]) && !empty($OrderCount[1]["totalCount"]))
				{
					//echo "1======<br>";
					//$result['confirmed'] = $OrderCount[1]["totalCount"];
					if ($OrderCount[1]["status"] == "0")
					{
						//echo "0======<br>";
						$result['pending'] = $OrderCount[1]["totalCount"];
					}
					else if ($OrderCount[1]["status"] == "1")
					{
						//echo "0======<br>";
						$result['confirmed'] = $OrderCount[1]["totalCount"];
					}
					else if ($OrderCount[1]["status"] == "2")
					{
						//echo "0======<br>";
						$result['cancelled'] = $OrderCount[1]["totalCount"];
					}
				}
				if (isset($OrderCount[2]["totalCount"]) && !empty($OrderCount[2]["totalCount"]))
				{
					//echo "2======<br>";
					//$result['cancelled'] = $OrderCount[2]["totalCount"];
					if ($OrderCount[2]["status"] == "0")
					{
						//echo "0======<br>";
						$result['pending'] = $OrderCount[2]["totalCount"];
					}
					else if ($OrderCount[2]["status"] == "1")
					{
						//echo "0======<br>";
						$result['confirmed'] = $OrderCount[2]["totalCount"];
					}
					else if ($OrderCount[2]["status"] == "2")
					{
						//echo "0======<br>";
						$result['cancelled'] = $OrderCount[2]["totalCount"];
					}
				}
			}
			echo ResponseJsonHandler::normalizeJsonResponse($result);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_OrderId($OrderId)
	{
		try
		{
			/*$requestBody = $app->request->getBody();
			$requestBody = DecodeBody($requestBody);
			$requestJson = json_decode($requestBody);*/

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Count", "Unit", "Description"));

			$order = R::findOne('orders', 'id=?', array($OrderId));
			if (!isset($order) || empty($order))
			{
				throw new RecordNotFoundException("Record not found, id:" . $OrderId);
			}

			$order->count = $requestJson->Count;
			$order->unit = $requestJson->Unit;
			$order->description = $requestJson->Description;
			$order->lastmodifiedtime = now();
			R::store($order);

			$response = R::find('orders', 'id=?', array($OrderId));
			//echo json_encode(R::exportAll($response));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_OrderStatus($OrderId)
	{
		try
		{
			/*$requestBody = $app->request->getBody();
			$requestBody = DecodeBody($requestBody);
			$requestJson = json_decode($requestBody);*/

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("OldStatus", "NewStatus", "ProducerId", "ConsumerId"));

			if ($requestJson->OldStatus != "0" 
				&& $requestJson->OldStatus != "1"
				&& $requestJson->OldStatus != "2")
			{
				throw new OrderException("Invalid old status, id:" . $OrderId);;
			}

			if ($requestJson->NewStatus != "0" 
				&& $requestJson->NewStatus != "1"
				&& $requestJson->NewStatus != "2")
			{
				throw new OrderException("Invalid new status, id:" . $OrderId);;
			}

			# 检查订单存在
			$order = R::getRow('SELECT id FROM orders WHERE id = ? AND consumerid = ? AND status = ? LIMIT 1', array($OrderId, $requestJson->ConsumerId, $requestJson->OldStatus));
			if (!isset($order) || empty($order))
			{
				throw new RecordNotFoundException("Record not found, id:" . $OrderId);
			}
			
			if ($requestJson->OldStatus == $requestJson->NewStatus)
			{
				throw new OrderException("Old status is the same as new status, id:" . $OrderId);
			}

			# 已确认的订单不能取消
			if ($requestJson->OldStatus == "1" && $requestJson->NewStatus == "2")
			{
				throw new OrderException("Cannot cancel the confirmed order, id:" . $OrderId);
			}

			# 订单确认功能 仅农场主可调用
			if ($requestJson->NewStatus == "1")
			{
				$order = R::getRow('SELECT a.id FROM orders a JOIN product b ON a.productid = b.id WHERE b.producerid=? LIMIT 1', array($requestJson->ProducerId));
				if (!isset($order) || empty($order))
				{
					throw new RecordNotFoundException("The order can only be confirmed by owner, id:" . $OrderId);
				}
			}		

			$order = R::findOne('orders', 'id=?', array($OrderId));
			$order->status = $requestJson->NewStatus;
			$order->lastmodifiedtime = now();
			R::store($order);

			$response = R::find('orders', 'id=?', array($OrderId));
			//echo json_encode(R::exportAll($response));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function post_Consignee($ConsumerId)
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Name", "Telephone", "Address", "IsDefault"));

			$obj = R::dispense('consignee');
			$obj->consumerid = $ConsumerId;
			$obj->name           = $requestJson->Name;
			$obj->telephone      = $requestJson->Telephone;
			$obj->address        = $requestJson->Address;
			$obj->isdefault      = $requestJson->IsDefault;
			$obj->lastmodifiedtime = now();
			$id = R::store($obj);

			if ($requestJson->IsDefault == "true")
			{
				R::exec( 'UPDATE consignee SET isdefault = "false" WHERE id <> ?', array($id));
			}

			$response = R::find('consignee', 'id=?', array($id));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function put_Consignee($ConsigneeId)
	{
		try
		{
			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("Name", "Telephone", "Address", "IsDefault"));

			$obj = R::findOne('consignee', 'id=?', array($ConsigneeId));
			if (!isset($obj) || empty($obj))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsigneeId);
			}

			$obj->name           = $requestJson->Name;
			$obj->telephone      = $requestJson->Telephone;
			$obj->address        = $requestJson->Address;
			$obj->isdefault      = $requestJson->IsDefault;
			$obj->lastmodifiedtime = now();
			$id = R::store($obj);

			if ($requestJson->IsDefault == "true")
			{
				R::exec( 'UPDATE consignee SET isdefault = "false" WHERE id <> ?', array($id));
			}

			$response = R::find('consignee', 'id=?', array($id));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));


			/*
			$order = R::findOne('orders', 'id=?', array($OrderId));
			if (!isset($order) || empty($order))
			{
				throw new RecordNotFoundException("Record not found, id:" . $OrderId);
			}

			$order->count = $requestJson->Count;
			$order->unit = $requestJson->Unit;
			$order->description = $requestJson->Description;
			$order->lastmodifiedtime = now();
			R::store($order);

			$response = R::find('orders', 'id=?', array($OrderId));
			//echo json_encode(R::exportAll($response));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
			*/
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_Consignee($ConsigneeId)
	{
		try
		{
			$response = R::findOne('consignee', 'id=?', array($ConsigneeId));
			if (!isset($response) || empty($response))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsigneeId);
			}
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
	
	public function get_ConsumerConsignee($ConsumerId)
	{
		try
		{
			/*$response = R::findOne('consignee', 'consumerid=?', array($ConsumerId));
			if (!isset($response) || empty($response))
			{
				throw new RecordNotFoundException("Record not found, consumerid:" . $ConsumerId);
			}
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));*/

			$records = R::getAll("SELECT * FROM consignee WHERE consumerid = ?", [$ConsumerId]);
			$Count = count($records);
			$List = array();
			foreach ($records as $record)
			{
				$List[] = array('Consignee' => $record);
			}
			sendSuccess(array(
				'Count'       => $Count,
				'List' => $List,
			));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function delete_Consignee($ConsigneeId)
	{
		try
		{
			$record = R::findOne('consignee', 'id=?', array($ConsigneeId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsigneeId);
			}

			R::trash($record);			
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}


	public function getHotExpress()
	{
		//$records = R::getAll("SELECT name, COUNT(name) AS searchcount FROM searchword GROUP BY name ORDER BY searchcount DESC LIMIT ?", array((int)$_GET['limit']));		
		//$Count = count($records);
		$List = array();
		$List[] = array('HotExpress' => array('Name' => 'Shunfeng', 'Website' => 'www.sf-express.com', 'Telephone' => '95338'));
		$List[] = array('HotExpress' => array('Name' => 'Zhongtong', 'Website' => 'www.zto.cn', 'Telephone' => '95311'));
		$List[] = array('HotExpress' => array('Name' => 'Yuantong', 'Website' => 'www.ytoexpress.com', 'Telephone' => '95554'));
		$List[] = array('HotExpress' => array('Name' => 'Shentong', 'Website' => 'www.sto.cn', 'Telephone' => '95543'));
		

		/*foreach ($records as $record)
		{
			$List[] = array('HotSearchWord' => $record);
		}*/						
		sendSuccess(
			array(
				'Count'  => 4,
				'List'   => $List,
			));
	}

}