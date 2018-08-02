package service;

import static db.JDBCUtil.close;
import static db.JDBCUtil.commit;
import static db.JDBCUtil.getConnection;
import static db.JDBCUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import bean.MemberBean;
import dao.MemberDAO;

public class MemberSuspendService {

	public boolean memberSuspend(String iD, String whatDay) {
		MemberDAO memberDAO = MemberDAO.getInstance();
		Connection con = getConnection();
		memberDAO.setConnection(con);

		boolean modifyResult = false;

		int result = memberDAO.memberSuspend(iD, whatDay);

		if (result != 0) {
			modifyResult = true;
			commit(con);
		} else {
			rollback(con);
		}

		close(con);
		return modifyResult;

	}

}