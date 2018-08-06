package ajax;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.BoardBean;
import dao.MemberDAO;
import service.BoardTopListService;
import service.BoardViewCountService;
import service.MemberJoinService;

public class viewCountAjax implements Ajax {

	@Override
	public String getJSON(HttpServletRequest request, HttpServletResponse response) throws Exception {
		StringBuffer result = new StringBuffer("");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		System.out.println(request.getParameter("boardNum"));
		
		int BOARD_NUM = Integer.parseInt(request.getParameter("boardNum"));
		
		BoardViewCountService boardViewCountService = new BoardViewCountService();
		boolean countResult = boardViewCountService.viewCount(BOARD_NUM);
		
		result.append("{\"result\":");
		
		if(countResult) {
			result.append("\"yes\"");
		} else {
			result.append("\"no\"");
		}
		result.append("}");
		
		return result.toString();
	}

}
