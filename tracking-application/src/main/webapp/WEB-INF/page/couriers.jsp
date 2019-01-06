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

	<table class="pure-table pure-table-bordered">
		<thead>
			<tr>
				<th>Slug</th>
				<th>Name</th>
				<th>Phone</th>
				<th>Other Name</th>
				<th>Web Url</th>
			</tr>
		</thead>
		<tbody id="tableBody">
			<tr>
				<td></td>
				<td></td>
				<td></td>
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
			var $tableBody = $('#tableBody');
			// print element to table
			function showNextElement(e) {
				$tableBody.prepend('<tr><td>' + e.slug + '</td><td>' + e.name
						+ '</td><td>' + e.phone + '</td><td>' + e.othername
						+ '</td><td>' + e.weburl + '</td></tr>');
			}
			// get all element
			$.ajax({
				type : 'GET',
				url : '/api/couriers',
				success : function(couriers) {
					$.each(couriers, function(i, courier) {
						showNextElement(courier);
					});
				},
				error : function() {
					alert('error loading element');
				}
			});
		});
	</script>
</body>
</html>
