package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ParticipantDao;
import dao.StudentDao;
import entity.Participant;
import entity.Student;
import helper.ConnectionProvider;

public class CheckStudent extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("index.html");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int me_id = Integer.parseInt(request.getParameter("me_id"));
		int se_id = Integer.parseInt(request.getParameter("se_id"));
		boolean exists = false;
		ParticipantDao pDao = new ParticipantDao(ConnectionProvider.getConnection());
		List<Participant> pList = pDao.fetch(se_id, me_id);
		if (pList != null) {
			for (Participant p : pList) {
				if (p.getP_rollno().equalsIgnoreCase(request.getParameter("s_rollno"))) {
					exists = true;
				}
			}
		}
		if (exists) {
			response.getWriter().println("1");
		} else {
			StudentDao dao = new StudentDao(ConnectionProvider.getConnection());
			Student student = dao.fetchByRollNo(request.getParameter("s_rollno"));
			response.setContentType("text/html");
			if (student != null) {
				response.getWriter().println(student.getS_name());
			} else {
				response.getWriter().println("0");
			}
		}
	}

}
