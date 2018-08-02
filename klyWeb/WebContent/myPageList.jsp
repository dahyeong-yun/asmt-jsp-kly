<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.MemberBean" %>
<%@ page import="bean.BoardBean" %>
<%@ page import="bean.CommentBean" %>
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
    <div class="container">
	    <h2 class="h1 ml-4 mt-4">My Page</h2>
	    <div class="row mt-4 mb-4">
	        
	        <!-- 좌측 링크 -->	
			<div class="col-md-4 col-lg-3">
				<div class="container">
					<div class="list-group">
	                    <a class="list-group-item" href="myPage.jsp">정보변경</a>
						<a class="list-group-item active" href="./myContent.kly?listType=article">게시물 관리</a>
						<a class="list-group-item" href="myPageDrop.jsp">회원탈퇴</a>
	                </div>
	            </div>
	        </div>
	        
			<div class="col-md-8 col-lg-9">
				<div class="container">
					<h2>게시물 리스트</h2>
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
						
							
							<c:choose>
								<c:when test="${param.listType eq 'article'}">
									<c:forEach var="article" items="${articleList}">
										<tr>
											<td>${article.BOARD_SUBJECT}</td>
											<td>${article.BOARD_VIDEO_URL}</td>
											<td><button class="btn btn-info" data-toggle="modal" data-target="#ArticleForm" >수정</button></td>
										<tr>
									</c:forEach>
								</c:when>
								
								<c:when test="${param.listType eq 'comment'}">
									<c:forEach var="comment" items="${commentList}">
										<tr>
											<td>${comment.COMMENT_CON}</td>
											<td>${comment.COMMENT_DATE}</td>
											<td><button class="btn btn-info" data-toggle="modal" data-target="#ArticleForm" >수정</button></td>
										<tr>
									</c:forEach>
								</c:when>
								
								<c:when test="${param.listType eq 'liked'}">
									<c:forEach var="like" items="${likeList}">
										<tr>
											<td>${like.BOARD_NUM}</td>
											<td>${like.LIKE_NUM}</td>
											 <!-- 좋아요를 했을 경우 좋아요 취소(danger) -->
											<td><button class="btn btn-danger" >좋아요 취소</button></td>
											 
											 <!-- 좋아요를 취소 했을 경우 좋아요(primary) -->
											 <td><button class="btn btn-primary" >좋아요 취소</button></td>
										<tr>
									</c:forEach>
								</c:when>
	
								<c:otherwise>
								</c:otherwise>
	
							</c:choose>
	 					
	 					</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
       
	<!-- 하단바(footer) -->
	<div class="jumbotron text-center">
		<p>&copy; 2018 kly</p>
	</div>
	
</body>
</html>
