package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SubEventDao;
import helper.ConnectionProvider;

/**
 * Servlet implementation class RemoveSubEvent
 */
public class RemoveSubEvent extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		SubEventDao dao = new SubEventDao(ConnectionProvider.getConnection());
		if (dao.remove(Integer.parseInt(request.getParameter("se_id")),
				Integer.parseInt(request.getParameter("me_id"))))
			response.getWriter().println("1");
	}

}
