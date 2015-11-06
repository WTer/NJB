<?php

//
// String
//
class String
{
	static function startsWith($haystack, $needle)
	{
		// search backwards starting from haystack length characters from the end
		return $needle === "" || strrpos($haystack, $needle, -strlen($haystack)) !== FALSE;

		//return strpos($str, $needle) === 0;

	}

	static function endsWith($haystack, $needle)
	{
		// search forward starting from end minus needle length characters
		return $needle == "" || (($temp = strlen($haystack) - strlen($needle)) >= 0 && strpos($haystack, $needle, $temp) != FALSE);
	}
}
