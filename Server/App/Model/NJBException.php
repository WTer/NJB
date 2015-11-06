<?php
class NJBException1 extends Exception
{
	public function errorMessage()
	{
		//error message
		$errorMsg = $this->getMessage();
		return $errorMsg;
	}
}

class DBException1 extends NJBException1
{
	public function errorMessage()
	{
		//error message
		$errorMsg = $this->getMessage().' is not a valid E-Mail address.';
		return $errorMsg;
	}
}

function UnhandledException($ex)
{
	echo "UnhandledException:" , $ex->getMessage();
}
