package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ParticipantDao;
import helper.ConnectionProvider;

public class RemoveParticipant extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ParticipantDao dao = new ParticipantDao(ConnectionProvider.getConnection());
		if (dao.removeParticipant(Integer.parseInt(request.getParameter("me_id")), Integer.parseInt(request.getParameter("se_id")), request.getParameter("p_rollno"))) {
			response.getWriter().println("1");
		}
	}

}
