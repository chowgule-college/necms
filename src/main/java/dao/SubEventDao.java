package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import entity.SubEvent;

public class SubEventDao {

	private Connection con;

	public SubEventDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean insert(SubEvent se) {
		String query = "insert into sub_event(se_name, se_hours, me_id) values(?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, se.getSe_name());
			ps.setInt(2, se.getSe_hours());
			ps.setInt(3, se.getMe_id());
			ps.execute();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
