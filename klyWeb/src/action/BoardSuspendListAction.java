package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ActionForward;
import bean.BoardBean;
import bean.CommentBean;
import bean.PageInfo;
import bean.ReportBean;
import service.BoardSuspendListService;
import service.CommentListService;

public class BoardSuspendListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		BoardSuspendListService boardSuspendListService = new BoardSuspendListService();	//객체 선언
		//ArrayList<BoardBean> boardSuspendList = boardSuspendListService.getBoardSuspendList(); //boardSuspendList 객체배열선언
		ArrayList<ReportBean> reportSuspendList = boardSuspendListService.getReportSuspendList();	//reportSuspendList 객체배열선언 
		ActionForward forward = null;
		//System.out.println("boardSuspendList의 사이즈" + boardSuspendList.size());	//boardSuspendList에 담겨진 갯수
		System.out.println("reportSuspendList의 사이즈" + reportSuspendList.size());	//reportSuspendList에 담겨진 갯수
		if (reportSuspendList == null) {	//boardSuspendList가 null이거나 reportSuspendList가 null이면       boardSuspendList  == null || 
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('board Suspend action 오류!!');");
			out.println("history.back();");
			out.println("</script>");
		} else {	//boardSuspendList와 reportSuspendList 1이상 담겨 있으면
			//request.setAttribute("boardSuspendList", boardSuspendList);
			request.setAttribute("reportSuspendList", reportSuspendList);
			//session.setAttribute("reportSuspendList", reportSuspendList);
			forward = new ActionForward();
			forward.setPath("./adminBoard.jsp");
		}
		return forward;

	}

}
