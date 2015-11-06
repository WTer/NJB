<?php
class SMS 
{
	//主帐号
	const AccountSid = "8a48b55150b86ee80150c3f801f6206c";

	//主帐号Token
	const AccountToken = "8f88c2f4d6c7439897a1068874ac04f6";

	//应用Id
	const AppId = "8a48b55150b86ee80150c3fad1022076";

	//请求地址，格式如下，不需要写https://
	const ServerIP = "sandboxapp.cloopen.com";

	//请求端口
	const ServerPort='8883';

	//REST版本号
	const ApiVersion='2013-12-26';

	 /*
	  * 发送模板短信
	  * @param to 手机号码集合,用英文逗号分开
	  * @param datas 内容数据 格式为数组 例如：array('Marry','Alon')，如不需替换请填 null
	  * @param $tempId 模板Id
	  */       
	static function SendTemplateSMS($to, $datas, $tempId)
	{
		//var_dump($to, $datas, $tempId);

		// 初始化REST SDK
		$rest = new REST(SMS::ServerIP, SMS::ServerPort, SMS::ApiVersion);
		//echo 'new rest done' . "\r\n";
		$rest->setAccount(SMS::AccountSid, SMS::AccountToken);
		//echo 'setAccount done' . "\r\n";
		$rest->setAppId(SMS::AppId);

		//var_dump($to, $datas, $tempId);

		// 发送模板短信
		$result = $rest->sendTemplateSMS($to, $datas, $tempId);
		if($result == NULL)
		{
			throw new SmsException("Failed to send SMS.");
		}

		if($result->statusCode != 0)
		{
			throw new SmsException("Got error response from SMS server, code:" . $result->statusCode . ", message:" . $result->statusMsg);
		}
		else
		{
			// 获取返回信息
			$smsMessage = $result->TemplateSMS;
			return array($result->statusCode, $smsMessage->smsMessageSid, $smsMessage->dateCreated);
		}
	}
}
?>
