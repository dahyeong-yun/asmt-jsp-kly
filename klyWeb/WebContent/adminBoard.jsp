<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.MemberBean"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bean.BoardBean"%>
<%@ page import="bean.ReportBean"%>
<%@ page import="bean.PageInfo"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="./style.css" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>kly</title>
</head>
<body>

	<%@include file="./navbarTemplate.jsp"%>

	<!-- 내용 부분 -->
	
	<div class="container">
	
		<div class="row mt-4 mb-4">
			<div class="col-md-4 col-lg-3">
				<div class="container">
					<div class="list-group">
						<a class="list-group-item active" href="boardSuspendList.kly ">게시물 관리(관리자)</a>
						<a class="list-group-item" href="adminComment.kly">댓글 관리(관리자)</a> <a
							class="list-group-item" href="memberSuspendList.kly">사용자 관리(관리자)</a>
					</div>
				</div>
			</div>
	
			<div class="col-md-7 col-lg-8">
				<table class="table table-hover">
					<c:forEach var="board" items="${boardSuspendList}">
						<tr rowspan="3">
							<td rowspan="3" style="width: 15%;">
								<!-- 썸네일 미완성 --> <%-- 
								BOARD table의 BOARD_URL attribute값은 <iframe width="320" height="180"
								src="https://www.youtube.com/embed/zjwqIyoWV8c" frameborder="0"
								allow="autoplay; encrypted-media" allowfullscreen></iframe>--%> <%-- ArrayList에 담겨 있는 값을 출력하면 ${board.BOARD_URL}이 되겠지만 500 오류가 난다. --%>
								<!-- 위와 같은 방법을 해결하려면 BOARD_URL attribute에 주소만 입력하고 SQL문에서
								SUBSTR을 이용해서  원하는 부분만을 추출하여  --> <iframe width="320" height="180"
									src="https://www.youtube.com/embed/zjwqIyoWV8c" frameborder="0"
									allow="autoplay; encrypted-media" allowfullscreen></iframe> <%-- ${board.BOARD_URL} --%>
	
							</td>
							<td style="width: auto;">글 번호${board.BOARD_NUM}&emsp;제목
								&nbsp;${board.BOARD_SUBJECT}</td>
							<td rowspan="3" style="width: 10%; vertical-align: middle"><button
									type="button" class="btn"
									onclick="location.href='boardSuspendDelete.kly?BOARD_NUM=${board.BOARD_NUM}'">삭제</button>&nbsp;&nbsp;
								<button type="button" class="btn"
									onclick="location.href='boardSuspendRelieve.kly?BOARD_NUM=${board.BOARD_NUM}'">해제</button></td>
						</tr>
	
						<c:forEach var="report" items="${reportSuspendList}">
							<tr>
								<td style="width: auto;">신고 수 &nbsp;${report.REPORT_COUNT}</td>
							</tr>
							<tr>
								<td style="width: auto;">신고 시간 &nbsp;${report.REPORT_DATE}</td>
							</tr>
						</c:forEach>
					</c:forEach>
	
				</table>
	
				<div style="padding: 10px; text-align: center;">
					<button type="button" class="btn btn-primary">이전</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-primary">다음</button>
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