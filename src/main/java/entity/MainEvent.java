package entity;

import java.sql.Date;

public class MainEvent {

	/* These are names of column and table from the database */
	public static final String ME_TNAME = "main_event";
	public static final String ME_ID = "";
	public static final String ME_NAME = "";
	public static final String ME_DATE = "";

	private int me_id;
	private String me_name;
	private Date me_date;

	public MainEvent() {
	}

	public MainEvent(int event_id, String event_name, Date event_date) {
		this.me_id = event_id;
		this.me_name = event_name;
		this.me_date = event_date;
	}

	public int getEvent_id() {
		return me_id;
	}

	public void setEvent_id(int event_id) {
		this.me_id = event_id;
	}

	public String getEvent_name() {
		return me_name;
	}

	public void setEvent_name(String event_name) {
		this.me_name = event_name;
	}

	public Date getEvent_date() {
		return me_date;
	}

	public void setEvent_date(Date event_date) {
		this.me_date = event_date;
	}

}
