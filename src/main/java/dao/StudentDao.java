package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Participant;
import entity.Student;

public class StudentDao {
	private Connection con;

	public StudentDao(Connection con) {
		super();
		this.con = con;
	}

	private Student generateStudentClass(ResultSet rs) throws SQLException {
		return new Student(rs.getString(1), rs.getString(2), rs.getString(3));
	}

	public List<Student> getStudent(List<Participant> participants) {
		boolean initiateListFlag = false;
		List<Student> students = null;
		if(participants.size() > 0) {
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
}
