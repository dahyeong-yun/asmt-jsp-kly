package action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import bean.ReportBean;
import service.BoardReportService;

public class BoardReportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ReportBean reportBean = new ReportBean();
		response.setContentType("text/html;charset=UTF-8");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String member_id = request.getParameter("member_id");
		PrintWriter out = response.getWriter();
		if (member_id.equals("")) {
			out.println("<script>");
			out.println("alert('로그인을 해주세요.');"); // 비로그인시 로그인 창으로 이동
			out.println("location.href='./boardList.kly';");
			out.println("</script>");
		}
		reportBean.setBOARD_NUM(board_num);
		reportBean.setMEMBER_ID(member_id);
		BoardReportService boardReportService = new BoardReportService();
		ArrayList<ReportBean> reportList = boardReportService.getReportList();
		ActionForward actionForward = null;
		boolean reportResult = false;

		for (int i = 0; i < reportList.size(); i++) {
			if (board_num == reportList.get(i).getBOARD_NUM()) {
				if (member_id.equals(reportList.get(i).getMEMBER_ID())) {
					out.println("<script>"); // 받아온 값과 db에서 가져온값을 비교하고 있을 경우 신고되지 않음
					out.println("alert('이미 신고한 게시물 입니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
					System.out.println("report1");
					return actionForward;
				} else {
					reportResult = boardReportService.reportUpdate(reportBean);
					if (reportResult == true) {
						out.println("<script>");
						out.println("alert('게시물이 신고 되었습니다.');");
						out.println("location.href='./boardList.kly';");
						out.println("</script>");
						System.out.println("report2");
						return actionForward;
					}
				}
			}
		}
		for (int i = 0; i < reportList.size(); i++) {
			if (board_num != reportList.get(i).getBOARD_NUM()) {
				reportResult = boardReportService.reportUpdate(reportBean);
				if (reportResult == true) {
					out.println("<script>");
					out.println("alert('게시물이 신고 되었습니다.');");
					out.println("location.href='./boardList.kly';");
					out.println("</script>");
					System.out.println("report3");
					return actionForward;
				}
			}
		}
		if (reportList.size() == 0) {
			reportResult = boardReportService.reportUpdate(reportBean);
			if (reportResult == true) {
				out.println("<script>");
				out.println("alert('게시물이 신고 되었습니다.');");
				out.println("location.href='./boardList.kly';");
				out.println("</script>");
				System.out.println("report4");
				return actionForward;
			}
		}
		out.println("<script>");
		out.println("alert('이미 신고한 게시물 입니다.');");
		out.println("location.href='./boardList.kly';");
		out.println("</script>");
		System.out.println("report5");
		return actionForward;
	}
}