package dao;

import static db.JDBCUtil.*;

import java.sql.*;
import java.util.ArrayList;

import bean.CommentBean;
import bean.LikeBean;

public class LikeDAO {
	// singleton
	private static LikeDAO likeDAO;
	private LikeDAO() {
		
	}
	
	// MemberDAO 인스턴스 생성 메소드
	public static LikeDAO getInstance() {
		if(likeDAO==null) {
			likeDAO = new LikeDAO();
		}
		
		return likeDAO;
	}
	
	// db 설정용 필드
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// db 연결 메소드
	public void setConnection(Connection con) {
		this.con = con;
	}

	public ArrayList<LikeBean> getMemberLike(String memberID) {
		String sql = "SELECT * FROM LIKED WHERE MEMBER_ID = ?"; 
		/*"SELECT * FROM LIKED INNER JOIN BOARD ON LIKED.MEMBER_ID = BOARD.MEMBER_ID WHERE LIKED.MEMBER_ID = ?"*/
		
		ArrayList<LikeBean> likeList = new ArrayList<LikeBean>();
		System.out.println("LikeDAO 로 넘어온 memberID의 값 : "+memberID);
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberID);
			rs = pstmt.executeQuery();
			
			int i=1;
			while(rs.next()) {
				LikeBean likeBean = new LikeBean();
				likeBean.setBOARD_NUM(rs.getInt("BOARD_NUM"));
				likeBean.setMEMBER_ID(rs.getString("MEMBER_ID"));
				likeBean.setLIKE_NUM(rs.getInt("LIKE_NUM"));
				likeList.add(likeBean);
				System.out.println(i+"번째 추천 게시물 저장 완료");
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
		return likeList;
	}



}
