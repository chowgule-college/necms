package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

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

	public List<MainEvent> getMainEvents(String searchCategory, String searchStr, String orderCategory,
			String orderType) {
		List<MainEvent> meList = getAllMainEvents();

		meList = getMainEventBySearch(searchCategory, searchStr, meList);

		meList = getMainEventByOrder(orderCategory, orderType, meList);

		return meList;
	}

	public List<MainEvent> getMainEventBySearch(String searchCategory, String searchStr, List<MainEvent> meList) {
		List<MainEvent> sortedMeList = new ArrayList<MainEvent>();

		if (searchCategory.equals("NAME")) {
			for (int i = 0; i < meList.size(); i++) {
				if (meList.get(i).getMe_name().toLowerCase().contains(searchStr.toLowerCase()))
					sortedMeList.add(meList.get(i));
			}
		}
		if (searchCategory.equals("DATE")) {
			for (int i = 0; i < sortedMeList.size(); i++) {
				if (sortedMeList.get(i).getMe_date().toString().contains(searchStr))
					sortedMeList.add(meList.get(i));
			}
		}
		if (searchCategory.equals("ID")) {
			for (int i = 0; i < sortedMeList.size(); i++) {
				if (String.valueOf(sortedMeList.get(i).getMe_id()).contains(searchStr))
					sortedMeList.add(meList.get(i));
			}
		}

		return sortedMeList;
	}

	public List<MainEvent> getMainEventByOrder(String orderCategory, String orderType, List<MainEvent> meList) {
		List<MainEvent> orderedMeList = meList;

		if (orderType.equals("ASCENDING")) {
			if (orderCategory.equals("NAME")) {
				Collections.sort(orderedMeList, new Comparator<MainEvent>() {
					public int compare(MainEvent o1, MainEvent o2) {
						return o1.getMe_name().compareTo(o2.getMe_name());
					}});
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
				        }
				        else if (o1.getMe_id() < o2.getMe_id()) {
				            return -1;
				        }
				        else {
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
						return -o1.getMe_name().compareTo(o2.getMe_name());
					}});
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
				        }
				        else if (o1.getMe_id() < o2.getMe_id()) {
				            return 1;
				        }
				        else {
				            return -1;
				        }
					}
				});
			}
		}
		

		return orderedMeList;
	}

}
