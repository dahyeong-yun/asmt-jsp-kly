package dao;

import static db.JDBCUtil.*;

import java.sql.*;
import java.util.ArrayList;

import bean.BoardBean;
import bean.CommentBean;
import bean.LikeBean;
import bean.MemberBean;

public class CommentDAO {
	// singleton
	private static CommentDAO commentDAO;
	private CommentDAO() {
		
	}
	
	// MemberDAO 인스턴스 생성 메소드
	public static CommentDAO getInstance() {
		if(commentDAO==null) {
			commentDAO = new CommentDAO();
		}
		
		return commentDAO;
	}
	
	// db 설정용 필드
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// db 연결 메소드
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	public ArrayList<CommentBean> getCommentList() {
		return null;
	}
	
	// 해당 아이디의 댓글 전체 가져오기
	public ArrayList<CommentBean> getMemberComment(String memberID) {
		String sql = "SELECT * FROM BOARD_COMMENT WHERE MEMBER_ID = ?";
		
		ArrayList<CommentBean> commentList = new ArrayList<CommentBean>();
		System.out.println("BoardDAO 로 넘어온 boardID의 값 : "+memberID);
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberID);
			rs = pstmt.executeQuery();
			
			int i=1;
			while(rs.next()) {
				CommentBean commentBean = new CommentBean();
				commentBean.setBOARD_NUM(rs.getInt("BOARD_NUM"));
				commentBean.setMEMBER_ID(rs.getString("MEMBER_ID"));
				commentBean.setCOMMENT_NUM(rs.getInt("COMMENT_NUM"));
				commentBean.setCOMMENT_CON(rs.getString("COMMENT_CON"));
				commentBean.setCOMMENT_DATE(rs.getDate("COMMENT_DATE"));
				commentBean.setCOMMENT_BLIND(rs.getInt("COMMENT_BLIND"));
				commentList.add(commentBean);
				System.out.println(i+"번째 댓글 저장 완료");
				i++;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(pstmt);
				close(rs);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return commentList;
	}

	public ArrayList<CommentBean> getSuependCommentList() {
		String sql = "SELECT * FROM BOARD_COMMENT WHERE COMMENT_BLIND > 3";
		
		ArrayList<CommentBean> commentList = new ArrayList<CommentBean>();
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommentBean comment = new CommentBean();
				comment.setBOARD_NUM(rs.getInt("BOARD_NUM"));
				comment.setMEMBER_ID(rs.getString("MEMBER_ID"));
				comment.setCOMMENT_NUM(rs.getInt("COMMENT_NUM"));
				comment.setCOMMENT_CON(rs.getString("COMMENT_CON"));
				comment.setCOMMENT_DATE(rs.getDate("COMMENT_DATE"));
				comment.setCOMMENT_BLIND(rs.getInt("COMMENT_BLIND"));
				commentList.add(comment);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(pstmt);
				close(rs);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return commentList;
	}

}
