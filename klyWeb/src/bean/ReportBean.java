package bean;

import java.util.Date;

public class ReportBean {
	private String MEMBER_ID;
	private int BOARD_NUM;	//글 번호
	private int REPORT_NUM;	//신고 번호
	private int REPORT_COUNT;	//신고 횟수
	private Date REPORT_DATE;	//신고 시간
	
	private String BOARD_URL;	//동영상 URL
	private String BOARD_SUBJECT;	//글제목
	
	public String getMEMBER_ID() {
		return MEMBER_ID;
	}
	public void setMEMBER_ID(String mEMBER_ID) {
		MEMBER_ID = mEMBER_ID;
	}
	public int getBOARD_NUM() {
		return BOARD_NUM;
	}
	public void setBOARD_NUM(int bOARD_NUM) {
		BOARD_NUM = bOARD_NUM;
	}
	public int getREPORT_NUM() {
		return REPORT_NUM;
	}
	public void setREPORT_NUM(int rEPORT_NUM) {
		REPORT_NUM = rEPORT_NUM;
	}
	public int getREPORT_COUNT() {
		return REPORT_COUNT;
	}
	public void setREPORT_COUNT(int rEPORT_COUNT) {
		REPORT_COUNT = rEPORT_COUNT;
	}
	public Date getREPORT_DATE() {
		return REPORT_DATE;
	}
	public void setREPORT_DATE(Date rEPORT_DATE) {
		REPORT_DATE = rEPORT_DATE;
	}
	public String getBOARD_URL() {
		return BOARD_URL;
	}
	public void setBOARD_URL(String bOARD_URL) {
		BOARD_URL = bOARD_URL;
	}
	public String getBOARD_SUBJECT() {
		return BOARD_SUBJECT;
	}
	public void setBOARD_SUBJECT(String bOARD_SUBJECT) {
		BOARD_SUBJECT = bOARD_SUBJECT;
	}
	
	
}
