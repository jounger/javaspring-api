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
</header>
<body>

	<!-- <ul id="showUsers">
		<li>New users</li>
	</ul>  -->

	<!-- <form action="/api/users" method="POST">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="text" id="username" value="">
		<input type="password" id="password" value=""> <input
			type="button" value="Ceate new user" id="addUser">
	</form>  -->

	<!-- Form modal https://getbootstrap.com/docs/3.4/javascript/  -->
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#exampleModal">Add new User</button>

	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">New user</h4>
				</div>
				<div id="notifyId" class="" role="alert" style="display: none">This
					is alert...</div>
				<div class="modal-body">
					<form action="/api/users" method="POST">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />

						<div class="form-group">
							<label for="username" class="control-label">Username:</label> <input
								type="text" class="form-control" id="username">
						</div>
						<div class="form-group">
							<label for="password" class="control-label">Password:</label> <input
								type="text" class="form-control" id="password">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="addUser">Send
						message</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End form modal -->
	<table class="pure-table pure-table-bordered">
		<thead>
			<tr>
				<th>Username</th>
				<th>Password</th>
			</tr>
		</thead>
		<tbody id="tUser">
			<tr>
				<td></td>
				<td></td>
			</tr>
			<tr></tr>
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
			var $username = $('#username');
			var $password = $('#password');
			var $showUsers = $('#showUsers');

			var $tUser = $('#tUser');
			// print user to table
			function showNextUser(user) {
				$tUser.prepend('<tr><td>' + user.username + '</td><td>'
						+ user.password + '</td></tr>');
			}
			// get all user and list to the table
			$.ajax({
				type : 'GET',
				url : '/api/users',
				success : function(users) {
					$.each(users, function(i, user) {
						showNextUser(user);
					});
				},
				error : function() {
					alert('error loading users');
				}
			});

			// notify when user send information to server and get response
			function notifyResponse(typeRes, messageRes) {
				$('#notifyId').removeClass('' + $('#notifyId').attr('class'));
				$('#notifyId').addClass('alert ' + typeRes).html(
						'' + messageRes).show();
			}
			// add new user and get response
			$('#addUser').on('click', function() {
				// zip to object
				var newUser = {
					username : $username.val(),
					password : $password.val()
				}
				//var redirectWindow = window.open('https://www.c5game.com', '_blank');
				$.ajax({
					type : 'POST',
					url : '/api/users',
					data : newUser,
					dataType : 'json',
					success : function(user) {
						notifyResponse(user.type, user.message);
						if (user.success == true)
							showNextUser(user);
						console.log(user);
					},
					error : function() {
						alert("shit");
					}
				});
			})

		});
	</script>
</body>
</html>
