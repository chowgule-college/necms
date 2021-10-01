<%@page import="java.util.HashMap"%>
<%@page import="entity.Student"%>
<%@page import="java.util.List"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.StudentDao"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String searchCategory = request.getParameter("searchCategory");
String searchStr = request.getParameter("searchStr");
String orderCategory = request.getParameter("orderCategory");
String orderType = request.getParameter("orderType");
StudentDao sDao = new StudentDao(ConnectionProvider.getConnection());
List<HashMap<String, String>> studentsWithHours = sDao.fetchALLWithHoursInfoWithFilter(searchCategory, searchStr,
		orderCategory, orderType);
int count = 0;
%>
<%
if (studentsWithHours != null) {
%>
<c:forEach var="i" begin="1" end="<%=studentsWithHours.size()%>">
	<%
	HashMap<String, String> studentWithHours = studentsWithHours.get(count);
	count++;
	%>
	<tr>
		<th scope="row"><%=count%></th>
		<td><%=studentWithHours.get("rollno")%></td>
		<td colspan="2" onclick="loadIStudent('<%=studentWithHours.get("rollno")%>', '<%=studentWithHours.get("name")%>')" class="pointer"><%=studentWithHours.get("name")%></td>
		<td><%=studentWithHours.get("year")%></td>
		<td><%=studentWithHours.get("course")%></td>
		<td><%=studentWithHours.get("total")%></td>
		<td><%=studentWithHours.get("remaining")%></td>
	</tr>
</c:forEach>

<%
} else {
%>
<tr>
	<th scope="row">No Data found</th>
</tr>
<%
}
%>
