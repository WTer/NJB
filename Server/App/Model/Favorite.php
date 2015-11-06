<?php

class Favorite 
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

	public function post_ProducerId_ProductId($ProducerId, $ProductId)
	{
		try
		{
			$product = R::dispense('producerfavoriteproduct');
			$product->producerid = $ProducerId;
			$product->productid = $ProductId;
			$product->lastmodifiedtime = now();
			$id = R::store($product);

			$response = R::find('producerfavoriteproduct', 'id=?', array($id));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
			//$app->response->status(201);
			//echo json_encode(R::exportAll($response));			
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
					"SELECT * "
				  . "FROM producerfavoriteproduct "
				  . "WHERE producerid = ?", [$ProducerId]);*/

			$records = R::getAll("SELECT a.id, a.producerid, a.lastmodifiedtime, b.id AS productid, b.name, b.description, b.type FROM producerfavoriteproduct a JOIN product b ON a.productid = b.id WHERE a.producerid = ? ORDER BY a.id DESC LIMIT ?,?", [$ProducerId, (int)$_GET['offset'], (int)$_GET['limit']]);

			$Count = count($records);
			$List = array();
			foreach ($records as $record)
			{
				$prodcutImageDetail = R::getRow('SELECT id, bigportraiturl, smallportraiturl FROM productimage WHERE productid=? LIMIT 1', array($record['productid']));
				$List[] = array('FavoriteProductInfo' => $record, 'FavoriteProductImages' => $prodcutImageDetail);
			}
			sendSuccess(array(
				'Count'       => $Count,
				'List' => $List,
			));

			/*
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ProducerId);
			}

			$Count = count($records);
			$OrderList = array();
			foreach ($records as $record)
			{
				$OrderList[] = array('FavoriteId' => $record['id'], 'ProductId' => $record['productid'], 'Time' => $record['lastmodifiedtime']);
			}
			sendSuccess(array(
				'Count' => $Count,
				'List' => $OrderList,
			));*/
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function post_ConsumerId_ProductId($ConsumerId, $ProductId)
	{
		try
		{
			$product = R::dispense('consumerfavoriteproduct');
			$product->consumerid = $ConsumerId;
			$product->productid = $ProductId;
			$product->lastmodifiedtime = now();
			$id = R::store($product);

			$response = R::find('consumerfavoriteproduct', 'id=?', array($id));
			//$app->response->status(201);
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
			/*$records = R::getAll(
					"SELECT * "
				  . "FROM consumerfavoriteproduct "
				  . "WHERE consumerid = ?", [$ConsumerId]);
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			$Count = count($records);
			$OrderList = array();
			foreach ($records as $record)
			{
				$OrderList[] = array('FavoriteId' => $record['id'], 'ProductId' => $record['productid'], 'Time' => $record['lastmodifiedtime']);
			}
			sendSuccess(array(
				'Count' => $Count,
				'List' => $OrderList,
			));	*/

			/*
			"id": "21",
                "producerid": "92",
                "name": "二锅头",
                "description": "TNT二锅头，一杯就上头",
                "type": "烟酒",
                "price": "10.00",
                "originalprice": "15.00",
                "unit": "瓶",
                "freight": "0.00",
                "lastmodifiedtime": "2015-10-28 20:13:49"

			*/
			
			$records = R::getAll("SELECT a.id, a.lastmodifiedtime AS favoritetime, b.id AS productid, b.name, b.description, b.type, b.price, b.originalprice, b.unit, b.freight, b.lastmodifiedtime FROM consumerfavoriteproduct a JOIN product b ON a.productid = b.id WHERE a.consumerid = ? ORDER BY a.id DESC LIMIT ?,?", [$ConsumerId, (int)$_GET['offset'], (int)$_GET['limit']]);

			$Count = count($records);
			$List = array();
			foreach ($records as $record)
			{
				$prodcutImageDetail = R::getRow('SELECT id, description, bigportraiturl, smallportraiturl FROM productimage WHERE productid=? LIMIT 1', array($record['productid']));
				$List[] = array('FavoriteProductInfo' => $record, 'FavoriteProductImages' => $prodcutImageDetail);
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

	public function post_ConsumerId_ProducerId($ConsumerId, $ProducerId)
	{
		try
		{
			$product = R::dispense('consumerfavoriteproducer');
			$product->consumerid = $ConsumerId;
			$product->producerid = $ProducerId;
			$product->lastmodifiedtime = now();
			$id = R::store($product);

			$response = R::find('consumerfavoriteproducer', 'id=?', array($id));
			//$app->response->status(201);
			//echo json_encode(R::exportAll($response));	
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function get_ConsumerId_Producer($ConsumerId)
	{
		try
		{
			$records = R::getAll(
					"SELECT * "
				  . "FROM consumerfavoriteproducer "
				  . "WHERE consumerid = ?", [$ConsumerId]);
			if (!isset($records) || empty($records))
			{
				throw new RecordNotFoundException("Record not found, id:" . $ConsumerId);
			}

			$Count = count($records);
			$OrderList = array();
			foreach ($records as $record)
			{
				$OrderList[] = array('FavoriteId' => $record['id'], 'ProducerId' => $record['producerid'], 'Time' => $record['lastmodifiedtime']);
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

	public function delete_Producer_Product($FavoriteId)
	{
		try
		{
			$record = R::findOne('producerfavoriteproduct', 'id=?', array($FavoriteId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $FavoriteId);
			}

			R::trash($record);			
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function delete_Consumer_Product($FavoriteId)
	{
		try
		{
			$record = R::findOne('consumerfavoriteproduct', 'id=?', array($FavoriteId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $FavoriteId);
			}

			R::trash($record);			
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function delete_Consumer_Producer($FavoriteId)
	{
		try
		{
			$record = R::findOne('consumerfavoriteproducer', 'id=?', array($FavoriteId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $FavoriteId);
			}

			R::trash($record);			
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getProducerFavoriteCount($ProducerId)
	{
		try
		{
			//$OrderCount = R::getRow('SELECT COUNT(a.id) AS totalCount FROM orders a JOIN product b ON a.productid = b.id WHERE b.producerid=?', [$ProducerId]);
			$OrderCount = R::getRow('SELECT COUNT(id) AS totalCount FROM producerfavoriteproduct WHERE producerid=?', [$ProducerId]);
			//var_dump($OrderCount);
			echo ResponseJsonHandler::normalizeJsonResponse($OrderCount);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
	
	public function getConsumerFavoriteCount($ConsumerId)
	{
		try
		{
			$OrderCount = R::getRow('SELECT COUNT(id) AS totalCount FROM consumerfavoriteproduct WHERE consumerid=?', [$ConsumerId]);
			echo ResponseJsonHandler::normalizeJsonResponse($OrderCount);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
}