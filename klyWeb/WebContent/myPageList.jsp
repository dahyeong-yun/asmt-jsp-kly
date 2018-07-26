<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.MemberBean" %>
<%@ page import="bean.BoardBean" %>
<%@ page import="java.io.PrintWriter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	/* 로그인 사용자만 접속 가능 */
	MemberBean loginInfo = (MemberBean) session.getAttribute("loginInfo");

	if(loginInfo == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 하셔야 이용하실 수 있는 서비스 입니다.')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
	}
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="./style.css" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <title>kly</title>
  </head>
  <body>
  
    <%@include file="./navbarTemplate.jsp" %>

    <!-- 내용 부분 -->
    <h2 class="h1 ml-4 mt-4">My Page List</h2>
    <div class="row mt-4 mb-4">
        
        <!-- 좌측 링크 -->	
        <div class="col-md-4 col-lg-2">
            <div class="container">
                <div class="list-group">
                    <a class="list-group-item" href="myPage.jsp">정보변경</a>
					<a class="list-group-item active" href="myPageList.jsp?order=upload">게시물 관리</a>
					<a class="list-group-item" href="myPageDrop.jsp">회원탈퇴</a>
                </div>
            </div>
        </div>
        
		<div class="col-md-8 col-lg-10">
			<div class="container">
				
				<div class="btn-group center">
					<button class="btn btn-secondary" onclick="location.href ='./myContent.kly?listType=article';">작성한 게시물</button>
					<button class="btn btn-secondary" onclick="location.href ='./myContent.kly?listType=comment'">댓글</button>
					<button class="btn btn-secondary" onclick="location.href ='./myContent.kly?listType=liked'">추천한 게시물</button>
				</div>
				
				<table class="table table-hover">
					<thead class="thead-light">
						<tr>
							<th colspan="3">
								<div class="container-fluid" style="text-align: center;">
									asd
								</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="article" items="${articleList}">
							<tr>
								<td>${article.BOARD_SUBJECT}</td>
								<td>${article.BOARD_VIDEO_URL}</td>
								<td><button class="btn btn-info">수정</button></td>
							<tr>
						</c:forEach>
					<%-- <%
						} else if(request.getAttribute("listType").equals("comment")) {
					%>
						<tr>
							<td>댓글 번호</td>
							<td>게시물 링크</td>
							<td>수정 버튼</td>
						<tr>
					<%
						} else if(request.getAttribute("listType").equals("liked")) {
					%>
						<tr>
							<td>추천 게시물 번호</td>
							<td>게시물 링크</td>
							<td>추천 취소 버튼</td> <!-- 추천하기 버튼 -->
						<tr>
					<%
						}
					%> --%>
 					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 하단바(footer) -->
	<div class="jumbotron text-center">
		<p>&copy; 2018 kly</p>
	</div>
	
</body>
</html>
