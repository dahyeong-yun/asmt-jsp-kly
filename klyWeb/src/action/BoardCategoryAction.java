package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import bean.BoardBean;
import bean.CommentBean;
import service.BoardCommentListService;
import service.BoardListService;

public class BoardCategoryAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		BoardBean boardBean = new BoardBean();
		String category = request.getParameter("category");
		boardBean.setBOARD_CATEGORY(category); // 쿼리문 전송을 위한 세팅
		PrintWriter out = response.getWriter();
		System.out.println(boardBean.getBOARD_CATEGORY());
		BoardListService boardlistservice = new BoardListService();
		BoardCommentListService boardCommentListService = new BoardCommentListService(); //객체선언
		ArrayList<CommentBean> commentList = boardCommentListService.BoardCommentListService();
		ArrayList<BoardBean> categoryList = boardlistservice.getCategory(boardBean); //댓글목록 카테고리 목록 객체 배열선언
		ActionForward actionForward = null; 
		for(int i=0 ; i<categoryList.size();i++) {
			if(category.equals(categoryList.get(i).getBOARD_CATEGORY())) // List에서 누른 category값과 db에서 받은 카테고리 목록 비교
				request.setAttribute("category", categoryList.get(i));
				request.setAttribute("boardlist", categoryList);
				request.setAttribute("commentlist", commentList);
				actionForward = new ActionForward();
				actionForward.setPath("List.jsp");
		}
		out.println("<script>"); // List에서 누른 category에 DB에 저장된 것이 없는 경우
		out.println("alert('해당 카테고리에 동영상이 없습니다.');");
		out.println("location.href='./boardList.kly';");
		out.println("</script>");
		return actionForward;
	}
}
