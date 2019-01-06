<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<header>
	<title>API test</title>
	<link rel="stylesheet"
		href="https://unpkg.com/purecss@1.0.0/build/pure-min.css"
		integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w"
		crossorigin="anonymous">
	<link
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
		rel="stylesheet" />

	<style>
tr {
	cursor: pointer
}

.selected {
	background-color: rgba(0, 0, 0, 0.4) !important;
	color: #fff !important;
}
</style>
</header>
<body>

	<!-- Form confirm action -->
	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#confirmBox">Confirm</button>

	<!-- Modal -->
	<div class="modal fade" id="confirmBox" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Confirm delete
						tracking</h4>
				</div>
				<div class="modal-body">
					<form action="/api/trackings" method="POST">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<div class="form-group">
							<label for="deltrackingNumber" class="control-label">Tracking
								Number*:</label> <input type="text" class="form-control"
								id="deltrackingNumber">
						</div>
						<div class="form-group">
							<label for="delslug" class="control-label">Slug:</label> <select
								id="delslug" name="slug">
								<option value="">--- Select one ---</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						id="deleteBtn">Delete User</button>
				</div>
			</div>
		</div>
	</div>


	<!-- end form confirm -->
	<!-- Form modal https://getbootstrap.com/docs/3.4/javascript/  -->
	<div id="notifyId2" class="" role="alert" style="display: none">This
		is alert...</div>
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#exampleModal" id="addBtn">Add new tracking</button>

	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#exampleModal" id="editBtn">Edit Tracking</button>




	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">New tracking</h4>
				</div>
				<div id="notifyId" class="" role="alert" style="display: none">This
					is alert...</div>
				<div class="modal-body">
					<form action="/api/trackings" method="POST">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<div class="form-group">
							<label for="trackingNumber" class="control-label">Tracking
								Number*:</label> <input type="text" class="form-control"
								id="trackingNumber">
						</div>
						<div class="form-group">
							<label for="slug" class="control-label">Slug:</label> <select
								id="slug" name="slug">
								<option value="">--- Select one ---</option>
							</select>
						</div>
						<div class="form-group">
							<label for="title" class="control-label">Title:</label> <input
								type="text" class="form-control" id="title">
						</div>
						<div class="form-group">
							<label for="orderID" class="control-label">Order ID*:</label> <input
								type="text" class="form-control" id="orderID">
						</div>
						<div class="form-group">
							<label for="customerName" class="control-label">Customer
								Name:</label> <input type="text" class="form-control" id="customerName">
						</div>
						<div class="form-group">
							<label for="emails" class="control-label">Email:</label> <input
								type="email" class="form-control" id="emails">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="addUser">Add
						Tracking</button>
					<button type="button" class="btn btn-primary" id="editUser">Edit
						Tracking</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End form modal -->
	<table class="pure-table pure-table-bordered" id="tableSelected">
		<thead>
			<tr>
				<th>Id</th>
				<th>Tracking Number</th>
				<th>Slug</th>
				<th>Title</th>
				<th>Customer</th>
				<th>Delivery Time</th>
				<th>Destination</th>
				<th>Order Id</th>
				<th>Tag</th>
			</tr>
		</thead>
		<tbody id="tableBody">
			<!-- <tr style="display: none">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>  -->
		</tbody>
	</table>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"
		integrity="sha384-vhJnz1OVIdLktyixHY4Uk3OHEwdQqPppqYR8+5mjsauETgLOcEynD9oPHhhz18Nw"
		crossorigin="anonymous"></script>

	<script>
		$(function() {

			//$("thead").on('click', function() {
			//	$('thead > tr').removeClass('selected');
			//});

			function toggle() {
				$('#addBtn').on('click', function() {
					$('#editUser').hide();
					$('#addUser').show();
				});
				$('#editBtn').on('click', function() {
					$('#editUser').show();
					$('#addUser').hide();
				});
			}
			toggle();

			var $slugList = $('#slug');
			var $delslugList = $('#delslug');

			function listCouriers(c) {
				$slugList.append('<option value="'+c.slug+'"> ' + c.othername
						+ ' </option>');
				$delslugList.append('<option value="'+c.slug+'"> '
						+ c.othername + ' </option>');
			}
			//get courier | slug
			$.ajax({
				type : 'GET',
				url : '/api/couriers',
				success : function(couriers) {
					$.each(couriers, function(i, courier) {
						listCouriers(courier);
					});
				},
				error : function() {
					alert('error loading element');
				}
			});

			var $tableBody = $('#tableBody');
			// print element to table
			function showNextElement(sort, e) {
				var $bodyLoop = '<tr><td>' + e.id + '</td><td>'
						+ e.trackingNumber + '</td><td>' + e.slug + '</td><td>'
						+ e.title + '</td><td>' + e.customerName + '</td><td>'
						+ e.deliveryTime + '</td><td>'
						+ e.destinationCountryISO3 + '</td><td>' + e.orderID
						+ '</td><td>' + e.tag + '</td></tr>';
				switch (sort) {
				case 'append':
					$tableBody.append($bodyLoop);
					break;
				case 'prepend':
					$tableBody.prepend($bodyLoop);
					break;
				case 'after':
					$(".selected").remove();
					$('#tableBody tr:eq(' + (row_num - 2) + ')').after(
							$bodyLoop);
					$('#tableBody tr:eq(' + (row_num - 1) + ')').addClass(
							'selected');
					break;
				default:
					$tableBody.append($bodyLoop);
					break;
				}

			}
			// get row number selected
			var row_num = 0;
			var $trackingNumber1;
			var $slug1;
			var $title1;
			var $orderID1;
			var $customerName1;
			function reSelectedRow() {
				$('#tableSelected tbody tr').click(
						function() {
							$(this).addClass('selected').siblings()
									.removeClass('selected');
							row_num = parseInt($(this).index()) + 1;
							console.log(row_num);
							// get value in row to push into input field
							$selectedRow = $('#tableSelected tr')[row_num];
							$trackingNumber1 = $selectedRow.cells[1].innerHTML;
							$slug1 = $selectedRow.cells[2].innerHTML;
							$title1 = $selectedRow.cells[3].innerHTML;
							$orderID1 = $selectedRow.cells[7].innerHTML;
							$customerName1 = $selectedRow.cells[4].innerHTML;
							delTracking();
							editTracking();
						});
			}
			function editTracking() {
				$trackingNumber.val($trackingNumber1);
				$slug.val($slug1);
				$title.val($title1);
				$orderID.val($orderID1);
				$customerName.val($customerName1);
			}
			function delTracking() {
				$('#deltrackingNumber').val($trackingNumber1);
				$('#delslug').val($slug1);
				console.log($('#delslug').val());
			}

			// get all element
			$.ajax({
				type : 'GET',
				url : '/api/trackings',
				success : function(trackings) {
					$.each(trackings, function(i, tracking) {
						console.log(tracking);
						showNextElement('append', tracking);
					});
					// selected row in table
					reSelectedRow();
				},
				error : function() {
					alert('error loading element');
				}
			});

			// notify when user send information to server and get response
			function notifyResponse(id, type, message) {
				var $idd = $('#notifyId');
				var $idd2 = $('#notifyId2');
				$(id).removeClass('' + $(id).attr('class'));
				$(id).addClass('alert ' + type).html('' + message).show();
			}

			// add new tracking
			var $trackingNumber = $('#trackingNumber');
			var $slug = $('#slug');
			var $title = $('#title');
			var $orderID = $('#orderID');
			var $customerName = $('#customerName');
			var $emails = $('#emails');
			$('#addUser').on(
					'click',
					function() {
						// zip to object
						var newTracking = {
							trackingNumber : $trackingNumber.val(),
							slug : $slug.val(),
							title : $title.val(),
							orderID : $orderID.val(),
							customerName : $customerName.val(),
							emails : $emails.val()
						}
						//var redirectWindow = window.open('https://www.c5game.com', '_blank');
						$.ajax({
							type : 'POST',
							url : '/api/trackings',
							data : newTracking,
							dataType : 'json',
							success : function(tracking) {
								//notifyResponse(user.type, user.message);
								//if (user.success == true)
								//	showNextUser(user);
								showNextElement('prepend', tracking);
								notifyResponse('#notifyId', 'alert-success',
										'Sucess add new Tracking!');
								console.log(tracking);
							},
							error : function(res) {
								//alert("shit");
								console.log(res);
								notifyResponse('#notifyId', 'alert-danger',
										res.responseJSON.message);
							}
						});
					});
			$('#editUser').on(
					'click',
					function() {
						// zip to object
						var newTracking = {
							trackingNumber : $('#trackingNumber').val(),
							slug : $('#slug').val(),
							title : $('#title').val(),
							orderID : $('#orderID').val(),
							customerName : $('#customerName').val(),
						}
						$.ajax({
							type : 'PUT',
							url : '/api/trackings',
							data : newTracking,
							dataType : 'json',
							success : function(tracking) {
								showNextElement('after', tracking);
								notifyResponse('#notifyId', 'alert-success',
										'Sucess edit Tracking!');
								console.log(tracking);
								reSelectedRow();
								editTracking();
							},
							error : function(res) {
								//alert("shit");
								console.log(res);
								notifyResponse('#notifyId', 'alert-danger',
										res.responseJSON.message);
								reSelectedRow();
							}
						});
					});

			$('#deleteBtn').on(
					'click',
					function() {
						// zip to object
						var newTracking = {
							trackingNumber : $('#deltrackingNumber').val(),
							slug : $('#delslug').val(),
						}
						$.ajax({
							type : 'DELETE',
							url : '/api/trackings',
							data : newTracking,
							dataType : 'json',
							success : function(res) {
								notifyResponse('#notifyId2', 'alert-success',
										'Success delete selected tracking');
								console.log(res);
								$(".selected").remove();
								reSelectedRow();
								delTracking();
							},
							error : function(res) {
								console.log(res);
								notifyResponse('#notifyId2', 'alert-danger',
										res.responseJSON.message);
								reSelectedRow();
							}
						});
					});
		});
	</script>
</body>
</html>
