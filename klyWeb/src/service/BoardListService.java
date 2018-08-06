package service;

import static db.JDBCUtil.getConnection;

import static db.JDBCUtil.close;


import java.sql.Connection;
import java.util.ArrayList;

import bean.BoardBean;
import dao.BoardDAO;

public class BoardListService {
	public ArrayList<BoardBean> getboardList() {
			
			Connection con = getConnection();
			BoardDAO boardDAO = BoardDAO.getInstance();
			boardDAO.setConnection(con);
			
			ArrayList<BoardBean> boardlist = boardDAO.getboardlist();
			close(con);
			return boardlist;
		}
	public ArrayList<BoardBean> getboardlist(int page, int limit){
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		ArrayList<BoardBean> boardlist = boardDAO.getboardList(page, limit);
		close(con);
		return boardlist;
	}
	/** */
	public ArrayList<BoardBean> getReadList(BoardBean category, int page, int limit) {
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		ArrayList<BoardBean> boardlist = boardDAO.getReadList(category,page,limit);
		close(con);
		return boardlist;
	}
	public ArrayList<BoardBean> getLikeList(BoardBean category, int page, int limit) {
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		
		ArrayList<BoardBean> boardlist = boardDAO.getLikeList(category,page,limit);
		close(con);
		return boardlist;
	}
	
	public ArrayList<BoardBean> getCategory(BoardBean category, int page, int limit) {
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		
		ArrayList<BoardBean> boardList = boardDAO.getCategory(category,page,limit);
		close(con);
		return boardList;
	}
	public int getListCategoryCount(BoardBean category) {

		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int listCount =0;
		listCount = boardDAO.getListCategoryCount(category);
		close(con);
		return listCount;
	}
	public int getListSearchCount(BoardBean search) {

		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int listCount =0;
		listCount = boardDAO.getListSearchCount(search);
		close(con);
		return listCount;
	}
	public int getListCount(BoardBean category) {
 
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int listCount =0;
		listCount = boardDAO.getListCount(category);
		close(con);
		return listCount;
	}
	
	
}
