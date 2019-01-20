<!DOCTYPE html>
<html dir="ltr" lang="uk">
<head>
	<meta charset="UTF-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="  crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						Форма для теста по дате
					</div>
					<div class="card card-body">
						<form action="index.php" method="get">
							<div class="form-group">
								<label for="date_test">Дата</label>
								<input type="date" name="date" value="<?php echo $date; ?>" class="form-control" id="date_test">
							</div>
							<button type="submit" class="btn btn-primary">Установить</button>
						</form>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div class="card">
					<div class="card-header">Управление товарами/Акции</div>
					<div class="card-body">
						<div class="btn-group" role="group" aria-label="Добавить Товар">
							<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseProduct" aria-expanded="false" aria-controls="collapseProduct">Добавить Товар</button>
						</div>
						<div class="collapse" id="collapseProduct">
							<div class="card card-body">
								<form action="index.php?route=addProduct" class="productFrom needs-validation" novalidate">
									<div class="form-group">
										<label>Наименование</label>
										<input required type="text" class="form-control" name="name" placeholder="Наименование">
									</div>
									<div class="form-group">
										<label>Цена</label>
										<input required type="text" class="form-control" name="price" placeholder="Цена">
									</div>
									<button type="button" class="btn btn-primary btn-product-add">Добавить</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<?php foreach($products as $product){ ?>
				<div class="col-12">
					<div class="card" id="product<?php echo $product['id']; ?>">
						<div class="card-header">
							<a data-toggle="collapse" href="#collapseProduct<?php echo $product['id']; ?>" role="button" aria-expanded="false" aria-controls="collapseProduct<?php echo $product['id']; ?>">#<?php echo $product['id']; ?> <?php echo $product['name']; ?> - Цена: <?php echo $product['price']; ?> руб.
								Текущая цена (с учетом скидки): <?php echo $product['special_price']; ?> руб.
							</a>
							<div class="btn-group float-right" role="group" aria-label="Удалить">
								<button type="button" data-product-id="<?php echo $product['id']; ?>" class="btn btn-danger btn-product-del">Удалить</button>
							</div>
						</div>
						<div class="card-body collapse" id="collapseProduct<?php echo $product['id']; ?>">
							<nav class="navbar navbar-light bg-light">
	  							Акции
	  							<div class="btn-group float-right" role="group" aria-label="Изменить">
									<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseAction<?php echo $product['id']; ?>" aria-expanded="false" aria-controls="collapseAction<?php echo $product['id']; ?>">Добавить</button>
								</div>
							</nav>
							<div class="collapse" id="collapseAction<?php echo $product['id']; ?>">
								<div class="card card-body">
									<form action="index.php?route=addAction" class="actionFrom needs-validation" novalidate">
										<input class="product" name="product_id" value="<?php echo $product['id']; ?>" type="hidden" />
										<div class="form-group">
											<label>Дата старта</label>
											<input required type="date" class="form-control" name="date_start" placeholder="Дата старта">
										</div>
										<div class="form-group">
											<label>Дата окончания</label>
											<input type="date" class="form-control" name="date_end" placeholder="Дата окончания">
										</div>
										<div class="form-group">
											<label>Цена</label>
											<input required type="text" class="form-control" name="price" placeholder="Цена">
										</div>
										<button type="button" class="btn btn-primary">Добавить</button>
									</form>
								</div>
							</div>
							
							<table class="table">
								<thead>
									<tr>
										<th scope="col">Дата добавления</th>
										<th scope="col">Дата начала</th>
										<th scope="col">Дата окончания</th>
										<th scope="col">Цена</th>
										<th></th>
									</tr>
								</thead>
								<?php foreach($product['actions'] as $action){ ?>
									<tbody <?php if ($action['id'] == $product['special_id']){ ?>class="text-white bg-success"<?php } ?> id="action<?php echo $action['id']; ?>">
										<td><?php echo $action['date_added']; ?></td>
										<td class="date_start"><?php echo $action['date_start']; ?></td>
										<td class="date_end"><?php echo $action['date_end']; ?></td>
										<td class="price"><?php echo $action['price']; ?></td>
										<td>
											<div class="btn-group float-right" role="group">
												<button data-action-id="<?php echo $action['id']; ?>" type="button" class="btn btn-info" data-toggle="modal" data-target="#actionModal">Изменить</button>
												<button data-action-id="<?php echo $action['id']; ?>" type="button" class="btn btn-danger btn-action-del">Удалить</button>
											</div>
										</td>
									</tbody>
								<?php } ?>
								<tfoot></tfoot>
							</table>
							<div id="chart_div<?php echo $action['id']; ?>" style="width: 100%; height: 500px;"></div>
							<script type="text/javascript">
								$(document).ready(function(){
									google.charts.setOnLoadCallback(function(){

										var data_google = [];
										var data_google_head = [];
										data_google_head.push('Месяц');
										
										<?php foreach ($product['actions'] as $key => $value){ ?>
											data_google_head.push('<?php echo $value['id']; ?>');
										<?php } ?>

										var data = google.visualization.arrayToDataTable([
											data_google_head,
											<?php foreach ($product['chart'] as $key => $value){ ?>
												["<?php echo $key; ?>", <?php $coma = 1; foreach ($value as $v){ ?><?php echo $v; ?> <?php if($coma < count($value)){ ?>,<?php } ?><?php $coma++; } ?>],
											<?php } ?>
										]);

										var options = {
											title: 'Акция',
											hAxis: {title: 'Месяц',  titleTextStyle: {color: '#333'}},
											vAxis: {minValue: 0}
										};

										var chart = new google.visualization.AreaChart(document.getElementById('chart_div<?php echo $action['id']; ?>'));
										chart.draw(data, options);

									});
								});
							</script>
						</div>
					</div>
				</div>
			<?php } ?>
		</div>
	</div>
<div class="modal fade" id="actionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Изменение акции</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="index.php?route=editAction" class="actionFrom needs-validation" novalidate>
					<input class="product" name="product_id" value="" type="hidden" />
					<input class="id" name="id" value="" type="hidden" />
					<div class="form-group">
						<label>Дата старта</label>
						<input required type="date" class="date_start form-control" name="date_start" placeholder="Дата старта">
					</div>
					<div class="form-group">
						<label>Дата окончания</label>
						<input type="date" class="date_end form-control" name="date_end" placeholder="Дата окончания">
					</div>
					<div class="form-group">
						<label>Цена</label>
						<input required type="text" class="price form-control" name="price" placeholder="Цена">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
				<button type="button" class="btn-action-edit btn btn-primary">Сохранить</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).delegate('.btn-action-del', 'click', function() {
	var action_id = $(this).data('action-id');
	$.ajax({
		url: 'index.php?route=delAction',
		type: 'post',
		data: 'action_id=' + action_id,
		dataType: 'json',
		beforeSend: function() {
			$('.alert').remove();
		},
		success: function(json) {
			if (json['success']) {
				$('#action'+action_id).before('<div class="alert alert-success" role="alert">Акция удалили.</div>');
				$('#action'+action_id).remove();
			}
		}
	});
});
$(document).delegate('.btn-action-edit', 'click', function() {
	var action_id = $('#actionModal form .id').val();
	var product_id = $('#actionModal form .product').val();
	$.ajax({
		url: 'index.php?route=editAction',
		type: 'post',
		data: $('#actionModal .actionFrom').serialize(),
		dataType: 'json',
		beforeSend: function() {
			$('.alert').remove();
		},
		success: function(json) {
			if (json['success']) {
				$('#collapseAction'+product_id).before('<div class="alert alert-success" role="alert">Акция изменили.</div>');
				$('#actionModal').modal('hide');
				$.ajax({
					url: 'index.php?route=getAction',
					type: 'post',
					data: 'action_id=' + action_id,
					dataType: 'json',
					success: function(json) {
						$('#action'+action_id).find('.price').html(json['price']);
						$('#action'+action_id).find('.date_start').html(json['date_start']);
						$('#action'+action_id).find('.date_end').html(json['date_end']);
					}
				});
			}
		}
	});
});
$(document).delegate('.actionFrom button', 'click', function() {
	var form = $(this).parent();
	if (form[0].checkValidity() === true) {
		var product_id = form.find('.product').val();
		$.ajax({
			url: form.attr('action'),
			type: 'post',
			data: form.serialize(),
			dataType: 'json',
			beforeSend: function() {
				$('.alert').remove();
			},
			success: function(json) {
				if (json['success']) {
					$('#collapseAction'+product_id).removeClass('show');
					$('#collapseAction'+product_id).before('<div class="alert alert-success" role="alert">Акция добавили.</div>');
					var action_id =json['action_id'];
					$.ajax({
						url: 'index.php?route=getAction',
						type: 'post',
						data: 'action_id=' + action_id,
						dataType: 'json',
						success: function(ajax) {
							var html = '';
							html += '<tbody id="action'+action_id+'">';
							html += '<td>'+ajax['date_added']+'</td>';
							html += '<td class="date_start">'+ajax['date_start']+'</td>';
							html += '<td class="date_end">'+ajax['date_end']+'</td>';
							html += '<td class="price">'+ajax['price']+'</td>';
							html += '<td>';
							html += '<div class="btn-group float-right" role="group">';
							html += '<button data-action-id="'+action_id+'" type="button" class="btn btn-info" data-toggle="modal" data-target="#actionModal">Изменить</button>';
							html += '<button data-action-id="'+action_id+'" type="button" class="btn btn-danger btn-action-del">Удалить</button>';
							html += '</div>';
							html += '</td>';
							html += '</tbody>';
							$('#product'+product_id+' tfoot').before(html);
						}
					});
				}
			}
		});
	}else{
		form.addClass('was-validated');
	}
});
$(document).delegate('.productFrom button', 'click', function() {
	var form = $(this).parent();
	if (form[0].checkValidity() === true) {
		$.ajax({
			url: form.attr('action'),
			type: 'post',
			data: form.serialize(),
			dataType: 'json',
			beforeSend: function() {
				$('.alert').remove();
			},
			success: function(json) {
				if (json['success']) {
					location.reload();
				}
			}
		});
	}else{
		form.addClass('was-validated');
	}
});
$('#actionModal').on('show.bs.modal', function (event) {
	var button = $(event.relatedTarget);
	var action_id = button.data('action-id');
	$.ajax({
		url: 'index.php?route=getAction',
		type: 'post',
		data: 'action_id=' + action_id,
		dataType: 'json',
		beforeSend: function() {
			$('.alert').remove();
		},
		success: function(json) {
			$('#actionModal form .product').val(json['product_id']);
			$('#actionModal form .price').val(json['price']);
			$('#actionModal form .date_start').val(json['date_start']);
			$('#actionModal form .date_end').val(json['date_end']);
			$('#actionModal form .id').val(json['id']);
		}
	});
});
$(document).delegate('.btn-product-del', 'click', function() {
	var product_id = $(this).data('product-id');
	$.ajax({
		url: 'index.php?route=delProduct',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		beforeSend: function() {
			$('.alert').remove();
		},
		success: function(json) {
			if (json['success']) {
				$('#product'+product_id).parent().before('<div class="alert alert-success" role="alert">Товар удалили.</div>');
				$('#product'+product_id).parent().remove();
			}
		}
	});
});
</script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['corechart']});
</script>
</body>
</html>