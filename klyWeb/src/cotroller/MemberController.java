package cotroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.AdminCommentListAction;
import action.BoardArrayAction;
import action.BoardCategoryAction;
import action.BoardCommentAction;
import action.BoardDeleteAction;
import action.BoardLikeAction;
import action.BoardListAction;
import action.BoardReportAction;
import action.BoardSearchAction;
import action.BoardSuspendDeleteAction;
import action.BoardSuspendListAction;
import action.BoardSuspendRelieveAction;
import action.BoardTopListAction;
import action.BoardWriteAction;
import action.EmailAuthAction;
import action.EmailCheckedAction;
import action.MemberContentListAction;
import action.MemberDetailAction;
import action.MemberDropAction;
import action.MemberFindPassAction;
import action.MemberInitPassAction;
import action.MemberJoinAction;
import action.MemberLoginAction;
import action.MemberLogoutAction;
import action.MemberModifyAction;
import action.MemberModifyFromTempAction;
import action.MemberSuspedRelieveAction;
import action.MemberSuspendAction;
import action.MemberSuspendDeleteAction;
import action.MemberSuspendListAction;
import action.MoreListAction;
import ajax.Ajax;
import ajax.IdOverlapCheckAjax;
import ajax.IndexLikeListAjax;
import ajax.IndexTopListAjax;
import ajax.viewCountAjax;
import bean.ActionForward;

@WebServlet("*.kly")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemberController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 요청받은 request의 인코딩 설정
		request.setCharacterEncoding("UTF-8");

		// 요청 url에 대한 처리(command로 변환)
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());

		/***
		 * 상시 검사용***
		 ***/
		System.out.println("-- now At FrontController");
		System.out.println("RequestURI : " + RequestURI);
		System.out.println("RequestURI : " + contextPath);
		System.out.println("command : " + command);
		System.out.println();

		Action action = null;
		ActionForward forward = null;
		Ajax ajax = null;
		String responseText = null;

		/** command에 따른 ActionForward 인스턴스 생성 */
		
			// 1) 회원가입_상단 바 
		if (command.equals("/memberJoin.kly")) {
			action = new MemberJoinAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 2) 조회 수 내림차순 리스트_메인 페이지 
		} else if (command.equals("/indexTopList.kly")) {
			ajax = new IndexTopListAjax();
			try {
				responseText = ajax.getJSON(request, response); // JSON
				System.out.println("\nTOP READ LIST responseText 반환\n");
				response.getWriter().write(responseText);
				System.out.println("\nTOP READ LIST 반환\n");
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 2) 추천 수 내림차순 리스트_메인 페이지
		} else if (command.equals("/indexLikeList.kly")) {
			ajax = new IndexLikeListAjax();
			try {
				responseText = ajax.getJSON(request, response); // JSON
				response.getWriter().write(responseText);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 아이디 중복체크_상단 바
		} else if (command.equals("/idOverlapCheck.kly")) {
			ajax = new IdOverlapCheckAjax();
			try {
				responseText = ajax.getJSON(request, response); // JSON
				response.getWriter().write(responseText);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 회원 가입 시, 이메일 인증_상단 바
		} else if (command.equals("/emailAuthAction.kly")) {
			action = new EmailAuthAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 이메일 인증_상단 바(회원 인증 메일)
		} else if (command.equals("/emailCheckedAction.kly")) {
			action = new EmailCheckedAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 회원 로그인_상단 바
		} else if (command.equals("/memberLogin.kly")) {
			action = new MemberLoginAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 회원 로그아웃_상단 바
		} else if (command.equals("/memberLogout.kly")) {
			action = new MemberLogoutAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 회원 비밀번호 찾기_상단 바
		} else if (command.equals("/memberFindPass.kly")) {
			action = new MemberFindPassAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 회원 비밀번호 찾기 했을 경우, 비밀번호 초기화_상단 바
		} else if (command.equals("/memberInitPass.kly")) { //
			action = new MemberInitPassAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 3) 회원 정보_마이페이지
		} else if (command.equals("/memberDetail.kly")) {
			action = new MemberDetailAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 3) 회원 탈퇴_마이페이지
		} else if (command.equals("/memberDrop.kly")) {
			action = new MemberDropAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 3) 회원 정보 변경_마이페이지
		} else if (command.equals("/memberInfoRivision.kly")) {
			action = new MemberModifyAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 회원 임시 비밀번호로 로그인 후 비밀번호 변경 시_상단 바
		} else if (command.equals("/memberInfoRivisionFromTemp.kly")) {
			action = new MemberModifyFromTempAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 3) 회원 게시물 리스트_마이페이지
		}else if (command.equals("/myContent.kly")) {
			action = new MemberContentListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 회원 게시물 등록_리스트 페이지
		} else if (command.equals("/boardWrite.kly")) {
			action = new BoardWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 게시물 리스트_리스트 페이지
		} else if (command.equals("/boardList.kly")) {
			action = new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1) 관리자 댓글 리스트_관리자 페이지
		} else if (command.equals("/adminComment.kly")) {
			action = new AdminCommentListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 게시물 댓글  등록_리스트 페이지
		} else if (command.equals("/boardComment.kly")) {
			action = new BoardCommentAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 게시물 카테고리 설정_리스트 페이지
		} else if (command.equals("/boardCategory.kly")) {
			action = new BoardCategoryAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 리스트 페이지 정렬_리스트 페이지
		} else if (command.equals("/boardArray.kly")) {
			action = new BoardArrayAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 게시물 추천_리스트 페이지
		} else if (command.equals("/boardLike.kly")) {
			action = new BoardLikeAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 게시물 신고_리스트 페이지
		} else if (command.equals("/boardReport.kly")) {
			action = new BoardReportAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 게시물 삭제_리스트 페이지
		} else if (command.equals("/boardDelete.kly")) {
			action = new BoardDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 게시물 검색_리스트 페이지
		} else if (command.equals("/boardSearch.kly")) {
			action = new BoardSearchAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 4) 게시물 더보기_리스트 페이지
		} else if (command.equals("/moreList.kly")) {
			action = new MoreListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 5) 게시물 신고 리스트_관리자 페이지
		} else if (command.equals("/boardSuspendList.kly")) { // 게시물 관리페이지
			action = new BoardSuspendListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 5) 게시물 삭제_관리자 페이지
		} else if (command.equals("/boardSuspendDelete.kly")) { // 게시물 관리페이지에서의 삭제
			action = new BoardSuspendDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 5) 게시물 신고 리스트_관리자 페이지
		} else if (command.equals("/boardSuspendRelieve.kly")) { // 게시물 관리페이지에서의 신고 해제(REPORT_COUNT = 0)
			action = new BoardSuspendRelieveAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberSuspendList.kly")) {
			action = new MemberSuspendListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberSuspedDelete.kly")) {
			action = new MemberSuspendDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberSuspend.kly")) {
			action = new MemberSuspendAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/memberSuspedRelieve.kly")) {
			action = new MemberSuspedRelieveAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//
		} else if (command.equals("/cancelLike.kly")) {
			response.getWriter().write("success");
			// 4) 게시물 조회 수 증가_리스트 페이지
		} else if (command.equals("/viewCount.kly")) {
			ajax = new viewCountAjax();
			try {
				responseText = ajax.getJSON(request, response); // JSON
				response.getWriter().write(responseText);
				System.out.println("at Controller\nJSON data 보내기 성공");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		//./cancleLike.kly

		/** 2. ActionForward 인스턴스에 따른 forwarding */
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
}
