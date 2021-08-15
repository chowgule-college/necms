package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ParticipantDao;
import helper.ConnectionProvider;

public class RemoveParticipantByRollNo extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		ParticipantDao dao = new ParticipantDao(ConnectionProvider.getConnection());
		if (dao.removeParticipantByRollNo(request.getParameter("p_rollno")))
			out.println("sucess!");
		else 
			out.println("error!");
	}
}
