package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import entity.MainEvent;

public class MainEventDao {
	private Connection con;

	public MainEventDao(Connection con) {
		super();
		this.con = con;
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
	
	//for this to function add cascade on  delete on database server
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
}
