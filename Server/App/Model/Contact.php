<?php

class Contact 
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

	public function post_ProducerId_ConsumerId($ProducerId, $ConsumerId)
	{
		try
		{
			$product = R::dispense('producercontactconsumer');
			$product->producerid = $ProducerId;
			$product->consumerid = $ConsumerId;
			$product->lastmodifiedtime = now();
			$id = R::store($product);

			$response = R::find('producercontactconsumer', 'id=?', array($id));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
			//$this->_app->response->status(201);
			//return json_encode(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_ProducerConsumer($ProducerId)
	{
		try
		{
			/*$requestBody = $this->_app->request->getBody();
			$requestBody = DecodeBody($requestBody);
			$requestJson = json_decode($requestBody);*/

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);

			$records = R::getAll(
					"SELECT a.id AS contactid, a.consumerid, a.lastmodifiedtime AS contacttime, b.displayname, b.smallportraiturl, b.province, b.city, b.address, b.telephone "
				  . "FROM producercontactconsumer a "
				  . "JOIN consumer b ON a.consumerid = b.id "
				  . "WHERE producerid = ?", [$ProducerId]);
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			$Count = count($records);
			$List = array();
			foreach ($records as $record)
			{
				$OrderInfo = R::getRow('SELECT a.id AS orderid, a.productid, a.count, a.status, a.lastmodifiedtime AS ordertime, b.name AS productname, b.type, b.price, b.originalprice, b.unit, b.freight FROM orders a JOIN product b ON a.productid = b.id WHERE a.consumerid=? ORDER BY a.id DESC LIMIT 5', array($record['consumerid']));
				$List[] = array('ContactInfo' => $record, 'OrderInfo' => array($OrderInfo));

				//$List[] = array('ContactId' => $record['id'], 'ConsumerId' => $record['consumerid'], 'Time' => $record['lastmodifiedtime']);
			}
			sendSuccess(array(
				'Count' => $Count,
				'List' => $List,
			));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function post_ProducerId_OtherProducerId($ProducerId, $OtherProducerId)
	{
		try
		{
			$product = R::dispense('producercontactproducer');
			$product->producerid = $ProducerId;
			$product->otherproducerid = $OtherProducerId;
			$product->lastmodifiedtime = now();
			$id = R::store($product);

			$response = R::find('producercontactproducer', 'id=?', array($id));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
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
			$records = R::getAll(
					"SELECT * "
				  . "FROM producercontactproducer "
				  . "WHERE producerid = ?", [$ProducerId]);
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			$Count = count($records);
			$OrderList = array();
			foreach ($records as $record)
			{
				$OrderList[] = array('ContactId' => $record['id'], 'ProducerId' => $record['otherproducerid'], 'Time' => $record['lastmodifiedtime']);
			}
			sendSuccess(array(
				'Count' => $Count,
				'List' => $OrderList,
			));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function post_ConsumerId_ProducerId($ConsumerId, $ProducerId)
	{
		try
		{
			$product = R::dispense('consumercontactproducer');
			$product->consumerid = $ConsumerId;
			$product->producerid = $ProducerId;
			$product->lastmodifiedtime = now();
			$id = R::store($product);

			$response = R::find('consumercontactproducer', 'id=?', array($id));
			//$this->_app->response->status(201);
			//echo json_encode(R::exportAll($response));
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
			$records = R::getAll(
					"SELECT a.id AS contactid, a.producerid, a.lastmodifiedtime AS contacttime, b.displayname, b.province, b.city, b.address, b.smallportraiturl, b.telephone "
				  . "FROM consumercontactproducer a "
				  . "JOIN producer b ON a.producerid = b.id "
				  . "WHERE a.consumerid = ?", [$ConsumerId]);

			/*$records = R::getAll(
					"SELECT * "
				  . "FROM consumercontactproducer "
				  . "WHERE consumerid = ?", [$ConsumerId]);*/
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			$Count = count($records);
			$List = array();
			foreach ($records as $record)
			{
				$OrderInfo = R::getRow('SELECT a.id AS orderid, a.productid, a.count, a.status, a.lastmodifiedtime AS ordertime, b.name AS productname, b.type, b.price, b.originalprice, b.unit, b.freight FROM orders a JOIN product b ON a.productid = b.id WHERE b.producerid=? ORDER BY a.id DESC LIMIT 5', array($record['producerid']));
				$List[] = array('ContactInfo' => $record, 'OrderInfo' => array($OrderInfo));

				//$List[] = $record;//array('ContactId' => $record['id'], 'ProducerId' => $record['producerid'], 'Time' => $record['lastmodifiedtime']);
			}
			sendSuccess(array(
				'Count' => $Count,
				'List' => $List,
			));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function delete_producercontactconsumer($ContactId)
	{
		try
		{
			$record = R::findOne('producercontactconsumer', 'id=?', array($ContactId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ContactId);
			}
			
			R::trash($record);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function delete_producercontactproducer($ContactId)
	{
		try
		{
			$record = R::findOne('producercontactproducer', 'id=?', array($ContactId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ContactId);
			}

			R::trash($record);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function delete_consumercontactproducer($ContactId)
	{
		try
		{
			$record = R::findOne('consumercontactproducer', 'id=?', array($ContactId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ContactId);
			}

			R::trash($record);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getProducerContactCount($ProducerId)
	{
		try
		{
			$OrderCount = R::getRow('SELECT COUNT(id) AS totalCount FROM producercontactconsumer WHERE producerid=?', [$ProducerId]);
			echo ResponseJsonHandler::normalizeJsonResponse($OrderCount);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	
	public function getConsumerContactCount($ConsumerId)
	{
		try
		{
			$OrderCount = R::getRow('SELECT COUNT(id) AS totalCount FROM consumercontactproducer WHERE consumerid=?', [$ConsumerId]);
			echo ResponseJsonHandler::normalizeJsonResponse($OrderCount);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
}