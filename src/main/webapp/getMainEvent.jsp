<%@page import="entity.Participant"%>
<%@page import="entity.Student"%>
<%@page import="dao.StudentDao"%>
<%@page import="dao.ParticipantDao"%>
<%@page import="entity.MainEvent"%>
<%@page import="java.util.List"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.MainEventDao"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ParticipantDao dao = new ParticipantDao(ConnectionProvider.getConnection());
StudentDao dao2 = new StudentDao(ConnectionProvider.getConnection());

List<Student> students = dao2.getStudent(dao.getAllParticipantBySubAndMainEvent(1, 1));
int count = 0;
Student student;
%>
<%= students.toString() %>
<table>
	<thead>
		<tr>
			<th>RollNO</th>
			<th>NAME</th>
			<th>Course</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="i" begin="1" end="<%=students.size()%>">
			<%
			student = students.get(count);
			count++;
			%>
			<tr>
				<td><%=student.getS_rollno()%></td>
				<td><%=student.getS_name()%></td>
				<td><%=student.getS_course()%></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<%-- <%
ParticipantDao dao = new ParticipantDao(ConnectionProvider.getConnection());
List<Participant> participants = dao.getAllParticipantBySubAndMainEvent(1, 1);
int count = 0;
Participant p;
%>
<table>
	<thead>
		<tr>
			<th>rollno</th>
			<th>se_id</th>
			<th>me_id</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="i" begin="1" end="<%=participants.size()%>">
			<%
			p = participants.get(count);
			count++;
			%>
			<tr>
				<td><%=p.getP_rollno()%></td>
				<td><%=p.getSe_id()%></td>
				<td><%=p.getMe_id()%></td>
			</tr>
		</c:forEach>
	</tbody>
</table> --%>
<%-- <%
MainEventDao dao = new MainEventDao(ConnectionProvider.getConnection());
List<MainEvent> me_list = dao.getAllMainEvents();
int count = 0;
MainEvent me;
%>
<table>
	<thead>
		<tr>
			<th>MEID</th>
			<th>MAIN EVENT NAME</th>
			<th>DATE</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="i" begin="1" end="<%=me_list.size()%>">
			<%
			me = me_list.get(count);
			count++;
			%>
			<tr>
				<td><a href="addsub-event.jsp?me_id=<%=me.getMe_id()%>"><%=me.getMe_id()%></a></td>
				<td><%=me.getMe_name()%></td>
				<td><%=me.getMe_date().toString()%></td>
			</tr>
		</c:forEach>
	</tbody>
</table> --%>