<?php

class RequestBodyHandler
{
	static function getJsonBody($app)
	{
		try
		{
			$requestBody = $app->request->getBody();
			//echo "==================0000" . $requestBody . "\r\n\r\n";
			//$requestBody = DecodeBody($requestBody);
			//$requestBody = html_entity_decode(htmlentities($requestBody." ", ENT_COMPAT, 'UTF-8'));
			
			$requestBody = urldecode($requestBody);
			if (substr($requestBody, 0, 1) == "=")
			{
				$requestBody = substr($requestBody,1);
			}
			//echo "==================111" . $requestBody . "\r\n\r\n";


			$requestJson = json_decode($requestBody);

			//throw new Exception("getJsonBody");

			return $requestJson;
		}
		catch (Exception $ex)
		{
			throw new RequestBodyException($ex->getMessage());
		}
	}

	static function verifyJsonBody($requestJson, $fieldArray)
	{
		
		//NULL/empty checking
		$jsonFieldList = "";
		foreach($requestJson as $key => $value)
		{
			if (empty($value) && $value != "0")
			{
				throw new RequestBodyException("The value of field $key is empty.");
			}
			//if (!in_array($key,  $arr);)
			if (empty($jsonFieldList))
			{
				$jsonFieldList = $key;
			}
			else
			{
				$jsonFieldList .= "," . $key;
			}
		}

		//Unknown/missing field checking
		$requestJsonArray = explode(",", $jsonFieldList);
		foreach ($requestJsonArray as $field)
		{
			if (!in_array($field, $fieldArray))
			{
				throw new RequestBodyException("Unknown field " .$field." in request body.");
			}
		}

		foreach ($fieldArray as $field)
		{
			if (!in_array($field, $requestJsonArray))
			{
				throw new RequestBodyException("Field $field is missing in request body.");
			}
		}
    }
}
