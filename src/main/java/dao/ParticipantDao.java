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

	private Participant getObject(ResultSet rs) throws SQLException {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean remove(int me_id, int se_id, String p_rollno) {
		String query = "delete from participant where me_id = ? and se_id = ? and p_rollno = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, me_id);
			ps.setInt(2, se_id);
			ps.setString(3, p_rollno);
			ps.execute();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<Participant> fetch(int se_id, int me_id) {
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
				me_list.add(getObject(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return me_list;
	}

	public boolean insertInBulk(int se_id, int me_id, String[] p_rollnoList) {
		if (p_rollnoList.length > 0) {
			String query = "insert into participant (p_rollno, se_id, me_id) values (?,?,?)";
			if (p_rollnoList.length > 1) {
				for (int i = 1; i < p_rollnoList.length; i++) {
					query += ", (?,?,?)";
				}
			}

			try {
				PreparedStatement ps = con.prepareStatement(query);
				int count = 0;
				for (int i = 1; i <= p_rollnoList.length * 3; i += 3) {
					ps.setString(i, p_rollnoList[count]);
					ps.setInt(i + 1, se_id);
					ps.setInt(i + 2, me_id);
					count++;
				}
				ps.execute();
				return true;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}

	public List<Participant> allParticipations(String rollno) {
		String query = "select * from participant where p_rollno = ?";
		boolean initiateListFlag = false;
		List<Participant> participations = null;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, rollno);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (!(initiateListFlag)) {
					participations = new ArrayList<Participant>();
					initiateListFlag = true;
				}
				participations.add(getObject(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return participations;
	}

}
