<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NECMS</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

<style>
i.fas {
	font-size: 25px;
	cursor: pointer;
	margin-left: 10px;
}
</style>
</head>

<body>
	<div id="content-area"></div>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function loadMainEvent() {
			var xhr = new XMLHttpRequest();
			xhr.open('POST', 'main-event.jsp', true);

			xhr.onload = function() {
				if (this.status == 200) {
					document.getElementById('content-area').innerHTML = this.responseText;
					loadTable();
				}
			}

			xhr.send();

		}

		function loadTable() {
			var searchCategory = document.getElementById("filter-field").value;
			var searchStr = document.getElementById("filter-query").value;
			var orderCategory = document.getElementById("sort-field").value;
			var orderType = document.getElementById("sort-direction").value;

			$.ajax({
				type : "POST",
				url : "main-event-table.jsp?searchCategory=" + searchCategory
						+ "&&searchStr=" + searchStr + "&&orderCategory="
						+ orderCategory + "&&orderType=" + orderType,
				processData : false,
				contentType : false,
				success : function(data) {
					document.getElementById("table-content").innerHTML = data;
				}
			});
		}

		function addNewMainEvent() {
			var me_name = document.getElementById("me_name").value;
			var me_date = document.getElementById("me_date").value;

			$.ajax({
				type : "POST",
				url : "RegisterMainEvent?me_name=" + me_name + "&&me_date="
						+ me_date,
				success : function(data) {
					alert('Main Event Added success fully added')
					$("#addNewEventModal").modal("hide");
					loadTable();
				}
			});
		}
		function addNewSubEvent(me_id) {
			var se_name = document.getElementById("se_name").value;
			var se_hours = document.getElementById("se_hours").value;

			$.ajax({
				type : "POST",
				url : "RegisterSubEvent?se_name=" + se_name + "&&se_hours="
						+ se_hours + "&&me_id=" + me_id,
				success : function(data) {
					alert('Sub Event Added success fully added')
					$("#addNewSubEventModal").modal("hide");
					loadSubEventTable(me_id);
				}
			});
		}

		function loadSubEvent(me_id, me_name, me_year) {
			$.ajax({
				type : "POST",
				url : "sub-event.jsp?me_name=" + me_name + "&&me_year="
						+ me_year + "&&me_id=" + me_id,
				processData : false,
				contentType : false,
				success : function(data) {
					document.getElementById("content-area").innerHTML = data;
					loadSubEventTable(me_id)
				}
			});

		}

		function loadParticipant(me_id, se_id, se_name) {
			var me_title = document.getElementById("me_title").innerHTML;
			$.ajax({
				type : "POST",
				url : "participant.jsp?me_id=" + me_id + "&&se_id=" + se_id
						+ "&&me_title=" + me_title + "&&se_name=" + se_name,
				processData : false,
				contentType : false,
				success : function(data) {
					document.getElementById("content-area").innerHTML = data;
					loadParticipantTable(me_id, se_id);
				}
			});
		}

		function loadSubEventTable(me_id) {
			var searchCategory = document.getElementById("filter-field").value;
			var searchStr = document.getElementById("filter-query").value;
			var orderCategory = document.getElementById("sort-field").value;
			var orderType = document.getElementById("sort-direction").value;

			$.ajax({
				type : "POST",
				url : "sub-event-table.jsp?me_id=" + me_id
						+ "&&searchCategory=" + searchCategory + "&&searchStr="
						+ searchStr + "&&orderCategory=" + orderCategory
						+ "&&orderType=" + orderType,
				processData : false,
				contentType : false,
				success : function(data) {
					document.getElementById("table-content").innerHTML = data;
				}
			});
		}

		function loadParticipantTable(me_id, se_id) {
			var searchCategory = document.getElementById("filter-field").value;
			var searchStr = document.getElementById("filter-query").value;
			var orderCategory = document.getElementById("sort-field").value;
			var orderType = document.getElementById("sort-direction").value;

			$.ajax({
				type : "POST",
				url : "participant-table.jsp?me_id=" + me_id + "&&se_id="
						+ se_id + "&&searchCategory=" + searchCategory
						+ "&&searchStr=" + searchStr + "&&orderCategory="
						+ orderCategory + "&&orderType=" + orderType,
				processData : false,
				contentType : false,
				success : function(data) {
					document.getElementById("table-content").innerHTML = data;
				}
			});
		}

		function checkRollNo(me_id, se_id) {
			var s_rollno = document.getElementById("s_rollno").value;
			$.ajax({
				type : "POST",
				url : "CheckStudent?s_rollno=" + s_rollno + "&&me_id=" + me_id
						+ "&&se_id=" + se_id,
				processData : false,
				contentType : false,
				success : function(data) {
					document.getElementById("rollno-status").innerHTML = data;
				}
			});
		}

		loadMainEvent()
	</script>
</body>

</html>