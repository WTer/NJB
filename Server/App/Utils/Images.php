<?php

class Images 
{
	const IMAGE_STORE_ROOT_PATH = "App/Images/";
	const IMAGE_WEB_ROOT_PATH = "http://182.92.224.165/App/Images/";
	const IMAGE_PARTITION_NUMBER = 17;

	static function GetImagePath($id, $type, $suffix)
	{
		$fileName = md5(time() . $id . "_" . $suffix);
		$storePath = Images::IMAGE_STORE_ROOT_PATH . $type . "/" . Images::Kmod($id) . "/";
		$webPath = Images::IMAGE_WEB_ROOT_PATH . $type . "/" . Images::Kmod($id). "/" . $fileName;

		return array($storePath, $fileName, $webPath);
	}

	static function Kmod($id)
	{
		return intval(fmod(floatval($id), Images::IMAGE_PARTITION_NUMBER));
	}
}
