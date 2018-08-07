package service;

import static db.JDBCUtil.close;
import static db.JDBCUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.BoardDAO;
import bean.BoardBean;
import bean.ReportBean;

public class BoardSuspendListService {

	/*public ArrayList<BoardBean> getBoardSuspendList() {
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection con = getConnection();
		boardDAO.setConnection(con);

		ArrayList<BoardBean> boardSuspendList = boardDAO.getboardSuspendList();
		close(con);
		return boardSuspendList;
	}*/
	
	public ArrayList<ReportBean> getReportSuspendList() {
		BoardDAO boardDAO = BoardDAO.getInstance();
		Connection con = getConnection();
		boardDAO.setConnection(con);

		ArrayList<ReportBean> reportSuspendList = boardDAO.getreportSuspendList();
		close(con);
		return reportSuspendList;
	}

}