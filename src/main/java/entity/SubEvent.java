package entity;

public class SubEvent {

	/* These are names of column and table from the database */
	public static final String SE_TNAME = "sub_event";
	public static final String SE_ID = "se_id";
	public static final String SE_NAME = "se_name";
	public static final String SE_HOURS = "se_hours";
	public static final String SE_MEID = MainEvent.ME_ID;

	private int se_id;
	private String se_name;
	private int se_hours;
	private int me_id;

	public SubEvent() {
	}

	public SubEvent(int se_id, String se_name, int se_hours, int me_id) {
		super();
		this.se_id = se_id;
		this.se_name = se_name;
		this.se_hours = se_hours;
		this.me_id = me_id;
	}
	
	public SubEvent(String se_name, int se_hours, int me_id) {
		super();
		this.se_name = se_name;
		this.se_hours = se_hours;
		this.me_id = me_id;
	}

	public int getSe_id() {
		return se_id;
	}

	public void setSe_id(int se_id) {
		this.se_id = se_id;
	}

	public String getSe_name() {
		return se_name;
	}

	public void setSe_name(String se_name) {
		this.se_name = se_name;
	}

	public int getSe_hours() {
		return se_hours;
	}

	public void setSe_hours(int se_hours) {
		this.se_hours = se_hours;
	}

	public int getMe_id() {
		return me_id;
	}

	public void setMe_id(int me_id) {
		this.me_id = me_id;
	}

}
