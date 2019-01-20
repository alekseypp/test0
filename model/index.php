<?php

class ModelIndex{
	
	protected $db;

	public function __construct($db) {
		$this->db = $db;
	}

	public function getProducts(){
		
		$sql = "SELECT * FROM products";

		$query = $this->db->query($sql);
		
		return $query->rows;
	}

	public function getProductActions($id = 0){

		$sql = "SELECT * FROM actions WHERE product_id = '" . (int)$id . "'";

		$query = $this->db->query($sql);
		
		return $query->rows;

	}

	public function getProductSpecial($product_id = 0, $date){

		$sql = "SELECT id, price, DATEDIFF(IF(date_end IS NULL, NOW(), date_end), date_start) AS interval_date FROM actions WHERE product_id = '" . (int)$product_id . "' AND '" . $this->db->escape($date) . "' between date_start and IF(date_end IS NULL, NOW(), date_end) ORDER BY interval_date ASC, date_added DESC";

		$query = $this->db->query($sql);
		
		return $query->row;

	}

	public function delAction($action_id = 0){
		$sql = "DELETE FROM actions WHERE id = '" . (int)$action_id . "'";

		$query = $this->db->query($sql);
	}

	public function addAction($data = array()){
		$sql = "INSERT INTO actions SET product_id = '" . (int)$data['product_id'] . "', date_added = NOW(), date_start = '" . $this->db->escape($data['date_start']) . "', date_end = '" . $this->db->escape($data['date_end']) . "', price = '" . (float)$data['price'] . "'";
		
		$query = $this->db->query($sql);

		return $this->db->getLastId();
	}

	public function editAction($action_id = 0, $data = array()){
		$sql = "UPDATE actions SET date_start = '" . $this->db->escape($data['date_start']) . "', date_end = '" . $this->db->escape($data['date_end']) . "', price = '" . (float)$data['price'] . "' WHERE id = '" . (int)$action_id . "'";
		
		$query = $this->db->query($sql);
	}

	public function getAction($action_id = 0){
		$sql = "SELECT * FROM actions WHERE id = '" . (int)$action_id . "'";

		$query = $this->db->query($sql);

		return $query->row;
	}

	public function addProduct($data = array()){
		$sql = "INSERT INTO products SET name = '" . $this->db->escape($data['name']) . "', price = '" . (float)$data['price'] . "'";
		
		$query = $this->db->query($sql);

		return $this->db->getLastId();
	}

	public function delProduct($product_id = 0){
		$sql = "DELETE FROM products WHERE id = '" . (int)$product_id . "'";

		$query = $this->db->query($sql);
	}

	public function getMinMaxDateActionsByProduct($product_id = 0){
		$sql = "SELECT MIN(date_start) AS min_date , MAX(IF(date_end IS NULL, NOW(), date_end)) as max_date FROM actions WHERE product_id = '" . (int)$product_id . "'";

		$query = $this->db->query($sql);

		return $query->row;
	}

}