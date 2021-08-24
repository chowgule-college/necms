<%@page import="entity.SubEvent"%>
<%@page import="java.util.List"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.SubEventDao"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String searchCategory = request.getParameter("searchCategory");
String searchStr = request.getParameter("searchStr");
String orderCategory = request.getParameter("orderCategory");
String orderType = request.getParameter("orderType");
int me_id = Integer.parseInt(request.getParameter("me_id"));

SubEventDao dao = new SubEventDao(ConnectionProvider.getConnection());
List<SubEvent> seList = dao.fetchWithSearchAndOrder(me_id, searchCategory, searchStr, orderCategory, orderType);
SubEvent se;
int count = 0;
if(seList != null){
%>

<c:forEach var="i" begin="1" end="<%=seList.size()%>">
				<%
				se = seList.get(count);
				count++;
				%>

				<tr >
                    <th scope="row"><%=count %></th>
                    <td class="pointer" colspan="2" onclick="loadParticipant('<%= me_id%>', '<%= se.getSe_id()%>', '<%=se.getSe_name() %>')"><%=se.getSe_name() %></td>
                    <td><%=se.getSe_hours() %></td>
                    <td><%=se.getSe_id() %></td>
                    <td>
                        <i class="fas fa-pen-square" onclick="updateSubEvent('<%=se.getSe_id()%>', '<%=se.getMe_id()%>', '<%=se.getSe_name() %>', '<%=se.getSe_hours() %>')"></i>
                        <i class="fas fa-minus-square" onclick="removeSubEvent('<%=se.getSe_id()%>', '<%=se.getMe_id()%>')"></i>
                    </td>
                </tr>
			</c:forEach>
<%} %>			
