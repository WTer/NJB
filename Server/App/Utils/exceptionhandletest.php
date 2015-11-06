<?php
//exceptionHandle.php xiecongwen 20140620
//define('DEBUG',true);
/**
* Display all errors when APPLICATION_ENV is development.
*/
if (defined('DEBUG')) {
error_reporting(E_ALL);
ini_set("display_errors", 1);
}
if(!defined('DEBUG')){
/**
* 当发生重大错误时 写日志 并友好提示用户
* (PS:只所以将代码写在这里,是因为在其他地方注册时,出现问题无法调用配置函数.待完善...)
*/
function shutdownHandler()
{
/**
* 写日志 此处直接写在根目录下shutdownlog.txt
*/
$lasterror = error_get_last();
if($lasterror){
$error = strval(date("Y-m-d h:i:s")).'=>'."[SHUTDOWN] lvl:" . $lasterror['type'] . " | msg:" . $lasterror['message'] . " | file:" . $lasterror['file'] . " | ln:" . $lasterror['line']."\n";
file_put_contents('./log/'.date("Ymd").'shutdownlog.txt',$error,FILE_APPEND);
//友好提示用户
ob_end_clean();
die('对不起,我出错了！');
}
}
register_shutdown_function('shutdownHandler');
}
if(!defined('DEBUG')){
  
function errorHandler($errno, $errstr = '', $errfile = '', $errline = 0)
{
//写日志
$exception = new \ErrorException($errstr, 0, $errno, $errfile, $errline);
$msg = strval(date("Y-m-d h:i:s")).'=>'.'Type:'.getErrTypeName($errno).' '.getMsg($exception);
file_put_contents('./log/'.date("Ymd").'error.txt',$msg,FILE_APPEND);
switch ($errno)
{
case E_NOTICE:return ;
case E_DEPRECATED:return;
}
throw $exception;
}
function getErrTypeName($errno)
{
switch ($errno)
{
case E_NOTICE:return 'E_NOTICE' ;
case E_DEPRECATED:return 'E_DEPRECATED';
default:return $errno;
}
}
function exceptionHandler($ex)
{
$msg = strval(date("Y-m-d h:i:s")).'=>'.getMsg($ex);
file_put_contents('./log/'.date("Ymd").'exception.txt',$msg,FILE_APPEND);
}
function getMsg($exception)
{
//获取最准确的异常 
while($exception->getPrevious())$exception = $exception->getPrevious();
$msg = ' Message: '.$exception->getMessage();
$msg .= ' File: '.$exception->getFile().':'.$exception->getLine()."\n";
return $msg;
}
set_error_handler('errorHandler',E_ALL);
set_exception_handler('exceptionHandler');
}
?>