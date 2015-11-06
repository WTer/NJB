<?php

//
// UserToken
//
class UserToken 
{
	static function Create($username, $password)
	{
		//Step1: 生成随机串
		$randomString = UserToken::GetRandomString(32);

		//Step2: 组合随机串，用户名和密码
        $tempArray = array($randomString, $username, $password);
        sort($tempArray, SORT_STRING);
        $tempString = implode($tempArray);

		//Step3: 生成Token
        $token = sha1($tempString);

		return $token;
	}

	//
	// 生成指定长度的随机字符串
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
