<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>STUDENT</title>
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
.pointer {
  cursor: pointer;
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
	loadALLStudents();
	function loadALLStudents() {
		var xhr = new XMLHttpRequest();
		xhr.open('POST', 'all-student.jsp', true);
		xhr.onload = function() {
			if (this.status == 200) {
				document.getElementById('content-area').innerHTML = this.responseText;
				startListener();
				loadAllStudentTable();
			}
		}
		xhr.send();
	}
	
	function startListener(){
		var input = document.getElementById("filter-query");
		input.addEventListener("keyup", function(event) {
				  if (event.keyCode === 
				  13) {
				    event.preventDefault();
					loadAllStudentTable();
				  }
				}); 
	}

	function loadAllStudentTable() {
		var searchCategory = document.getElementById("filter-field").value;
		var searchStr = document.getElementById("filter-query").value;
		var orderCategory = document.getElementById("sort-field").value;
		var orderType = document.getElementById("sort-direction").value;
		$.ajax({
			type : "POST",
			url : "all-student-table.jsp?searchCategory=" + searchCategory
					+ "&&searchStr=" + searchStr + "&&orderCategory="
					+ orderCategory + "&&orderType=" + orderType,
			success : function(data) {
				document.getElementById("table-content").innerHTML = data;
			}
		});
	}
	function loadIStudent(rollno, name){
		$.ajax({
			type : "POST",
			url : "student-view2.jsp?rollno=" + rollno
					+ "&&name=" + name,
			success : function(data) {
				document.getElementById("content-area").innerHTML = data;
			}
		});
	}
	
	</script>
</body>

</html>