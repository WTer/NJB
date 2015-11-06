<?php

class RequestJSON 
{
    public function __construct($request)
	{
	$request = urldecode($request);
	if (substr($request, 0, 1) == "=")
    {
		$request = substr($request,1);
	}

	$requestArray = json_decode($request, true);

	$this->count = $requestArray['Count'];
	$this->rows = $requestArray['List'];

	$this->cur = 0;
    }

    public function __destruct() {
    }

    public function getNext() {
	if ($this->cur >= $this->count) {
	    return array();
	}
	return $this->rows[$this->cur++];
    }

    private $count;
    private $cur;
    private $rows;
}
