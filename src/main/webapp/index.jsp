<html>
<head>
<title>Home</title>
</head>
<body>
	<h2>Hello World!</h2>
	<a href="./addevent.jsp">Add Event</a>
	<br>
	<a href="./addsub-event.jsp">Add Sub Event</a>
	<br>
	<a href="./addparticipant.jsp">Add Participant</a>

	<div id="content-area"></div>
	<script src="https://code.jquery.com/jquery-3.4.1.js"
		integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		function loadTable() {
			var xhr = new XMLHttpRequest();
			xhr.open('POST', 'getMainEvent.jsp', true);

			xhr.onload = function() {
				if (this.status == 200) {
					document.getElementById('content-area').innerHTML = this.responseText;
				}
			}

			xhr.send();

		}
		
		loadTable()
	</script>
</body>
</html>
