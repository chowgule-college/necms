package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MainEventDao;
import helper.ConnectionProvider;

public class RemoveMainEvent extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MainEventDao dao = new MainEventDao(ConnectionProvider.getConnection());
		if (dao.remove(Integer.parseInt(request.getParameter("me_id"))))
			response.getWriter().println("1");
	}

}
