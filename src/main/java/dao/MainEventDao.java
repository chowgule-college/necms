package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.MainEvent;

public class MainEventDao {
	private Connection con;
	
	public MainEventDao(Connection con) {
		super();
		this.con = con;
	}
	
	private MainEvent generateMEClass(ResultSet rs) throws SQLException {
		return new MainEvent(rs.getInt(1), rs.getString(2), rs.getDate(3));
	}

	public boolean insert(MainEvent me) {
		String query = "insert into main_event(me_name, me_date) values(?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, me.getMe_name());
			ps.setDate(2, me.getMe_date());
			ps.execute();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// for this to function add cascade on delete on database server
	public boolean removeMEventById(int me_id) {
		String query = "delete from main_even where me_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, me_id);
			ps.execute();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public List<MainEvent> getAllMainEvents() {
		List<MainEvent> me_list = null;
		boolean initiateListFlag = false;
		String query = "select * from main_event";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (!(initiateListFlag)) {
					me_list = new ArrayList<MainEvent>();
					initiateListFlag = true;
				}
				me_list.add(generateMEClass(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return me_list;
	}
}
