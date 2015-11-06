<?php

class ProductComment 
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
			/*$requestBody = $app->request->getBody();
			$requestJson = json_decode($requestBody, true);*/

			$requestJson = RequestBodyHandler::getJsonBody($this->_app);
			RequestBodyHandler::verifyJsonBody($requestJson, array("ProductId", "Comment", "ConsumerId"));			

			$obj = R::dispense('productcomment');
			$obj->productid        = $requestJson->ProductId;
			$obj->comment          = $requestJson->Comment;
			$obj->consumerid       = $requestJson->ConsumerId;
			$obj->lastmodifiedtime = now();
			$id = R::store($obj);

			$response = R::find('productcomment', 'id=?', array($id));
			echo ResponseJsonHandler::normalizeJsonResponse(R::exportAll($response));

			//sendSuccess(json_encode(R::exportAll($obj)), 201);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getCount($ProductId)
	{
		try
		{
			$res = R::getRow("SELECT COUNT(*) AS cnt FROM productcomment WHERE productid = ?", [$ProductId]);
			sendSuccess(array(
				'Count' => $res['cnt'],
			));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getList($ProductId)
	{
		try
		{
			//SELECT a.id, a.comment, a.lastmodifiedtime, b.displayname, b.smallportraiturl FROM productcomment a JOIN consumer b ON a.consumerid = b.id WHERE
			//$records = R::getAll("SELECT id, comment, consumerid, lastmodifiedtime FROM productcomment WHERE productid = ? LIMIT ?,?", [$ProductId, (int)$_GET['offset'], (int)$_GET['limit']]);
			$records = R::getAll("SELECT a.id, a.comment, a.lastmodifiedtime, b.displayname, b.smallportraiturl FROM productcomment a JOIN consumer b ON a.consumerid = b.id WHERE a.productid = ? ORDER BY a.id DESC LIMIT ?,?", [$ProductId, (int)$_GET['offset'], (int)$_GET['limit']]);

			$Count = count($records);
			$CommentList = array();
			foreach ($records as $record)
			{
				$CommentList[] = $record;//array('Id' => $record['id']);
			}
			sendSuccess(array(
				'Count'       => $Count,
				'List' => $CommentList,
			));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	//
	public function getUserCommentList($ConsumerId)
	{
		try
		{
			//SELECT a.id, a.comment, a.lastmodifiedtime, b.displayname, b.smallportraiturl FROM productcomment a JOIN consumer b ON a.consumerid = b.id WHERE
			//$records = R::getAll("SELECT id, comment, consumerid, lastmodifiedtime FROM productcomment WHERE productid = ? LIMIT ?,?", [$ProductId, (int)$_GET['offset'], (int)$_GET['limit']]);
			$records = R::getAll("SELECT a.id, a.comment, a.lastmodifiedtime AS commenttime, b.id AS productid, b.name, b.description, b.type, b.price, b.originalprice, b.unit, b.freight, b.lastmodifiedtime FROM productcomment a JOIN product b ON a.productid = b.id WHERE consumerid = ? ORDER BY a.id DESC LIMIT ?,?", [$ConsumerId, (int)$_GET['offset'], (int)$_GET['limit']]);

			$Count = count($records);
			$CommentList = array();
			foreach ($records as $record)
			{
				$prodcutImageDetail = R::getRow('SELECT id, bigportraiturl, smallportraiturl FROM productimage WHERE productid=? LIMIT 1', array($record['productid']));
				$CommentList[] = array('CommentInfo' => $record, 'ProductImage' => $prodcutImageDetail);
			}
			sendSuccess(array(
				'Count'       => $Count,
				'List' => $CommentList,
			));
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function getCommentId($CommentId)
	{
		try
		{
			$record = R::getRow("SELECT * FROM productcomment WHERE id = ?", [$CommentId]);
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $CommentId);
			}

			echo ResponseJsonHandler::normalizeJsonResponse($record);			

			//sendSuccess($record);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}

	public function delete($CommentId)
	{
		try
		{
			$record = R::findOne('productcomment', 'id=?', array($CommentId));
			if (!isset($record) || empty($record))
			{
				throw new RecordNotFoundException("Record not found, id:" . $CommentId);
			}

			R::trash($record);
			//sendSuccess(null, 204);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}


	public function getConsumerCommentCount($ConsumerId)
	{
		try
		{
			$OrderCount = R::getRow('SELECT COUNT(id) AS totalCount FROM productcomment WHERE consumerid=?', [$ConsumerId]);
			//var_dump($OrderCount);
			echo ResponseJsonHandler::normalizeJsonResponse($OrderCount);
		}
		catch (Exception $ex)
		{
			return ExceptionHandler::Response($ex, $this->_app);
		}
	}
}