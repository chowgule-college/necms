package entity;

public class Participant {

	/* These are names of column and table from the database */
	public static final String P_TNAME = "participant";
	public static final String P_MEID = MainEvent.ME_ID;
	public static final String P_SEID = SubEvent.SE_ID;
	public static final String P_ID = "participant_id";
	public static final String P_ROLLNO = "rollno";

	private int me_id;
	private int se_id;
	private int p_id;
	private String p_rollno;

	public Participant() {
	}

	public Participant(String roll_no) {
		this.p_rollno = roll_no;
	}

	public String getRoll_no() {
		return p_rollno;
	}

	public Participant(int event_id, int sevent_id, int participant_id, String roll_no) {
		super();
		this.me_id = event_id;
		this.se_id = sevent_id;
		this.p_id = participant_id;
		this.p_rollno = roll_no;
	}

	public int getEvent_id() {
		return me_id;
	}

	public void setEvent_id(int event_id) {
		this.me_id = event_id;
	}

	public int getSevent_id() {
		return se_id;
	}

	public void setSevent_id(int sevent_id) {
		this.se_id = sevent_id;
	}

	public int getParticipant_id() {
		return p_id;
	}

	public void setParticipant_id(int participant_id) {
		this.p_id = participant_id;
	}
}
