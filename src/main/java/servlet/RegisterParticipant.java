package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ParticipantDao;
import entity.Participant;
import helper.ConnectionProvider;

public class RegisterParticipant extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("./index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		ParticipantDao dao = new ParticipantDao(ConnectionProvider.getConnection());
		if (dao.insert(new Participant(
				request.getParameter("s_rollno"),
				Integer.parseInt(request.getParameter("se_id")),
				Integer.parseInt(request.getParameter("me_id"))
				))) 
			out.println("1");
		else
			out.println("0");
	}

}
