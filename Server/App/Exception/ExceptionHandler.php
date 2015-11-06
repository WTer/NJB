<?php

class ExceptionHandler 
{
	static function Response($ex, $app)
	{
		if ($ex instanceof RequestBodyException)
		{
			$app->response->status(400);
			return json_encode(array("RequestBodyException:" . $ex->getMessage()));
		}
		else if ($ex instanceof RecordNotFoundException)
		{
			$app->response->status(404);
			return json_encode(array("RecordNotFoundException:" . $ex->getMessage()));
		}
		else if ($ex instanceof RecordDuplicatedException)
		{
			$app->response->status(409);
			return json_encode(array("RecordDuplicatedException:" . $ex->getMessage()));
		}
		else if (String::startsWith($ex->getMessage(),"SQLSTATE[23000]"))
		{
			$app->response->status(400);
			return json_encode(array("Duplicated record."));
		}
		else
		{
			$app->response->status(500);
			//var_dump($ex->getMessage()); 
			return json_encode(array($ex->getMessage()));
			//return json_encode(array($ex->__toString()));
		}
	}
}
