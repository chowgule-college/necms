package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import entity.SubEvent;

public class SubEventDao {

	private Connection con;

	public SubEventDao(Connection con) {
		this.con = con;
	}

	private SubEvent getObject(ResultSet rs) throws SQLException {
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

	// for this to function add cascade on delete on database server
	public boolean remove(int se_id, int me_id) {
		String query = "delete from sub_event where se_id = ? and me_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, se_id);
			ps.setInt(2, me_id);
			ps.execute();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean update(int me_id, int se_id, String se_name, int se_hours) {
		String query = "update sub_event set se_name = ?, se_hours = ? where me_id = ? and se_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, se_name);
			ps.setInt(2, se_hours);
			ps.setInt(3, me_id);
			ps.setInt(4, se_id);
			ps.execute();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<SubEvent> fetch(int me_id) {
		List<SubEvent> se_list = null;
		boolean initiateListFlag = false;
		String query = "select * from sub_event where me_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, me_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (!(initiateListFlag)) {
					se_list = new ArrayList<SubEvent>();
					initiateListFlag = true;
				}
				se_list.add(getObject(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return se_list;
	}

	public List<SubEvent> fetchWithSearchAndOrder(int me_id, String searchCategory, String searchStr,
			String orderCategory, String orderType) {
		List<SubEvent> seList = fetch(me_id);
		if (seList != null) {
			seList = sortBySearch(searchCategory, searchStr, seList);
			seList = sortByOrder(orderCategory, orderType, seList);
		}
		return seList;
	}

	public List<SubEvent> sortBySearch(String searchCategory, String searchStr, List<SubEvent> seList) {
		List<SubEvent> sortedSeList = new ArrayList<SubEvent>();
		if (searchCategory.equals("NAME")) {
			for (int i = 0; i < seList.size(); i++) {
				if (seList.get(i).getSe_name().toLowerCase().contains(searchStr.toLowerCase()))
					sortedSeList.add(seList.get(i));
			}
		}
		if (searchCategory.equals("HOURS")) {
			for (int i = 0; i < seList.size(); i++) {
				if (String.valueOf(seList.get(i).getSe_hours()).contains(searchStr))
					sortedSeList.add(seList.get(i));
			}
		}
		if (searchCategory.equals("ID")) {
			for (int i = 0; i < seList.size(); i++) {
				if (String.valueOf(seList.get(i).getSe_id()).contains(searchStr))
					sortedSeList.add(seList.get(i));
			}
		}
		return sortedSeList;
	}

	public List<SubEvent> sortByOrder(String orderCategory, String orderType, List<SubEvent> meList) {
		List<SubEvent> orderedMeList = meList;
		if (orderType.equals("ASCENDING")) {
			if (orderCategory.equals("NAME")) {
				Collections.sort(orderedMeList, new Comparator<SubEvent>() {
					public int compare(SubEvent o1, SubEvent o2) {
						return o1.getSe_name().compareTo(o2.getSe_name());
					}
				});
			}
			if (orderCategory.equals("HOURS")) {
				Collections.sort(orderedMeList, new Comparator<SubEvent>() {
					public int compare(SubEvent o1, SubEvent o2) {
						if (o1.getSe_hours() == o2.getSe_hours()) {
							return 0;
						} else if (o1.getSe_hours() < o2.getSe_hours()) {
							return -1;
						} else {
							return 1;
						}
					}
				});

			}
			if (orderCategory.equals("ID")) {
				Collections.sort(orderedMeList, new Comparator<SubEvent>() {
					public int compare(SubEvent o1, SubEvent o2) {
						if (o1.getSe_id() == o2.getSe_id()) {
							return 0;
						} else if (o1.getSe_id() < o2.getSe_id()) {
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
				Collections.sort(orderedMeList, new Comparator<SubEvent>() {
					public int compare(SubEvent o1, SubEvent o2) {
						return -o1.getSe_name().compareTo(o2.getSe_name());
					}
				});
			}
			if (orderCategory.equals("HOURS")) {
				Collections.sort(orderedMeList, new Comparator<SubEvent>() {
					public int compare(SubEvent o1, SubEvent o2) {
						if (o1.getSe_hours() == o2.getSe_hours()) {
							return 0;
						} else if (o1.getSe_hours() < o2.getSe_hours()) {
							return 1;
						} else {
							return -1;
						}
					}
				});
			}
			if (orderCategory.equals("ID")) {
				Collections.sort(orderedMeList, new Comparator<SubEvent>() {
					public int compare(SubEvent o1, SubEvent o2) {
						if (o1.getSe_id() == o2.getSe_id()) {
							return 0;
						} else if (o1.getSe_id() < o2.getSe_id()) {
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
}
