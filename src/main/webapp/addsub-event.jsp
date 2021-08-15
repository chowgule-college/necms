<%@page import="entity.SubEvent"%>
<%@page import="java.util.List"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.SubEventDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<a href="./index.jsp">home</a>
<form action="RegisterSubEvent" method="post">
		<input type="text" name="se_name" placeholder="Enter Event Name">
		<input type="number" name="se_hours" placeholder="Enter Hours">
		<input type="number" name="me_id" placeholder="Enter me_id">
		<button type="submit">submit</button>
	</form>
	
	<%
	int me_id = Integer.parseInt(request.getParameter("me_id"));
	SubEventDao dao = new SubEventDao(ConnectionProvider.getConnection());
	List<SubEvent> se_list = dao.getAllSubEventByMainEvent(me_id);
	int count = 0;
	SubEvent se;
	%>
	
	<table>
		<thead>
			<tr>
				<th>seid</th>
				<th>sub event name</th>
				<th>hours</th>
				<th>meid</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" begin="1" end="<%=se_list.size()%>">
				<%
				se = se_list.get(count);
				count++;
				%>
				<tr>
					<td><a href="addsub-event.jsp?me_id=<%=se.getMe_id()%>&&se_id=<%= se.getSe_id()%>"><%=se.getSe_id()%></a></td>
					<td><%=se.getSe_name()%></td>
					<td><%=se.getSe_hours()%></td>
					<td><%=se.getMe_id()%></td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
</body>
</html>