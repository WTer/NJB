<?php

class ExceptionHandler 
{
	static function Response($ex, $app)
	{
		//var_dump($ex->getMessage());

		if ($ex instanceof RequestBodyException)
		{
			$app->response->status(400);
			return json_encode(array("error" => "用户输入错误"));
		}
		else if ($ex instanceof RecordNotFoundException)
		{
			//echo '404================';
			$app->response->status(404);
			//return json_encode(array("RecordNotFoundException:" . $ex->getMessage()));
			//$xx=array("url_list"=>$data);
			//return json_encode(array("error" => "RecordNotFoundException:" . $ex->getMessage()));
			return json_encode(array("error" => "用户或记录不存在"));
		}
		else if ($ex instanceof RecordDuplicatedException)
		{
			$app->response->status(409);
			return json_encode(array("error" => "重复记录输入"));
		}
		else if ($ex instanceof OrderException)
		{
			$app->response->status(400);
			return json_encode(array("error" => "订单出错了"));
		}
		else if ($ex instanceof SmsException)
		{
			$app->response->status(500);
			return json_encode(array("error" => "发送或认证短信验证码失败"));
		}
		else if (String::startsWith($ex->getMessage(),"SQLSTATE[23000]"))
		{
			if (String::startsWith($ex->getMessage(),"SQLSTATE[23000]: Integrity constraint violation: 1452"))
			{
				$app->response->status(404);
				return json_encode(array("error" => "记录不存在."));
			}
			else if (String::startsWith($ex->getMessage(),"SQLSTATE[23000]: Integrity constraint violation: 1062"))
			{
				$app->response->status(400);
				return json_encode(array("error" => "重复数据或记录"));
			}
			else
			{
				$app->response->status(500);
				return json_encode(array("error" => "数据库出错了."));
			}
		}
		else
		{
			$app->response->status(500);
			return json_encode(array("error" => "系统未知错误"));
			//return json_encode(array($ex->__toString()));
		}
	}
}
