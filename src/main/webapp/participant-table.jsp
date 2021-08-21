<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="entity.Student"%>
<%@page import="java.util.List"%>
<%@page import="dao.StudentDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ParticipantDao"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
int me_id = Integer.parseInt(request.getParameter("me_id"));
int se_id = Integer.parseInt(request.getParameter("se_id"));
String searchCategory = request.getParameter("searchCategory");
String searchStr = request.getParameter("searchStr");
String orderCategory = request.getParameter("orderCategory");
String orderType = request.getParameter("orderType");
ParticipantDao pDao = new ParticipantDao(ConnectionProvider.getConnection());
StudentDao sDao = new StudentDao(ConnectionProvider.getConnection());
List<Student> studentList = sDao.getStudents(pDao.getAllParticipantBySubAndMainEvent(se_id, me_id), searchCategory,
		searchStr, orderCategory, orderType);
Student student;
int count = 0;
%>

<c:forEach var="i" begin="1" end="<%=studentList.size()%>">
	<%
	student = studentList.get(count);
	%>

	<tr>
		<th scope="row"><%=count%></th>
		<td colspan="2"><%=student.getS_name()%></td>
		<td><%=student.getS_rollno()%></td>
		<td><%=student.getS_year().split("-")[0]%></td>
		<td><%=student.getS_course()%></td>
		 <td>
                        <i class="fas fa-pen-square" data-bs-toggle="modal" data-bs-target="#editRow"></i>
                        <i class="fas fa-minus-square" data-bs-toggle="modal" data-bs-target="#deleteRow"></i>
                    </td>
	</tr>
	<%
	count++;
	%>
</c:forEach>