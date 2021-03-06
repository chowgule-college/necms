package dao;

import java.sql.Connection;
import java.sql.*;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import entity.MainEvent;

public class MainEventDao {
	private Connection con;

	public MainEventDao(Connection con) {
		this.con = con;
	}

	private MainEvent getObject(ResultSet rs) throws SQLException {
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
	public boolean remove(int me_id) {
		String query = "delete from main_event where me_id = ?";
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

	public boolean update(int me_id, String me_name, Date me_date) {
		String query = "update main_event set me_name = ?, me_date = ? where me_id = ? ";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, me_name);
			ps.setDate(2, me_date);
			ps.setInt(3, me_id);
			ps.execute();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<MainEvent> fetch() {
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
				me_list.add(getObject(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return me_list;
	}

	public List<MainEvent> fetchWithSearchAndOrder(String searchCategory, String searchStr, String orderCategory,
			String orderType) {
		List<MainEvent> meList = fetch();
		if (meList != null) {
			meList = sortBySearch(searchCategory, searchStr, meList);
			meList = sortByOrder(orderCategory, orderType, meList);
		}
		return meList;
	}

	public List<MainEvent> sortBySearch(String searchCategory, String searchStr, List<MainEvent> meList) {
		List<MainEvent> sortedMeList = new ArrayList<MainEvent>();
		if (searchCategory.equals("NAME")) {
			for (int i = 0; i < meList.size(); i++) {
				if (meList.get(i).getMe_name().toLowerCase().contains(searchStr.toLowerCase()))
					sortedMeList.add(meList.get(i));
			}
		}
		if (searchCategory.equals("DATE")) {
			for (int i = 0; i < meList.size(); i++) {
				if (meList.get(i).getMe_date().toString().contains(searchStr))
					sortedMeList.add(meList.get(i));
			}
		}
		if (searchCategory.equals("ID")) {
			for (int i = 0; i < meList.size(); i++) {
				if (String.valueOf(meList.get(i).getMe_id()).contains(searchStr))
					sortedMeList.add(meList.get(i));
			}
		}
		return sortedMeList;
	}

	public List<MainEvent> sortByOrder(String orderCategory, String orderType, List<MainEvent> meList) {
		List<MainEvent> orderedMeList = meList;
		if (orderType.equals("ASCENDING")) {
			if (orderCategory.equals("NAME")) {
				Collections.sort(orderedMeList, new Comparator<MainEvent>() {
					public int compare(MainEvent o1, MainEvent o2) {
						return o1.getMe_name().compareToIgnoreCase(o2.getMe_name());
					}
				});
			}
			if (orderCategory.equals("DATE")) {
				Collections.sort(orderedMeList, new Comparator<MainEvent>() {
					public int compare(MainEvent o1, MainEvent o2) {
						return o1.getMe_date().toString().compareTo(o2.getMe_date().toString());
					}
				});
			}
			if (orderCategory.equals("ID")) {
				Collections.sort(orderedMeList, new Comparator<MainEvent>() {
					public int compare(MainEvent o1, MainEvent o2) {
						if (o1.getMe_id() == o2.getMe_id()) {
							return 0;
						} else if (o1.getMe_id() < o2.getMe_id()) {
							return -1;
						} else {
							return 1;
						}
					}
				});
			}
		}
		if (orderType.equals("DESCENDING")) {
			if (orderCategory.equals("NAME")) {
				Collections.sort(orderedMeList, new Comparator<MainEvent>() {
					public int compare(MainEvent o1, MainEvent o2) {
						return -o1.getMe_name().compareToIgnoreCase(o2.getMe_name());
					}
				});
			}
			if (orderCategory.equals("DATE")) {
				Collections.sort(orderedMeList, new Comparator<MainEvent>() {
					public int compare(MainEvent o1, MainEvent o2) {
						return -o1.getMe_date().toString().compareTo(o2.getMe_date().toString());
					}
				});
			}
			if (orderCategory.equals("ID")) {
				Collections.sort(orderedMeList, new Comparator<MainEvent>() {
					public int compare(MainEvent o1, MainEvent o2) {
						if (o1.getMe_id() == o2.getMe_id()) {
							return 0;
						} else if (o1.getMe_id() < o2.getMe_id()) {
							return 1;
						} else {
							return -1;
						}
					}
				});
			}
		}
		return orderedMeList;
	}
	
	public HashMap<String, String> getMENameAndDate(int me_id) {
		HashMap<String, String> meNameAndDate = null;
		String query = "select me_name, me_date from main_event where me_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, me_id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				meNameAndDate = new HashMap<String, String>();
				meNameAndDate.put("me_name", rs.getString(1));
				meNameAndDate.put("me_date", rs.getDate(2).toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return meNameAndDate;
	}

}
