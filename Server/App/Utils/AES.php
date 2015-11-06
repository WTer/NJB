<?php

//
// AES加密/解密类
//
class AES 
{
	//加密密钥
	private static $KEY = "1034567890666450";

	//加密向量
	private static $IV = "1034567890123450";

	//加密方式
	private static $CIPHER_ALG = MCRYPT_RIJNDAEL_128;

	//
	//AES加密
	//$str : 要加密的字符串
	//
	static function Encrypt($str)
	{
		$encrypted_string= base64_encode(bin2hex(mcrypt_encrypt(self::$CIPHER_ALG, self::$KEY, $str, MCRYPT_MODE_CBC, self::$IV)));
		return $encrypted_string;
	}

	//
	//AES解密
	//$str : 要解密的字符串
	//
	static function Decrypt($str)
	{  
		$str= base64_decode($str);
		$encrypted = pack('H*', $str);
		return mcrypt_decrypt(MCRYPT_RIJNDAEL_128, self::$KEY, $encrypted, MCRYPT_MODE_CBC, self::$IV);
	}
}
