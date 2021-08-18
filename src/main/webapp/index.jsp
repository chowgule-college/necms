<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NECMS</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
		
		function loadTable(){
			var searchCategory = document.getElementById("filter-field").value;
			var searchStr = document.getElementById("filter-query").value;
			var orderCategory = document.getElementById("sort-field").value;
			var orderType = document.getElementById("sort-direction").value;
			
			$.ajax({
				type : "POST",
				url : "main-event-table.jsp?searchCategory=" + searchCategory + "&&searchStr=" + searchStr + "&&orderCategory=" + orderCategory + "&&orderType=" + orderType,
				processData : false,
				contentType : false,
				success : function(data) {
					document.getElementById("table-content").innerHTML = data;
				}
			});
		}

		function addNewEvent() {
			var me_name = document.getElementById("me_name").value;
			var me_date = document.getElementById("me_date").value;
			
			$.ajax({
				type : "POST",
				url : "RegisterMainEvent?me_name=" +  me_name + "&&me_date=" + me_date,
				success : function(data) {
					alert('product success fully added')
					$("#addNewEventModal").modal("hide");
					loadTable();
				}
			});
		}
		
		loadMainEvent()
	</script>
</body>

</html>