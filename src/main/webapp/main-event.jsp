<%@page import="entity.MainEvent"%>
<%@page import="java.util.List"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.MainEventDao"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%-- <%
MainEventDao dao = new MainEventDao(ConnectionProvider.getConnection());
List<MainEvent> meList = dao.getMainEvents("NAME", "", "ID", "DESCENDING");
MainEvent me;
int count = 0;
%> --%>
<div class="container">
	<h1 class="mt-5">Non-Evaluative Credits Management</h1>

	<h4 class="mt-4">Events</h4>

	<div class="d-flex justify-content-end align-items-center mt-3">
		<div class="filter">
			<span>Filter by</span> <select class="custom-select custom-select-sm"
				id="filter-field" onchange="loadMainEventTable()">
				<option selected value="NAME">Name</option>
				<option value="DATE">Date</option>
				<option value="ID">ID</option>
			</select> <input class="form-group" type="text" placeholder="Search"
				id="filter-query" onkeyup="loadMainEventTable()">
		</div>
		<div class="sort ms-4">
			<span>Sort by</span> <select class="custom-select custom-select-sm"
				id="sort-field" onchange="loadMainEventTable()">
				<option selected value="NAME">Name</option>
				<option value="DATE">Date</option>
				<option value="ID">ID</option>
			</select> <select class="custom-select custom-select-sm" id="sort-direction"
				onchange="loadMainEventTable()">
				<option selected value="ASCENDING">Ascending</option>
				<option value="DESCENDING">Descending</option>
			</select>
		</div>

		<button type="button" class="btn btn-secondary ms-4"
			data-bs-toggle="modal" data-bs-target="#addNewEventModal">+</button>
			
			
<!-- Modal to Add New Event  -->
		<div class="modal" tabindex="-1" role="dialog" id="addNewEventModal">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Add a new event</h5>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" aria-label="Close"
							onclick="$('#addNewEventModal').modal('toggle')">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="input-group mb-3">
							<span class="input-group-text" id="inputGroup-sizing-default">Name</span>
							<input type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" id="me_name">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text" id="inputGroup-sizing-default">Date
								of commencement</span> <input type="date" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" id="me_date">
						</div>
						
						<div id="new-error"></div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							onclick="addNewMainEvent()">Save event</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal to Edit Event  -->

		<div class="modal" tabindex="-1" role="dialog" id="editRow">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Edit entry</h5>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" aria-label="Close"
							onclick="$('#editRow').modal('toggle')">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="input-group mb-3">
							<span class="input-group-text" id="inputGroup-sizing-default">Name</span>
							<input type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" id="edit-me-name">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text" id="inputGroup-sizing-default">Date
								of commencement</span> <input type="date" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" id="edit-me-date">
						</div>
						
						<div id="update-error"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" id="update-save">Save</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal to Delete Event  -->

		<div class="modal" tabindex="-1" role="dialog" id="deleteRow">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Delete entry</h5>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" aria-label="Close"
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
						<button type="button" class="btn btn-secondary" id="remove-item">Yes</button>
					</div>
				</div>
			</div>
		</div>

	</div>
	<table class="table mt-5">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col" colspan="2">Event name</th>
				<th scope="col">Date of commencement</th>
				<th scope="col">Event ID</th>
				<th scope="col"></th>
			</tr>
		</thead>
		<tbody id="table-content">
			<%-- <c:forEach var="i" begin="1" end="<%=meList.size()%>">
				<%
				me = meList.get(count);
				%>

				<tr>
					<th scope="row"><%=count%></th>
					<td colspan="2"><%=me.getMe_name()%></td>
					<td><%=me.getMe_date().toString()%></td>
					<td><%=me.getMe_id()%></td>
				</tr>
				<%
				count++;
				%>
			</c:forEach> --%>
		</tbody>
	</table>
	<!-- <div class="d-flex justify-content-center mt-5">
		<button type="button" class="btn btn-secondary">More</button>
	</div> -->
</div>