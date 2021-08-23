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
	function showErrorMsg(msg){
		return '<div class="alert alert-danger d-flex align-items-center"role="alert" style="display: flex; justify-content: space-between;"> <div style="display: flex; align-items: center;"> <i class=" fas fa-exclamation-triangle"style="margin-right: 15px"></i>' + msg + '</div><button type="button" class="btn-close" data-bs-dismiss="alert"aria-label="Close"></button></div></div>'
	}
	
	/* Main Event Funtions	 */
	function loadMainEvent() {
			var xhr = new XMLHttpRequest();
			xhr.open('POST', 'main-event.jsp', true);
			xhr.onload = function() {
				if (this.status == 200) {
					document.getElementById('content-area').innerHTML = this.responseText;
					loadMainEventTable();
				}
			}
			xhr.send();
		}
	
	function loadMainEventTable() {
		var searchCategory = document.getElementById("filter-field").value;
		var searchStr = document.getElementById("filter-query").value;
		var orderCategory = document.getElementById("sort-field").value;
		var orderType = document.getElementById("sort-direction").value;
		$.ajax({
			type : "POST",
			url : "main-event-table.jsp?searchCategory=" + searchCategory
					+ "&&searchStr=" + searchStr + "&&orderCategory="
					+ orderCategory + "&&orderType=" + orderType,
			success : function(data) {
				document.getElementById("table-content").innerHTML = data;
			}
		});
	}
	
	function addNewMainEvent() {
		var me_name = document.getElementById("me_name").value;
		var me_date = document.getElementById("me_date").value;
		if (me_name == "") {
			document.getElementById("new-error").innerHTML = showErrorMsg("Please Enter Main Event Name!");
			return;
		}
		if (me_date == "") {
			document.getElementById("new-error").innerHTML = showErrorMsg("Please Enter Main Event Date!");
			return;
		}
		
		$.ajax({
			type : "POST",
			url : "RegisterMainEvent?me_name=" + me_name + "&&me_date="
					+ me_date,
			success : function(data) {
				document.getElementById("new-error").innerHTML = "";
				if (data == 1) {
					alert('Main Event Added success fully added')
					$("#addNewEventModal").modal("hide");
					loadMainEventTable();
				} else {
					alert("somethig went wrong!");
				}
				
			}
		});
	}
		
	function removeMainEvent(me_id){
		$('#deleteRow').modal('show');
		const yesButton = document.getElementById("remove-item");
		yesButton.addEventListener("click", () => {
			$.ajax({
				type : "POST",
				url : "RemoveMainEvent?me_id=" + me_id,
				success : function(data) {
					if(data == 1){
						$('#deleteRow').modal('hide');
						loadMainEventTable();
					}else{
						alert("something went wrong!");
					}
				}
			});
		});
	}
	
	function updateMainEvent(me_id, me_name, me_date){
		var editMeName = document.getElementById("edit-me-name");
		var editMeDate = document.getElementById("edit-me-date");
		editMeName.value = me_name;
		editMeDate.value = me_date;
		$('#editRow').modal('show');
		const updateSave = document.getElementById("update-save");
		updateSave.addEventListener("click", () => {
			if (editMeName.value == "") {
				document.getElementById("update-error").innerHTML = showErrorMsg("Please Enter Main Event Name!");
				return;
			}
			if (editMeDate.value == "") {
				document.getElementById("update-error").innerHTML = showErrorMsg("Please Enter Main Event Date!");
				return;
			}
			$.ajax({
				type : "POST",
				url : "UpdateMainEvent?me_id=" + me_id + "&&me_name=" + editMeName.value + "&&me_date=" + editMeDate.value,
				success : function(data) {
					document.getElementById("update-error").innerHTML = "";
					if(data == 1){			
						$('#editRow').modal('hide');
						loadMainEventTable();
					}else{
						alert("something went wrong!");
					}
				}
			});
		});
	}
	
	/* Sub Event Functions */
	
	function loadSubEvent(me_id, me_name) {
			$.ajax({
				type : "POST",
				url : "sub-event.jsp?me_name=" + me_name + "&&me_id=" + me_id,
				success : function(data) {
					document.getElementById("content-area").innerHTML = data;
					loadSubEventTable(me_id)
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
			success : function(data) {
				document.getElementById("table-content").innerHTML = data;
			}
		});
	}
		
		function addNewSubEvent(me_id) {
			var se_name = document.getElementById("se_name").value;
			var se_hours = document.getElementById("se_hours").value;
			if (se_name == "") {
				document.getElementById("new-error").innerHTML = showErrorMsg("Please Enter Sub Event Name!");
				return;
			}
			if (se_hours == "") {
				document.getElementById("new-error").innerHTML = showErrorMsg("Please Enter Sub Event Hours!");
				return;
			}
			$.ajax({
				type : "POST",
				url : "RegisterSubEvent?se_name=" + se_name + "&&se_hours="
						+ se_hours + "&&me_id=" + me_id,
				success : function(data) {
					document.getElementById("new-error").innerHTML = "";
					if(data == 1){
						alert('Sub Event Added success fully added');
						$("#addNewSubEventModal").modal("hide");
						loadSubEventTable(me_id);
					}else{
						alert('something went wrong!');
					}
				}
			});
		}

		function removeSubEvent(se_id, me_id){
			$('#deleteRow').modal('show');
			const yesButton = document.getElementById("remove-item");
			yesButton.addEventListener("click", () => {
				$.ajax({
					type : "POST",
					url : "RemoveSubEvent?me_id=" + me_id + "&&se_id=" + se_id,
					success : function(data) {
						if(data == 1){
							$('#deleteRow').modal('hide');
							loadSubEventTable(me_id);
						}else{
							alert("something went wrong!");
						}
					}
				});
			});
		}
		
		function updateSubEvent(se_id, me_id, se_name, se_hours){
			var editSeName = document.getElementById("edit-se-name");
			var editSeHours = document.getElementById("edit-se-hours");
			editSeName.value = se_name;
			editSeHours.value = se_hours;
			$('#editRow').modal('show');
			const updateSave = document.getElementById("update-save");
			updateSave.addEventListener("click", () => {
				if (editSeName.value == "") {
					document.getElementById("update-error").innerHTML = showErrorMsg("Please Enter Sub Event Name!");
					return;
				}
				if (editSeHours.value == "" || se_hours == 0) {
					document.getElementById("update-error").innerHTML = showErrorMsg("Please Enter Sub Event Hours!");
					return;
				}
				$.ajax({
					type : "POST",
					url : "UpdateSubEvent?me_id=" + me_id + "&&se_id=" + se_id + "&&se_name=" + editSeName.value + "&&se_hours=" + editSeHours.value,
					success : function(data) {
						document.getElementById("update-error").innerHTML = "";
						if(data == 1){							
							$('#editRow').modal('hide');
							loadSubEventTable(me_id);
						}else{
							alert("something went wrong!");
						}
					}
				});
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

		function checkRollNo(me_id, se_id, addParticipantStatus) {
			var s_rollno = document.getElementById("s_rollno").value;
			$.ajax({
				type : "POST",
				url : "CheckStudent?s_rollno=" + s_rollno + "&&me_id=" + me_id
						+ "&&se_id=" + se_id,
				processData : false,
				contentType : false,
				success : function(data) {
					if (data == 0){
						document.getElementById("rollno-status").innerHTML = "Student Not Found!";
					}else if (data == 1){
						document.getElementById("rollno-status").innerHTML = "Student Already Exists!"
					}else {
						document.getElementById("rollno-status").innerHTML = data;
						
						if (addParticipantStatus){
							addNewParticipant(me_id, se_id, s_rollno);
						}
					}	
				}
			});
		}
		
		function addNewParticipant(me_id, se_id, s_rollno){
			 $.ajax({
				type : "POST",
				url : "RegisterParticipant?s_rollno=" + s_rollno + "&&me_id=" + me_id
						+ "&&se_id=" + se_id,
				processData : false,
				contentType : false,
				success : function(data) {
					if (data == 1){
						$("#addNewSubEventModal").modal("hide");
						loadParticipantTable(me_id, se_id);
					}else{
						document.getElementById("rollno-status").innerHTML = "Something Went Wrong!";
					}
				}
			});
		}
		
		function addNewParticipantsInBulk(me_id, se_id){
			var s_rollnoList = document.getElementById("bulkAddTextArea").value;
			$.ajax({
				type : "POST",
				url : "participant-bulk-table.jsp?s_rollnoList=" + s_rollnoList + "&&me_id=" + me_id
						+ "&&se_id=" + se_id,
				processData : false,
				contentType : false,
				success : function(data) {
					document.getElementById("table-bulk-content").innerHTML = data;
					$("#parsedRollNos").modal("show");
				}
			});
		}

		function addBulkParticipants(me_id, se_id, s_rollnoList){
			$.ajax({
				type : "POST",
				url : "RegisterBulkParticipants?s_rollnoList=" + s_rollnoList + "&&me_id=" + me_id
						+ "&&se_id=" + se_id,
				processData : false,
				contentType : false,
				success : function(data) {
					if(data == 1){
						$("#parsedRollNos").modal("hide");
						$("#addNewSubEventModal").modal("hide");
						loadParticipantTable(me_id, se_id);
					}else{
						alert("something went wrong!");
					}
				}
			});
		}
		
		
		
		
		
		function removeParticipant(me_id, se_id, p_rollno){
			$('#deleteRow').modal('show');
			const yesButton = document.getElementById("remove-item");
			yesButton.addEventListener("click", () => {
				$.ajax({
					type : "POST",
					url : "RemoveParticipant?me_id=" + me_id + "&&se_id=" + se_id + "&&p_rollno=" + p_rollno,
					processData : false,
					contentType : false,
					success : function(data) {
						if(data == 1){
							$('#deleteRow').modal('hide');
							loadParticipantTable(me_id, se_id)
						}else{
							alert("something went wrong!");
						}
					}
				});
			});
		}
		
		
		
		


		loadMainEvent()
	</script>
</body>

</html>