package action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ActionForward;
import bean.BoardBean;
import bean.MemberBean;
import service.BoardWriteService;

public class BoardWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		BoardBean boardBean = new BoardBean();
		
		/** 비 로그인 사용자의 게시물 등록 시도에 대한 처리 */
		HttpSession session = request.getSession();
		MemberBean memberBean = null;
		if(session.getAttribute("loginInfo")==null) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 한 사용자만 게시물 등록이 가능합니다.');");
			out.println("location.href='./boardList.kly';");
			out.println("</script>");
		} else {
			memberBean = (MemberBean) session.getAttribute("loginInfo");
		}
		
		String URL =request.getParameter("video_URL");
		String youtube_id = URL.substring(17, URL.length());
		System.out.println(youtube_id);
		String vedio = "<iframe width='560' height='450' src=\"https://www.youtube.com/embed/"+youtube_id+"\" frameborder='1' allow='autoplay; encrypted-media' allowfullscreen></iframe>";		
			/** */
		boardBean.setMEMBER_ID(memberBean.getMEMBER_ID());
		boardBean.setBOARD_SUBJECT(request.getParameter("subject"));
		boardBean.setBOARD_VIDEO_URL(vedio);
		boardBean.setBOARD_TAG(request.getParameter("tag"));
		boardBean.setBOARD_CATEGORY(request.getParameter("category"));
		boardBean.setBOARD_YOUTUBE_ID(youtube_id);

		boolean boardResult = false;
		
		BoardWriteService boardWriteService = new BoardWriteService();
		boardResult = boardWriteService.boardWrite(boardBean);
		
		System.out.println("board액션부분\n");
		
		ActionForward forward = null;
		if(boardResult == false) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('board action 오류!!');");
			out.println("history.back();");
			out.println("</script>");
		}else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./boardList.kly");
		}
		return forward;
	}

}
