package service;

import static db.JDBCUtil.close;
import static db.JDBCUtil.commit;
import static db.JDBCUtil.getConnection;
import static db.JDBCUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import bean.LikeBean;
import dao.BoardDAO;

public class BoardViewCountService {
	
	public boolean viewCount(int BOARD_NUM) {
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		boolean countResult = false;

		int result = boardDAO.viewCount(BOARD_NUM);		
		
		if(result != 0) {
			countResult = true;
			commit(con);
		} else {
			rollback(con);
		}
		return countResult;
	}
}
