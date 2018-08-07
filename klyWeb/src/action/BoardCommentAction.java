package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import bean.BoardBean;
import bean.CommentBean;
import bean.PageInfo;
import service.BoardCommentService;
import service.BoardListService;

public class BoardCommentAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
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
		BoardListService boardListService = new BoardListService();
		int page = 1;
		// 현 페이지에 보여줄 글 갯수를 정하기위해 사용하는 변수
		int limit = 20;
		// page 파라미터 값 검사
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println((page - 1) * limit + 1);
		// 전체 글 갯수를 가져오기 위한 Listservice 클래스의 메소드 호출
		int listCount = boardListService.getListCount(null);

		// 내용만 가져오는 방법
		// ArrayList<boardbean> boardlist = boardlistservice.getboardlist();

		// limit 값을 걸어놓은 만큼 범위에 해당하는 글만 가져오는 방법
		ArrayList<BoardBean> boardList = boardListService.getboardlist(page, limit);

		// 페이지 계산을 위한 부분
		// 최대로 필요한 페이지 개수 계산
		int maxPage = (int) ((double) listCount / limit + 1);
		// 현재 페이지에 보여줄 시작페이지 번호
		int startPage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;

		int endPage = startPage + 10 - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}

		PageInfo pageInfo = new PageInfo();
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setListCount(listCount);

		
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
			actionForward.setPath("./boardList.kly");
		}
		return actionForward;
		
	}

}
