package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ActionForward;
import bean.MemberBean;
import service.MemberSuspendService;

public class MemberSuspendAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		// 로그인 여부 확인
		// 로그인한 아이디가 admin인지 확인.

		HttpSession session = request.getSession();
		String whoami = (String) session.getAttribute("id");
		ActionForward forward = null;
		//if (whoami == "admin") {
			forward = new ActionForward();
			String ID = request.getParameter("MEMBER_ID");
			String whatDay = request.getParameter("category");

			
			MemberSuspendService memberSuspendService = new MemberSuspendService();
			boolean suspendResult = memberSuspendService.memberSuspend(ID,whatDay);
			System.out.println(ID);
			System.out.println(whatDay);
			if (suspendResult) {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				if (whatDay.equals("7")) {
					out.println("<script>");
					out.println("alert('7일 정지완료.')");
					out.println("</script>");
				} else if (whatDay.equals("15")) {
					out.println("<script>");
					out.println("alert('15일 정지완료.')");
					out.println("</script>");
				} else if (whatDay.equals("30")) {
					out.println("<script>");
					out.println("alert('한달 정지완료.')");
					out.println("</script>");
				} else if (whatDay.equals("99999")) {
					out.println("<script>");
					out.println("alert('영구정지완료.')");
					out.println("</script>");
				}
				forward.setRedirect(true);// Redirect 하면 alert이 안 뜸
				forward.setPath("./memberSuspendList.kly");
			} else {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('정지 실패.')");
				out.println("location.href='./memberSuspendList.kly'</script>");
			}
			/*request.setAttribute("MemberSuspendList", MemberSuspendList);
			System.out.println("membeSuspendAction");
			System.out.println("MemberSuspendList의 사이즈 : " + MemberSuspendList.size());
			forward.setPath("./adminMember.jsp");*/
		/*} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자가 아닙니다.')");
			out.println("location.href='./memberLogin.kly'</script>");
		}*/

		return forward;
	}

}
