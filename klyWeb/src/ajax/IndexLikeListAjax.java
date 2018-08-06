package ajax;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.BoardBean;
import service.BoardTopListService;

public class IndexLikeListAjax implements Ajax {

	@Override
	public String getJSON(HttpServletRequest request, HttpServletResponse response) throws Exception {
		StringBuffer result = new StringBuffer("");
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		BoardTopListService boardTopListService = new BoardTopListService();
		
		ArrayList<BoardBean> topLikecountList = boardTopListService.getTopLikecountList();
		
		/** JSON syntax
		 * {
		 *	"employees":[ "John", "Anna", "Peter" ]
		 * }
		 * */

		result.append("{");
		// topReadcountList를 JSON 형태로 변환
		for(int i=0; i<topLikecountList.size(); i++) {
			if(i == topLikecountList.size()-1) {
				result.append("\"value"+ i +"\":"
						+ "[\"" + topLikecountList.get(i).getBOARD_NUM() +"\","
						+ "\"https://img.youtube.com/vi/"+topLikecountList.get(i).getBOARD_YOUTUBE_ID()+"/0.jpg\","
						+ "\"" + topLikecountList.get(i).getBOARD_SUBJECT() +"\","
						+ "\"" + topLikecountList.get(i).getBOARD_LIKECOUNT() +"\","
						+ "\"" + topLikecountList.get(i).getBOARD_READCOUNT() +"\"]"
						);
			} else {
				result.append("\"value"+ i +"\":"
						+ "[\"" + topLikecountList.get(i).getBOARD_NUM() +"\","
						+ "\"https://img.youtube.com/vi/"+topLikecountList.get(i).getBOARD_YOUTUBE_ID()+"/0.jpg\","
						+ "\"" + topLikecountList.get(i).getBOARD_SUBJECT() +"\","
						+ "\"" + topLikecountList.get(i).getBOARD_LIKECOUNT() +"\","
						+ "\"" + topLikecountList.get(i).getBOARD_READCOUNT() +"\"], "
						);
			}
		}
		result.append("}");
		request.setAttribute("topReadcountList", topLikecountList);
		System.out.println(result.toString());
		return result.toString();
	}

}
