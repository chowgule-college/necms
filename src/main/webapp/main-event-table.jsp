<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.MainEvent"%>
<%@page import="java.util.List"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.MainEventDao"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String searchCategory = request.getParameter("searchCategory");
String searchStr = request.getParameter("searchStr");
String orderCategory = request.getParameter("orderCategory");
String orderType = request.getParameter("orderType");


MainEventDao dao = new MainEventDao(ConnectionProvider.getConnection());
List<MainEvent> meList = dao.getMainEvents(searchCategory, searchStr, orderCategory, orderType);
MainEvent me;
int count = 0;
%>

<c:forEach var="i" begin="1" end="<%=meList.size()%>">
				<%
				me = meList.get(count);
				SimpleDateFormat df = new SimpleDateFormat("yyyy");
				String year = df.format(me.getMe_date());
				%>

				<tr >
					<th scope="row"><%=count%></th>
					<td colspan="2" onclick="loadSubEvent('<%=me.getMe_id()%>','<%=me.getMe_name()%>', '<%= year%>')"><%=me.getMe_name()%></td>
					<td><%=me.getMe_date().toString()%></td>
					<td><%=me.getMe_id()%></td>
					<td>
                        <i class="fas fa-pen-square" data-bs-toggle="modal" data-bs-target="#editRow"></i>
                        <i class="fas fa-minus-square" data-bs-toggle="modal" data-bs-target="#deleteRow"></i>
                    </td>
				</tr>
				<%
				count++;
				%>
			</c:forEach>