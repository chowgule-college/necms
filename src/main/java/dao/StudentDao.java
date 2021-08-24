package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import entity.Participant;
import entity.Student;

public class StudentDao {
	private Connection con;

	public StudentDao(Connection con) {
		super();
		this.con = con;
	}

	private Student getObject(ResultSet rs) throws SQLException {
		return new Student(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
	}

	public List<Student> fetch(List<Participant> participants) {
		boolean initiateListFlag = false;
		List<Student> students = null;
		if (participants != null) {
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
						students.add(getObject(rs));
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return students;
	}

	public List<Student> fetchWithSearchAndOrder(List<Participant> participants, String searchCategory,
			String searchStr, String orderCategory, String orderType) {
		List<Student> studentList = fetch(participants);
		if (studentList != null) {
			studentList = sortBySearch(searchCategory, searchStr, studentList);
			studentList = sortByOrder(orderCategory, orderType, studentList);
		}
		return studentList;
	}

	public List<Student> sortBySearch(String searchCategory, String searchStr, List<Student> studentList) {
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

	public List<Student> sortByOrder(String orderCategory, String orderType, List<Student> studentList) {
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

	public Student fetchByRollNo(String s_rollno) {
		String query = "select * from student where rollno = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, s_rollno);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return getObject(rs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Student> fetchByRollNoList(String[] s_rollnoList) {
		boolean initiateListFlag = false;
		List<Student> students = null;
		if (s_rollnoList.length > 0) {
			String list = "'" + s_rollnoList[0] + "'";
			if (s_rollnoList.length > 1) {
				for (int i = 1; i < s_rollnoList.length; i++) {
					list += " ,'" + s_rollnoList[i] + "'";
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
					students.add(getObject(rs));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return students;
	}

	public List<Student> fetchWithoutParticipant(String[] s_rollnoList, List<Participant> pList) {
		List<Student> students = fetchByRollNoList(s_rollnoList);
		if (students != null && pList != null) {
			List<Student> temp = students;
			for (int i = 0; i < temp.size(); i++) {
				for (int j = 0; j < pList.size(); j++) {
					if (temp.get(i).getS_rollno().equalsIgnoreCase(pList.get(j).getP_rollno())) {
						for (int k = 0; k < students.size(); k++) {
							if (students.get(k).getS_rollno().equalsIgnoreCase(pList.get(j).getP_rollno())) {
								students.remove(k);
							}
						}
					}
				}
			}
		}
		return students;
	}
}
