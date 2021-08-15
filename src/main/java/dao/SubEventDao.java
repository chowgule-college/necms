package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import entity.SubEvent;

public class SubEventDao {

	private Connection con;

	public SubEventDao(Connection con) {
		super();
		this.con = con;
	}
	
	private SubEvent generateSEClass(ResultSet rs) throws SQLException {
		return new SubEvent(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4));
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
	
	
	//for this to function add cascade on  delete on database server
	public boolean removeSEventById(int se_id) {
		String query = "delete from sub_event where se_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, se_id);
			ps.execute();
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public List<SubEvent> getAllSubEventByMainEvent(int me_id) {
		List<SubEvent> se_list = null;
		boolean initiateListFlag = false;
		String query = "select * from sub_event where se_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, me_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (!(initiateListFlag)) {
					se_list = new ArrayList<SubEvent>();
					initiateListFlag = true;
				}
				se_list.add(generateSEClass(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return se_list;
	}
}
