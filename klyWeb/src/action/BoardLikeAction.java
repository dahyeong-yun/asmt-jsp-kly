package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import bean.LikeBean;
import service.BoardLikeService;

public class BoardLikeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		LikeBean likeBean = new LikeBean();
		response.setContentType("text/html;charset=UTF-8");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String member_id = request.getParameter("member_id");
		PrintWriter out = response.getWriter();
		if (member_id.equals("")) {
			out.println("<script>");
			out.println("alert('로그인을 해주세요.');"); // 비로그인시 로그인창으로 이동
			out.println("location.href='./boardList.kly';");
			out.println("</script>");
		}
		likeBean.setMEMBER_ID(member_id);
		likeBean.setBOARD_NUM(board_num); // 쿼리문 전송을 위한 세팅
		ActionForward actionForward = null;
		BoardLikeService boardLikeService = new BoardLikeService(); // 객체 선언
		ArrayList<LikeBean> likeList = boardLikeService.getLikeList(); // 객체 배열 선언
		boolean reportResult = false;
		for (int i = 0; i < likeList.size(); i++) {
			if (!(board_num == likeList.get(i).getBOARD_NUM())) {
				reportResult = boardLikeService.likeUpdate(likeBean);
				if (reportResult == true) {
					out.println("<script>");
					out.println("alert('게시물이 추천 되었습니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
				}
			} else {
				if (!member_id.equals(likeList.get(i).getMEMBER_ID())) {
					reportResult = boardLikeService.likeUpdate(likeBean);
					if (reportResult == true) {
						out.println("<script>");
						out.println("alert('게시물이 추천 되었습니다.');");
						out.println("location.href='./boardList.kly';");
						out.println("</script>");
					}
				} else {
					out.println("<script>"); // 받아온 값과 db에서 가져온값을 비교하고 있을 경우 신고되지 않음
					out.println("alert('이미 추천한 게시물 입니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
				}
			}
		}
		if (likeList.size() == 0) {
			reportResult = boardLikeService.likeUpdate(likeBean);
			out.println("<script>");
			out.println("alert('게시물이 추천 되었습니다.');");
			out.println("location.href='./boardList.kly';");
			out.println("</script>");
		}
		out.println("<script>");
		out.println("alert('이미 추천한 게시물 입니다.');");
		out.println("location.href='./boardList.kly';");
		out.println("</script>");
		return actionForward;
	}
}
