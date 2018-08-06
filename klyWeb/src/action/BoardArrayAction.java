package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import bean.BoardBean;
import bean.CommentBean;
import bean.PageInfo;
import service.BoardCommentListService;
import service.BoardListService;

public class BoardArrayAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		BoardBean boardBean = new BoardBean();
		String category = request.getParameter("category");
		String array = request.getParameter("array"); // 받아온값 저장
		boardBean.setBOARD_CATEGORY(category); // 쿼리문 전송을 위한 세팅

		BoardCommentListService boardCommentListService = new BoardCommentListService(); // 객체 선언
		ArrayList<CommentBean> commentList = boardCommentListService.BoardCommentListService(); // 댓글목록 객체배열선언
		ActionForward actionForward = null;
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
		int listCount = boardListService.getListCategoryCount(boardBean);

		// 내용만 가져오는 방법
		// ArrayList<boardbean> boardlist = boardlistservice.getboardlist();

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

		if (category != null) {
			if (array.equals("추천")) { // 카테고리에 값이 null이 아니고 array에 추천값을 받아온 경우
				ArrayList<BoardBean> ArrayList = boardListService.getLikeList(boardBean, page, limit);
				for (int i = 0; i < ArrayList.size(); i++) { // ArrayList 객체를 선언해서 카테고리 값을 비교
					if (category.equals(ArrayList.get(i).getBOARD_CATEGORY())) {
						request.setAttribute("category", ArrayList.get(i));
						request.setAttribute("boardlist", ArrayList);
						request.setAttribute("commentlist", commentList);
						actionForward = new ActionForward();
						actionForward.setPath("List.jsp");
						return actionForward;
					}
				}
			} else { // 카테고리에 값이 null이 아닌경우 array에 조회값을 받아온 경우
				ArrayList<BoardBean> ArrayList = boardListService.getReadList(boardBean, page, limit);
				for (int i = 0; i < ArrayList.size(); i++) {
					if (category.equals(ArrayList.get(i).getBOARD_CATEGORY())) {
						request.setAttribute("category", ArrayList.get(i));
						request.setAttribute("boardlist", ArrayList);
						request.setAttribute("commentlist", commentList);
						actionForward = new ActionForward();
						actionForward.setPath("List.jsp");
						return actionForward;
					}
				}
			} 
		}

		if (array.equals("추천")) { // 카테고리에 값이 null인 경우 array에 추천값을 받아온 경우
			ArrayList<BoardBean> ArrayList = boardListService.getLikeList(boardBean, page, limit);
			request.setAttribute("boardlist", ArrayList);
			request.setAttribute("commentlist", commentList);
			actionForward = new ActionForward();
			actionForward.setPath("List.jsp");
			return actionForward;
		} else { // 카테고리에 값이 null인 경우 array에 조회값을 받아온 경우
			ArrayList<BoardBean> ArrayList = boardListService.getReadList(boardBean, page, limit);
			request.setAttribute("boardlist", ArrayList);
			request.setAttribute("commentlist", commentList);
			actionForward = new ActionForward();
			actionForward.setPath("List.jsp");
			return actionForward;
		}
	}
}
