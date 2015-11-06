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
* �������ش����ʱ д��־ ���Ѻ���ʾ�û�
* (PS:ֻ���Խ�����д������,����Ϊ�������ط�ע��ʱ,���������޷��������ú���.������...)
*/
function shutdownHandler()
{
/**
* д��־ �˴�ֱ��д�ڸ�Ŀ¼��shutdownlog.txt
*/
$lasterror = error_get_last();
if($lasterror){
$error = strval(date("Y-m-d h:i:s")).'=>'."[SHUTDOWN] lvl:" . $lasterror['type'] . " | msg:" . $lasterror['message'] . " | file:" . $lasterror['file'] . " | ln:" . $lasterror['line']."\n";
file_put_contents('./log/'.date("Ymd").'shutdownlog.txt',$error,FILE_APPEND);
//�Ѻ���ʾ�û�
ob_end_clean();
die('�Բ���,�ҳ����ˣ�');
}
}
register_shutdown_function('shutdownHandler');
}
if(!defined('DEBUG')){
  
function errorHandler($errno, $errstr = '', $errfile = '', $errline = 0)
{
//д��־
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
//��ȡ��׼ȷ���쳣 
while($exception->getPrevious())$exception = $exception->getPrevious();
$msg = ' Message: '.$exception->getMessage();
$msg .= ' File: '.$exception->getFile().':'.$exception->getLine()."\n";
return $msg;
}
set_error_handler('errorHandler',E_ALL);
set_exception_handler('exceptionHandler');
}
?>