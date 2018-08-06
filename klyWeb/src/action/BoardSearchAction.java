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
import service.BoardSearchService;
import service.BoardListService;

public class BoardSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardBean search = new BoardBean();
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String searchValue = request.getParameter("search");
		System.out.println(searchValue.length());
		
		search.setBOARD_SUBJECT(searchValue); // 쿼리문 전송 위한 검색값 저장
		search.setBOARD_TAG(searchValue);
		
		BoardSearchService boardSearchService = new BoardSearchService(); // 객체선언
		BoardCommentListService boardCommentListService = new BoardCommentListService(); // 객체 선언
		ArrayList<CommentBean> commentList = boardCommentListService.BoardCommentListService(); // 댓글목록 객체배열선언
		BoardListService boardListService = new BoardListService();
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
		int listCount = boardListService.getListSearchCount(search);

		// 내용만 가져오는 방법
		// ArrayList<boardbean> boardlist = boardlistservice.getboardlist();
		ArrayList<BoardBean> searchList = boardSearchService.listSearch(search, page, limit); // 검색목록 객체배열선언
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
		ActionForward actionForward = null;
		if (searchList.size() == 0) {
			out.println("<script>");
			out.println("alert('검색 결과가 없습니다.');"); // 검색 결과가 없을경우
			out.println("location.href='./boardList.kly';");
			out.println("</script>");
		} else {
			request.setAttribute("boardlist", searchList);
			request.setAttribute("commentlist", commentList);
			actionForward = new ActionForward();
			actionForward.setPath("List.jsp");
		}
		return actionForward;

	}

}
