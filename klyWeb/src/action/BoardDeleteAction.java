package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import bean.BoardBean;
import service.BoardDeleteService;
import service.BoardListService;

public class BoardDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardBean boardBean = new BoardBean();
		response.setContentType("text/html;charset=UTF-8");
		String member_id = request.getParameter("member_id");
		int board_num = Integer.parseInt(request.getParameter("board_num")); // 받아온 값을 저장
		System.out.println(board_num + member_id);
		boardBean.setMEMBER_ID(member_id);
		boardBean.setBOARD_NUM(board_num);// 쿼리문 전송을 위한 세팅
		ActionForward actionForward = null;
		BoardListService boardlistservice = new BoardListService();
		BoardDeleteService boardDeleteService = new BoardDeleteService(); // 객체 선언
		ArrayList<BoardBean> boardList = boardlistservice.getboardList(); // 객체 배열 선언
		boolean deleteResult = false;
		PrintWriter out = response.getWriter();

		for (int i = 0; i < boardList.size(); i++) {
			if (board_num == boardList.get(i).getBOARD_NUM() && member_id.equals(boardList.get(i).getMEMBER_ID())) {
				deleteResult=boardDeleteService.deleteService(boardBean);
				if (deleteResult == true) {
					boardDeleteService.deleteService(boardBean); // 삭제할 게시글 번호와 db에서 받아온 게시글 번호 비교 하고
					out.println("<script>"); // 로그인중인 id와 db에서 받아온 작성자 id 비교
					out.println("alert('삭제되었습니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
				}else {
					deleteResult = false;
					out.println("<script>");
					out.println("alert('삭제 권한이 없습니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
				}
			}
		}
		out.println("<script>");
		out.println("alert('삭제 권한이 없습니다.');");
		out.println("location.href='./boardList.kly';");
		out.println("</script>");
		return actionForward;
	}

}
