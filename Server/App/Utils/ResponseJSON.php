<?php

class ResponseJSON {
    public function  __construct($keyList) {
	$this->keyList = $keyList;
	$this->output = array();
	$this->cur = 0;
    }

    public function __destruct() {
    }

    public function appendData($row) {
	foreach($this->keyList as $idx => $key) {
	    $this->output[$this->cur][$key] = $row[$key];
	}
	$this->cur++;
    }

    public function exportResponse() {
	$message['Count'] = $this->cur;
	$message['List'] = $this->output;
	return json_encode($message, JSON_UNESCAPED_SLASHES);
    }

    private $cur;
    private $keyList;
    private $output;
}
