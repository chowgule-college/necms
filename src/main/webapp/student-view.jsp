<%@page import="java.util.HashMap"%>
<%@page import="dao.MainEventDao"%>
<%@page import="dao.SubEventDao"%>
<%@page import="entity.SubEvent"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ParticipantDao"%>
<%@page import="entity.Participant"%>
<%@page import="java.util.List"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Student View</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

	<div class="container">
		<h1 class="mt-5">Non-Evaluative Credits Management</h1>

		<h4 class="mt-4">Event Participation List</h4>

		<%
		ParticipantDao pDao = new ParticipantDao(ConnectionProvider.getConnection());
		SubEventDao sDao = new SubEventDao(ConnectionProvider.getConnection());
		MainEventDao mDao = new MainEventDao(ConnectionProvider.getConnection());
		String rollno = "SU190209";
		int count = 0;
		int maxCredits = 180;
		int totalCredits = 0;
		float percentage = 0;
		List<Participant> participations = pDao.allParticipations(rollno);
		%>


		<div class="table_container" style="min-height: 60vh;">
			<table class="table mt-5">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col" colspan="2">Event name</th>
						<th scope="col">Sub-event name</th>
						<th scope="col">Date of commencement</th>
						<th scope="col">Hours</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (participations != null) {
					%>
					<c:forEach var="i" begin="1" end="<%=participations.size()%>">

						<%
						Participant p = participations.get(count);
						HashMap<String, String> meNameAndDate = mDao.getMENameAndDate(p.getMe_id());
						HashMap<String, String> seNameAndHours = sDao.getSENameAndHours(p.getSe_id());
						totalCredits += Integer.valueOf(seNameAndHours.get("se_hours"));
						count++;
						%>
						<tr>
							<th scope="row"><%=count%></th>
							<td colspan="2"><%=meNameAndDate.get("me_name")%></td>
							<td><%=seNameAndHours.get("se_name")%></td>
							<td><%=meNameAndDate.get("me_date")%></td>
							<td><%=seNameAndHours.get("se_hours")%></td>
						</tr>
					</c:forEach>
					<%
					}
					%>
				</tbody>
			</table>
			<!-- <div class="d-flex justify-content-center mt-5"><button type="button"
                    class="btn btn-secondary">More</button>
            </div> -->
		</div>

		<div class="row my-5">
			<p class="col-4 text-center">
				Completed: <span id="hours_completed" class="h6 text-center"><%=totalCredits%></span>/<%=maxCredits%>
				hours
			</p>
			<p class="col-4 text-center">
				Remaining: <span id="hours_completed" class="h6 text-center">
					<%
					if (totalCredits > maxCredits) {
					%> <%=0%>
					<%
					} else {
					%><%=maxCredits - totalCredits%>
					<%
					}
					%>
				</span> hours
			</p>
			<%
			percentage = totalCredits * 100 / maxCredits;
			%>
			<p class="col-4 text-center">
				Progress: <span id="hours_completed" class="h6 text-center"><%=percentage%></span>%
			</p>
			<div class="progress">
				<div class="progress-bar progress-bar-striped bg-secondary"
					role="progressbar" style="width: <%=percentage%>%"></div>
				<!-- Set the width of the above bar equal to the percentage of completion. -->
			</div>
		</div>

	</div>




	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>


</body>

</html>