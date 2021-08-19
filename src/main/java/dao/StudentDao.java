package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import entity.Participant;
import entity.Student;
import entity.SubEvent;

public class StudentDao {
	private Connection con;
	private int month;
	private int year;

	public StudentDao(Connection con) {
		super();
		this.con = con;
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		this.month = cal.get(Calendar.MONTH);
		this.year = Calendar.getInstance().get(Calendar.YEAR);
	}

	private Student generateStudentClass(ResultSet rs) throws SQLException {
		return new Student(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
	}

	public List<Student> getStudent(List<Participant> participants) {
		boolean initiateListFlag = false;
		List<Student> students = null;
		if (participants.size() > 0) {
			String list = "'" + participants.get(0).getP_rollno() + "'";
			if (participants.size() > 1) {
				for (int i = 1; i < participants.size(); i++) {
					list += " ,'" + participants.get(i).getP_rollno() + "'";
				}
			}

			String query = "select * from student where rollno in (" + list + ")";

			try {
				PreparedStatement ps = con.prepareStatement(query);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					if (!(initiateListFlag)) {
						students = new ArrayList<Student>();
						initiateListFlag = true;
					}
					students.add(generateStudentClass(rs));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return students;
	}

	public List<Student> getStudents(List<Participant> participants, String searchCategory, String searchStr,
			String orderCategory, String orderType) {
		List<Student> studentList = getStudent(participants);

		studentList = getStudentBySearch(searchCategory, searchStr, studentList);

		studentList = getStudentByOrder(orderCategory, orderType, studentList);

		return studentList;
	}

	public List<Student> getStudentBySearch(String searchCategory, String searchStr, List<Student> studentList) {
		List<Student> sortedStudentList = new ArrayList<Student>();

		if (searchCategory.equals("NAME")) {

			for (int i = 0; i < studentList.size(); i++) {

				if (studentList.get(i).getS_name().toLowerCase().contains(searchStr.toLowerCase()))
					sortedStudentList.add(studentList.get(i));
			}
		}
		if (searchCategory.equals("ROLLNO")) {

			for (int i = 0; i < studentList.size(); i++) {
				if (studentList.get(i).getS_rollno().toLowerCase().contains(searchStr.toLowerCase()))
					sortedStudentList.add(studentList.get(i));
			}
		}
		if (searchCategory.equals("YEAR")) {

			for (int i = 0; i < studentList.size(); i++) {

				if (studentList.get(i).getS_year().split("-")[0].toLowerCase().contains(searchStr.toLowerCase()))
					sortedStudentList.add(studentList.get(i));
			}
		}
		if (searchCategory.equals("CLASS")) {

			for (int i = 0; i < studentList.size(); i++) {

				if (studentList.get(i).getS_course().toLowerCase().contains(searchStr.toLowerCase()))
					sortedStudentList.add(studentList.get(i));
			}
		}

		return sortedStudentList;
	}

	public List<Student> getStudentByOrder(String orderCategory, String orderType, List<Student> studentList) {
		List<Student> orderedStudentList = studentList;

		if (orderType.equals("ASCENDING")) {

			if (orderCategory.equals("NAME")) {

				Collections.sort(orderedStudentList, new Comparator<Student>() {
					public int compare(Student o1, Student o2) {
						return o1.getS_name().compareTo(o2.getS_name());
					}
				});
			}
			if (orderCategory.equals("ROLLNO")) {

				Collections.sort(orderedStudentList, new Comparator<Student>() {
					public int compare(Student o1, Student o2) {
						return o1.getS_rollno().compareTo(o2.getS_rollno());
					}
				});
			}
			if (orderCategory.equals("YEAR")) {

				Collections.sort(orderedStudentList, new Comparator<Student>() {
					public int compare(Student o1, Student o2) {
						return o1.getS_year().split("-")[0].compareTo(o2.getS_year().split("-")[0]);
					}
				});
			}
			if (orderCategory.equals("CLASS")) {

				Collections.sort(orderedStudentList, new Comparator<Student>() {
					public int compare(Student o1, Student o2) {
						return o1.getS_course().compareTo(o2.getS_course());
					}
				});
			}

		}

		if (orderType.equals("DESCENDING")) {

			if (orderCategory.equals("NAME")) {

				Collections.sort(orderedStudentList, new Comparator<Student>() {
					public int compare(Student o1, Student o2) {
						return -o1.getS_name().compareTo(o2.getS_name());
					}
				});
			}
			if (orderCategory.equals("ROLLNO")) {

				Collections.sort(orderedStudentList, new Comparator<Student>() {
					public int compare(Student o1, Student o2) {
						return -o1.getS_rollno().compareTo(o2.getS_rollno());
					}
				});
			}
			if (orderCategory.equals("YEAR")) {

				Collections.sort(orderedStudentList, new Comparator<Student>() {
					public int compare(Student o1, Student o2) {
						return -o1.getS_year().split("-")[0].compareTo(o2.getS_year().split("-")[0]);
					}
				});
			}
			if (orderCategory.equals("CLASS")) {

				Collections.sort(orderedStudentList, new Comparator<Student>() {
					public int compare(Student o1, Student o2) {
						return -o1.getS_course().compareTo(o2.getS_course());
					}
				});
			}

		}

		return orderedStudentList;
	}

}
