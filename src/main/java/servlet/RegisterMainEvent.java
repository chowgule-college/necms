package servlet;

import java.io.IOException;

import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MainEventDao;
import entity.MainEvent;
import helper.ConnectionProvider;

public class RegisterMainEvent extends HttpServlet {

	public RegisterMainEvent() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("./index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MainEventDao dao = new MainEventDao(ConnectionProvider.getConnection());
		if (dao.insert(new MainEvent(request.getParameter("me_name"), Date.valueOf(request.getParameter("me_date")))))
			response.getWriter().println("1");
	}

}
