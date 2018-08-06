package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import bean.BoardBean;
import bean.CommentBean;
import bean.PageInfo;
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
		BoardListService boardListService = new BoardListService();
		BoardCommentListService boardCommentListService = new BoardCommentListService(); //객체선언
		ArrayList<CommentBean> commentList = boardCommentListService.BoardCommentListService();
		ActionForward actionForward = null; 
		// 페이지 번호를 알기위해 사용하는 변수
		int page = 1;
		// 현 페이지에 보여줄 글 갯수를 정하기위해 사용하는 변수
		int limit = 20;
		// page 파라미터 값 검사
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println((page - 1) * limit + 1);
		// 전체 글 갯수를 가져오기 위한 Listservice 클래스의 메소드 호출
		int listCount = boardListService.getListCategoryCount(boardBean);

		// 내용만 가져오는 방법
		// ArrayList<boardbean> boardlist = boardlistservice.getboardlist();
		ArrayList<BoardBean> categoryList = boardListService.getCategory(boardBean, page, limit); //댓글목록 카테고리 목록 객체 배열선언
		// limit 값을 걸어놓은 만큼 범위에 해당하는 글만 가져오는 방법

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
		
		request.setAttribute("pageInfo", pageInfo);
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
