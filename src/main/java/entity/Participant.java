package entity;

public class Participant {

	/* These are names of column and table from the database */
	public static final String P_TNAME = "participant";
	public static final String P_MEID = MainEvent.ME_ID;
	public static final String P_SEID = SubEvent.SE_ID;
	public static final String P_ROLLNO = "p_rollno";
	
	private String p_rollno;
	private int se_id;
	private int me_id;

	public Participant() {
	}

	public Participant(String p_rollno, int se_id, int me_id) {
		super();
		this.p_rollno = p_rollno;
		this.se_id = se_id;
		this.me_id = me_id;
	}

	public String getP_rollno() {
		return p_rollno;
	}

	public void setP_rollno(String p_rollno) {
		this.p_rollno = p_rollno;
	}

	public int getSe_id() {
		return se_id;
	}

	public void setSe_id(int se_id) {
		this.se_id = se_id;
	}

	public int getMe_id() {
		return me_id;
	}

	public void setMe_id(int me_id) {
		this.me_id = me_id;
	}

}
