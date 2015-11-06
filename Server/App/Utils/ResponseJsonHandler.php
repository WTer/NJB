<?php

class ResponseJsonHandler
{
	static function normalizeJsonResponse($response)
	{
		try
		{
			$jsonResponse =  json_encode($response, JSON_UNESCAPED_SLASHES);
			$jsonResponse = str_replace("[", "", $jsonResponse);
			$jsonResponse = str_replace("]", "", $jsonResponse);
			return $jsonResponse;
		}
		catch (Exception $ex)
		{
			throw new RequestBodyException($ex->getMessage());
		}
	}
}
