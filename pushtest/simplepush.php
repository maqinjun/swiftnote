<?php

// Put your device token here (without spaces):
//$deviceToken = '0f744707bebcf74f9b7c25d48e3358945f6aa01da5ddb387462c7eaf61bbad78';
//$deviceToken = '1cda236718a54ce2581fac14927e006557917ff963e1660e3a37ed77aed0b7fa6';
//$deviceToken = '842a6970011e63ae3c58dd78d9d4a719200a74b58d67ab53a5245ed7c29ddfa4';
//$deviceToken = '98ff06cd1de372f7efd6e1eb76330a7ada8b4c574ca81e433cc481de93455806';
//我的个人手机
$deviceToken = 'f8d088c9a3c6691ddcac505170279b0a6a787949b1089a49493c6c0ff3b0112b';
//公司测试机+
//$deviceToken = '3a7012a348e8f5d75e37e8aa35fc575e0d1b0ef2817ee6fcdb8adb6676a30c31';
//4s 
//$deviceToken = 'd6e521ec642046f26f6ea339d0a41f35f9a7527ab3bfc7fa1929916a0968a274';
// Put your private key's passphrase here:
$passphrase = 'pushchat';

// Put your alert message here:
$message = 'My first push notification!';

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'Push.pem');
//stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
	'ssl://gateway.sandbox.push.apple.com:2195', $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
/*

    NotifPushEventDevUpdate = 1,
    NotifPushEventDevEraseEMM = 5,
    NotifPushEventDevLost = 7,
    //应用黑白名单，必装应用
    NotifPushEventAppRule = 20,
    //设备定位
    NotifPushEventLocationUpdate = 21

*/
$body['aps'] = array(
	'alert' => $message,
	'sound' => 'sound.caf',
        'event' => '5',
        'badge' => 1,
//	'content-available' => 1
	);
$body['taskId'] = '123';
$body['type'] = '2';
$body['eraseType'] = '1';
$body['blackList'] = array(['name' => 'black app name 1',
			   'icon' => 'black app icon url',
			   'size' => 'black app size',
			   'appId' => 'com.uusafe.emm.ios',
			   'version' => 'black app version']);

$body['whiteList'] = array(['name' => 'white app name 1',
			   'icon' => 'white app icon url',
			   'size' => 'white app size',
			   'appId' => 'com.uusafe.emm.ios',
			   'version' => 'white app version'],
			   ['name' => 'white app name 1',
			   'icon' => 'white app icon url',
			   'size' => 'white app size',
			   'appId' => 'com.ios.white.test',
			   'version' => 'white app version']
			   );

$body['mustList'] = array(['name' => 'must app name 1',
			   'icon' => 'must app icon url',
			   'size' => 'must app size',
			   'appId' => 'com.id.must.test',
			   'version' => 'must app version']);
// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));
#$result = fwrite($fp, $payload, strlen($payload));
if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);

echo $result . PHP_EOL;
