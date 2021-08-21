<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String me_id = request.getParameter("me_id");
	String se_id = request.getParameter("se_id");
	String me_title = request.getParameter("me_title");
	String se_name = request.getParameter("se_name");
	
	String[] me = me_title.split(" ");
%>

<div class="container">

	<h1 class="mt-5">Non-Evaluative Credits Management</h1>




	<nav aria-label="breadcrumb" class="mt-4">
		<ol class="breadcrumb">
			<li class="breadcrumb-item link-primary cursor-pointer"
				onclick="loadMainEvent()">All Events</li>
			<li class="breadcrumb-item link-primary cursor-pointer" onclick="loadSubEvent('<%=me_id%>', '<%= me[0]%>', '<%= me[1]%>')"><%=me_title%></li>
			<li class="breadcrumb-item active" aria-current="page"><%=se_name%></li>
		</ol>
	</nav>


	<h4 class="mt-4"><%=se_name%></h4>

	<div class="d-flex justify-content-end align-items-center mt-3">
		<div class="filter">
			<span>Filter by</span> <select class="custom-select custom-select-sm"
				id="filter-field" onchange="loadParticipantTable('<%=me_id %>', '<%=se_id %>')">
				<option selected value="NAME">Name</option>
				<option value="ROLLNO">Roll no</option>
				<option value="YEAR">Year</option>
				<option value="CLASS">Class</option>
			</select> <input class="form-group" type="text" placeholder="Search"
				id="filter-query" onkeyup="loadParticipantTable('<%=me_id %>', '<%=se_id %>')">
		</div>
		<div class="sort ms-4">
			<span>Sort by</span> <select class="custom-select custom-select-sm"
				id="sort-field" onchange="loadParticipantTable('<%=me_id %>', '<%=se_id %>')">
				<option selected value="NAME">Name</option>
				<option value="ROLLNO">Roll no</option>
				<option value="YEAR">Year</option>
				<option value="CLASS">Class</option>
			</select> <select class="custom-select custom-select-sm" id="sort-direction" onchange="loadParticipantTable('<%=me_id %>', '<%=se_id %>')">
				<option selected value="ASCENDING">Ascending</option>
				<option value="DESCENDING">Descending</option>
			</select>
		</div>




		<button type="button" class="btn btn-secondary ms-4"
			data-bs-toggle="modal" data-bs-target="#addNewSubEventModal">+</button>




		<div class="modal" tabindex="-1" role="dialog"
			id="addNewSubEventModal">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Add participants</h5>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" aria-label="Close"
							onclick="$('#addNewSubEventModal').modal('toggle')">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p class="breadcrumb-item active">Add individually</p>
						<div class="input-group mb-3">
							<span class="input-group-text" id="inputGroup-sizing-default">Roll
								no.</span> <input type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" maxlength="8" id="s_rollno" onkeyup="checkRollNo('<%= me_id%>', '<%= se_id%>', false)">
						</div>
						<div class=" d-flex justify-content-between">
							<h6 id="rollno-status"></h6>
							<button class="btn btn-secondary" onclick="checkRollNo('<%= me_id%>', '<%= se_id%>', true)">Add</button>
						</div>
					</div>
					<div class="modal-body">
						<p class="breadcrumb-item active">Add bulk</p>
						<div class="mb-3">
							<label for="bulkAddTextArea" class="form-label">Paste
								comma separated Roll nos.</label>
							<textarea class="form-control" id="bulkAddTextArea" rows="10"></textarea>
						</div>
						<div class="d-flex justify-content-end">
							<button type="button" class="btn btn-secondary"
								data-bs-toggle="modal" data-bs-target="#parsedRollNos">Parse
								data</button>
						</div>
					</div>
				</div>
			</div>
		</div>




		<div class="modal" tabindex="-1" role="dialog" id="parsedRollNos">
			<div class="modal-dialog  modal-lg modal-dialog-centered"
				role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Bulk add participants</h5>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" aria-label="Close"
							onclick="$('#parsedRollNos').modal('toggle')">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p class="breadcrumb-item active">Identified entries</p>

						<table class="table mt-5">
							<thead>
								<tr>
									<th scope="col">#</th>
									<th scope="col" colspan="2">Participant names</th>
									<th scope="col">Roll no</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">1</th>
									<td colspan="2">Gavin Pereira</td>
									<td>SU190217</td>
								</tr>
								<tr>
									<th scope="row">2</th>
									<td colspan="2">Rahul Morajker</td>
									<td>SU190002</td>
								</tr>
								<tr>
									<th scope="row">3</th>
									<td colspan="2">Aidan Vaz</td>
									<td>SU190333</td>
								</tr>
							</tbody>
						</table>


						<div class="d-flex justify-content-between">
							<button type="button" class="btn btn-secondary"
								data-bs-toggle="modal" data-bs-target="#"
								onclick="$('#parsedRollNos').modal('toggle')">Go back &
								Rectify</button>
							<button type="button" class="btn btn-secondary"
								data-bs-toggle="modal" data-bs-target="#">Parse data</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
 <!-- Modal to Edit Participant -->

            <div class="modal" tabindex="-1" role="dialog" id="editRow">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit entry</h5>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close"
                                onclick="$('#editRow').modal('toggle')">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">Roll no.</span>
                                <input type="text" class="form-control" aria-label="Sizing example input"
                                    aria-describedby="inputGroup-sizing-default" maxlength="8">
                            </div>
                            <div class=" d-flex justify-content-between">
                                <h6>Name: Arun Das</h6>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary">Save</button>
                        </div>
                    </div>
                </div>
            </div>
	
	<!-- Modal to Delete Participant -->

            <div class="modal" tabindex="-1" role="dialog" id="deleteRow">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete entry</h5>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close"
                                onclick="$('#deleteRow').modal('toggle')">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-3">
                                <span id="inputGroup-sizing-default">Are you sure?</span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                onclick="$('#deleteRow').modal('toggle')">No</button>
                            <button type="button" class="btn btn-secondary">Yes</button>
                        </div>
                    </div>
                </div>
            </div>

	</div>
	<table class="table mt-5">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col" colspan="2">Participant names</th>
				<th scope="col">Roll no</th>
				<th scope="col">Year</th>
				<th scope="col">Class</th>
				<th scope="col"></th>
			</tr>
		</thead>
		<tbody id="table-content">
			
		</tbody>
	</table>
	<div class="d-flex justify-content-center mt-5">
		<button type="button" class="btn btn-secondary">More</button>
	</div>
</div>