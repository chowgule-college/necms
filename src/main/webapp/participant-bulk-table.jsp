<%@page import="entity.Student"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.StudentDao"%>
<%@page import="java.util.List"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String me_id = request.getParameter("me_id");
String se_id = request.getParameter("se_id");
String s_rollno = request.getParameter("s_rollnoList");
String[] s_rollnoList = s_rollno.split(",");
StudentDao dao = new StudentDao(ConnectionProvider.getConnection());
List<Student> studentList = dao.getStudentsByRollNoList(s_rollnoList);
s_rollno = "";
int count = 0;
%>

<div class="modal-content">
	<div class="modal-header">
		<h5 class="modal-title">Bulk add participants</h5>
		<button type="button" class="btn btn-secondary" data-dismiss="modal"
			aria-label="Close" onclick="$('#parsedRollNos').modal('toggle')">
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
			<tbody >
				<c:forEach var="i" begin="1" end="<%=studentList.size()%>">
					<%
					Student student = studentList.get(count);
					s_rollno += " " + student.getS_rollno();
					count++;
					%>
					<tr>
						<th scope="row"><%=count%></th>
						<td colspan="2"><%=student.getS_name()%></td>
						<td><%=student.getS_rollno()%></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>


		<div class="d-flex justify-content-between">
			<button type="button" class="btn btn-secondary"
				data-bs-toggle="modal" data-bs-target="#"
				onclick="$('#parsedRollNos').modal('toggle')">Go back &
				Rectify</button>
			<button type="button" class="btn btn-secondary"
				data-bs-toggle="modal" data-bs-target="#" onclick="addBulkParticipants('<%= me_id%>','<%=se_id%>','<%=s_rollno%>')">Parse data</button>
		</div>
	</div>
</div>

