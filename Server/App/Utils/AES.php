<?php

//
// AES����/������
//
class AES 
{
	//������Կ
	private static $KEY = "1034567890666450";

	//��������
	private static $IV = "1034567890123450";

	//���ܷ�ʽ
	private static $CIPHER_ALG = MCRYPT_RIJNDAEL_128;

	//
	//AES����
	//$str : Ҫ���ܵ��ַ���
	//
	static function Encrypt($str)
	{
		$encrypted_string= base64_encode(bin2hex(mcrypt_encrypt(self::$CIPHER_ALG, self::$KEY, $str, MCRYPT_MODE_CBC, self::$IV)));
		return $encrypted_string;
	}

	//
	//AES����
	//$str : Ҫ���ܵ��ַ���
	//
	static function Decrypt($str)
	{  
		$str= base64_decode($str);
		$encrypted = pack('H*', $str);
		return mcrypt_decrypt(MCRYPT_RIJNDAEL_128, self::$KEY, $encrypted, MCRYPT_MODE_CBC, self::$IV);
	}
}
