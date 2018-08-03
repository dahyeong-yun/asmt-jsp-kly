package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import bean.CommentBean;
import service.BoardCommentService;

public class BoardCommentAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String comment = request.getParameter("comment");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String member_id = request.getParameter("member_id");
		CommentBean commentBean = new CommentBean();
		PrintWriter out = response.getWriter();
		commentBean.setBOARD_NUM(board_num);
		commentBean.setCOMMENT_CON(comment);
		commentBean.setMEMBER_ID(member_id);
		if (member_id.equals("")) {
			out.println("<script>");
			out.println("alert('로그인을 해주세요.');"); // 비로그인시 로그인창으로 이동
			out.println("location.href='./boardList.kly';");
			out.println("</script>");
		}
		boolean CommentResult = false;
		BoardCommentService boardCommentService = new BoardCommentService();
		CommentResult = boardCommentService.BoardCommentService(commentBean);
		
		
		System.out.println("boardComment액션부분\n");
		ActionForward actionForward = null;
		if(CommentResult == false) {
			response.setContentType("text/html;charset=UTF-8");
			out.println("<script>");
			out.println("alert('board comment action 오류!!');");
			out.println("location.href='./boardList.kly';");
			out.println("</script>");
		}else {
			actionForward = new ActionForward();
			actionForward.setRedirect(true);
			actionForward.setPath("./List.jsp");
		}
		return actionForward;
		
	}

}
