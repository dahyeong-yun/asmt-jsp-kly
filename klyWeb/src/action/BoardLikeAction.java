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
		System.out.println(board_num + ": 게시글 번호");
		for (int i = 0; i < likeList.size(); i++) {
			if (board_num == likeList.get(i).getBOARD_NUM()) {
				if (member_id.equals(likeList.get(i).getMEMBER_ID())) {
					out.println("<script>"); // 받아온 값과 db에서 가져온값을 비교하고 있을 경우 신고되지 않음
					out.println("alert('이미 추천한 게시물 입니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
					System.out.println("like 1");
					return actionForward;
				}
			}
		}
		for (int i = 0; i < likeList.size(); i++) {
			if (board_num == likeList.get(i).getBOARD_NUM()) {
				if (!member_id.equals(likeList.get(i).getMEMBER_ID())) {
					out.println("<script>"); // 받아온 값과 db에서 가져온값을 비교하고 있을 경우 신고되지 않음
					out.println("alert('이미 추천한 게시물 입니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
					System.out.println("like 1");
					return actionForward;
				}
			}
		}
		for (int i = 0; i < likeList.size(); i++) {
			if (board_num != likeList.get(i).getBOARD_NUM()) {
				System.out.println(board_num + ": 게시글 번호" + likeList.get(i).getBOARD_NUM() +":DB에서 가져온번호");
				reportResult = boardLikeService.likeUpdate(likeBean);
				if (reportResult == true) {
					out.println("<script>");
					out.println("alert('게시물이 추천 되었습니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
					System.out.println("like 3");
					return actionForward;
				}
			}
		}
		if(likeList.size()==0) {
			reportResult = boardLikeService.likeUpdate(likeBean);
			if (reportResult == true) {
				out.println("<script>");
				out.println("alert('게시물이 추천 되었습니다.');");
				out.println("location.href='./boardList.kly';");
				out.println("</script>");
				System.out.println("like 4");
				return actionForward;
			}
		}
		out.println("<script>");
		out.println("alert('이미 추천한 게시물 입니다.');");
		out.println("location.href='./boardList.kly';");
		out.println("</script>");
		System.out.println("like 6");
		return actionForward;
	}
}
