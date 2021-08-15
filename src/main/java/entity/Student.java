package entity;

public class Student {

	/* These are names of column and table from the database */
	public static final String S_TNAME = "student";
	public static final String S_ROLLNO = "rollno";
	public static final String S_NAME = "full_name";
	public static final String S_COURSE = "course_name";
	public static final String S_YEAR = "";

	private String s_rollno;
	private String s_name;
	private String s_course;
	private String s_year;

	public Student() {
	}

	public Student(String s_rollno, String s_name, String s_course) {
		super();
		this.s_rollno = s_rollno;
		this.s_name = s_name;
		this.s_course = s_course;
		this.s_year = "";
	}

	public String getS_rollno() {
		return s_rollno;
	}

	public void setS_rollno(String s_rollno) {
		this.s_rollno = s_rollno;
	}

	public String getS_name() {
		return s_name;
	}

	public void setS_name(String s_name) {
		this.s_name = s_name;
	}

	public String getS_course() {
		return s_course;
	}

	public void setS_course(String s_course) {
		this.s_course = s_course;
	}

	public String getS_year() {
		return s_year;
	}

	public void setS_year(String s_year) {
		this.s_year = s_year;
	}
}
