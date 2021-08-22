package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Response;

import dao.ParticipantDao;
import helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterBulkParticipants
 */
public class RegisterBulkParticipants extends HttpServlet {
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String s_rollno = request.getParameter("s_rollnoList").trim();
		String[] s_rollnoList = s_rollno.split(" ");
		int me_id = Integer.parseInt(request.getParameter("me_id"));
		int se_id = Integer.parseInt(request.getParameter("se_id"));
		ParticipantDao dao = new ParticipantDao(ConnectionProvider.getConnection());
		if (dao.addBulkParticipants(se_id, me_id, s_rollnoList)) {
			response.setContentType("text/html");
			response.getWriter().println("1");
		}
	}

}
