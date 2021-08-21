package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import entity.Participant;

public class ParticipantDao {
	private Connection con;

	public ParticipantDao(Connection con) {
		super();
		this.con = con;
	}
	
	private Participant generateParticipantClass(ResultSet rs) throws SQLException {
		return new Participant(rs.getString(1), rs.getInt(2), rs.getInt(3));
	}
	
	public boolean insert(Participant p) {
		String query = " insert into participant (p_rollno, se_id, me_id) values(?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, p.getP_rollno());
			ps.setInt(2, p.getSe_id());
			ps.setInt(3, p.getMe_id());
			ps.execute();
			return true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean removeParticipantByRollNo(String p_rollno) {
		String query = "delete from participant where p_rollno = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, p_rollno);
			ps.execute();
			
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public List<Participant> getAllParticipantBySubAndMainEvent(int se_id, int me_id) {
		List<Participant> me_list = null;
		boolean initiateListFlag = false;
		String query = "select * from participant where se_id = ? and me_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, se_id);
			ps.setInt(2, me_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (!(initiateListFlag)) {
					me_list = new ArrayList<Participant>();
					initiateListFlag = true;
				}
				me_list.add(generateParticipantClass(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return me_list;
	}
}
