package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import entity.Participant;

public class ParticipantDao {
	private Connection con;

	public ParticipantDao(Connection con) {
		super();
		this.con = con;
	}
	
	public boolean insert(Participant p) {
		String query = " insert into participant (p_rollno, se_id, me_id) values(?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, p.getP_rollno());
			ps.setInt(2, p.getSe_id());
			ps.setInt(3, p.getSe_id());
			ps.execute();
			return true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
