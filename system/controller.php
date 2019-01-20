<?php
abstract class Controller {

	protected $model;
	protected $db;

	public function __construct($db) {
		$this->db = $db;
	}

	public function model($model = ''){
		$file = DIR_APPLICATION . 'model/' . $model . '.php';

		if (file_exists($file)) {

			require($file);

			$class = 'Model' . $model;

			$this->model = new $class($this->db);
			
		} else {
			trigger_error('Error');
			exit();
		}
	}
	
	public function view($template = '', $data = array()){

		$file = DIR_APPLICATION . 'view/' . $template . '.tpl';

		if (file_exists($file)) {
			extract($data);

			ob_start();

			require($file);

			$output = ob_get_contents();

			ob_end_clean();
		} else {
			trigger_error('Error');
			exit();
		}
		
		echo $output;
	}
}