package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.SubEventDao;
import entity.SubEvent;
import helper.ConnectionProvider;

public class RegisterSubEvent extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("./index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		SubEventDao dao = new SubEventDao(ConnectionProvider.getConnection());
		if (dao.insert(new SubEvent(request.getParameter("se_name"), Integer.parseInt(request.getParameter("se_hours")),
				Integer.parseInt(request.getParameter("me_id")))))
			out.println("success!");
		else
			out.println("error!");
	}

}
