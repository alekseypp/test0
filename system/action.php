<?php

class Action {

	private $route = 'index';
	private $method = 'index';
	
	public function __construct($method = '') {

		if($method){
			$this->method = $method;
		}

		$file = DIR_APPLICATION . 'controller/' . $this->route . '.php';

		if (!is_file($file)) {
			return new \Exception('Error');
		}
		
	}

	public function start() {
		
		$file  = DIR_APPLICATION . 'controller/' . $this->route . '.php';	
		$class = 'Controller' . $this->route;

		$db = new mPDO(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);
		
		if (is_file($file)) {
			include_once($file);
		
			$controller = new $class($db);
		} else {
			return new \Exception('Error');
		}

		return call_user_func_array(array($controller, $this->method), array());
	}
}