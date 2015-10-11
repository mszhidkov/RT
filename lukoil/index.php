<?php

// change the following paths if necessary
$yii = dirname(__FILE__).'/../yii/framework/yii.php';
$yii_config = require(dirname(__FILE__).'/protected/config/main.php');
$external_config = require(dirname(__FILE__).'/protected/config/external.php');
require_once($yii);
$config = CMap::mergeArray( $yii_config, $external_config );

// remove the following lines when in production mode
defined('YII_DEBUG') or define('YII_DEBUG',true);
// specify how many levels of call stack should be shown in each log message
defined('YII_TRACE_LEVEL') or define('YII_TRACE_LEVEL',3);
Yii::createWebApplication($config)->run();
