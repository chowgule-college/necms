<%@page import="entity.MainEvent"%>
<%@page import="java.util.List"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.MainEventDao"%>
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
	<form action="RegisterMainEvent" method="post">
		<input type="text" name="me_name" placeholder="Enter Event Name">
		<input type="date" name="me_date">
		<button type="submit">submit</button>
	</form>

	<%
	MainEventDao dao = new MainEventDao(ConnectionProvider.getConnection());
	List<MainEvent> me_list = dao.getAllMainEvents();
	int count = 0;
	MainEvent me;
	%>

	<table>
		<thead>
			<tr>
				<th>meid</th>
				<th>main event name</th>
				<th>date</th>
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

	</table>
</body>
</html>