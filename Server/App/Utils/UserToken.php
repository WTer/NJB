<?php

//
// UserToken
//
class UserToken 
{
	static function Create($username, $password)
	{
		//Step1: ���������
		$randomString = UserToken::GetRandomString(32);

		//Step2: �����������û���������
        $tempArray = array($randomString, $username, $password);
        sort($tempArray, SORT_STRING);
        $tempString = implode($tempArray);

		//Step3: ����Token
        $token = sha1($tempString);

		return $token;
	}

	//
	// ����ָ�����ȵ�����ַ���
	//
	static function GetRandomString($length = 32) 
    {
        $chars = "abcdefghijklmnopqrstuvwxyz0123456789";  
        $str ="";
        for ( $i = 0; $i < $length; $i++ )
		{  
            $str.= substr($chars, mt_rand(0, strlen($chars)-1), 1);  
        }  
        return $str;
    }     
}
