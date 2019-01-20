<?php

error_reporting(E_ALL);

require_once('system/mPDO.php');
require_once('system/request.php');
require_once('system/action.php');
require_once('system/controller.php');

$request = new Request();

$action = new Action($request->getRoute());

$action->start();