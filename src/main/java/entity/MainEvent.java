package entity;

import java.sql.Date;

public class MainEvent {

	/* These are names of column and table from the database */
	public static final String ME_TNAME = "main_event";
	public static final String ME_ID = "me_id";
	public static final String ME_NAME = "me_name";
	public static final String ME_DATE = "me_date";

	private int me_id;
	private String me_name;
	private Date me_date;

	public MainEvent() {
	}

	public MainEvent(int me_id, String me_name, Date me_date) {
		super();
		this.me_id = me_id;
		this.me_name = me_name;
		this.me_date = me_date;
	}

	public MainEvent(String me_name, Date me_date) {
		super();
		this.me_name = me_name;
		this.me_date = me_date;
	}

	public int getMe_id() {
		return me_id;
	}

	public void setMe_id(int me_id) {
		this.me_id = me_id;
	}

	public String getMe_name() {
		return me_name;
	}

	public void setMe_name(String me_name) {
		this.me_name = me_name;
	}

	public Date getMe_date() {
		return me_date;
	}

	public void setMe_date(Date me_date) {
		this.me_date = me_date;
	}

	@Override
	public String toString() {
		return "MainEvent [me_id=" + me_id + ", me_name=" + me_name + ", me_date=" + me_date + "]";
	}

	

}
