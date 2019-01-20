<?php
class ControllerIndex extends Controller{
	public function index() {

		$this->model('index');

		global $request;

		$data = array();

		$date = date('Y-m-d');

		$data['date'] = null;

		if(isset($request->get['date'])){
			$date = $request->get['date'];
			$data['date'] = $date;
		}

		$data['products'] = array();

		$products = $this->model->getProducts();

		foreach ($products as $product) {
			$special = $this->model->getProductSpecial($product['id'], $date);
			$special_price = 0;
			$special_id = 0;
			if($special){
				$special_price = $special['price'];
				$special_id = $special['id'];
			}

			$actions = $this->model->getProductActions($product['id']);
			$interval_date = $this->model->getMinMaxDateActionsByProduct($product['id']);

			$start = $month = strtotime($interval_date['min_date']);
			$end = strtotime($interval_date['max_date']);

			$chart = array();

			while($month < $end){
				$d_ = date('Y-m', $month);
				$chart[$d_] = array();
				$month = strtotime("+1 month", $month);
			}
			
			foreach($actions as $action){
				foreach($chart as $key => $date){
					$date_ = date('Y-m-d', strtotime($key));
					if(($date_ >= $action['date_start'] && $date_ <= $action['date_end']) || ($date_ >= $action['date_start'] && is_null($action['date_end']))) {
						$chart[$key][$action['id']] = $action['price'];
					}else{
						$chart[$key][$action['id']] = 0;
					}
				}
			}

			$data['products'][] = array(
				'id' => $product['id'],
				'name' => $product['name'],
				'price' => $product['price'],
				'special_price' => $special_price,
				'special_id' => $special_id,
				'actions' => $actions,
				'chart' => $chart
			);
		}

		$this->view('index', $data);
	}

	public function delAction(){
		$this->model('index');

		global $request;

		$json = array();

		if(isset($request->post['action_id'])){
			$this->model->delAction($request->post['action_id']);
			$json['success'] = true;
		}

		header('Content-Type: application/json');
		echo json_encode($json);
	}

	public function addAction(){
		$this->model('index');

		global $request;

		$json = array();

		if(isset($request->post['product_id'])){
			$action_id = $this->model->addAction($request->post);
			if($action_id){
				$json['action_id'] = $action_id;
				$json['success'] = true;
			}
		}

		header('Content-Type: application/json');
		echo json_encode($json);
	}

	public function getAction(){
		$this->model('index');

		global $request;

		$json = array();

		if(isset($request->post['action_id'])){
			$json = $this->model->getAction($request->post['action_id']);			
		}

		header('Content-Type: application/json');
		echo json_encode($json);
	}

	public function editAction(){
		$this->model('index');

		global $request;

		$json = array();

		if(isset($request->post['id'])){
			$this->model->editAction($request->post['id'], $request->post);
			$json['success'] = true;
		}

		header('Content-Type: application/json');
		echo json_encode($json);
	}

	public function addProduct(){
		$this->model('index');

		global $request;

		$json = array();

		if(isset($request->post)){
			$product_id = $this->model->addProduct($request->post);
			if($product_id){
				$json['product_id'] = $product_id;
				$json['success'] = true;
			}
		}

		header('Content-Type: application/json');
		echo json_encode($json);
	}

	public function delProduct(){
		$this->model('index');

		global $request;

		$json = array();

		if(isset($request->post['product_id'])){
			$this->model->delProduct($request->post['product_id']);
			$json['success'] = true;
		}

		header('Content-Type: application/json');
		echo json_encode($json);
	}
}
