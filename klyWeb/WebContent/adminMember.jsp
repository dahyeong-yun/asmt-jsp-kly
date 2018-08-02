<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.MemberBean"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bean.PageInfo"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
						<a class="list-group-item" href="boardSuspendList.kly ">게시물 관리(관리자)</a>
						<a class="list-group-item" href="adminComment.kly">댓글 관리(관리자)</a> <a
							class="list-group-item active" href="memberSuspendList.kly">사용자 관리(관리자)</a>
					</div>
				</div>
			</div>
			<div class="col-md-7 col-lg-8">
				<table class="table table-hover">
					<tr>
						<th>사용자 ID</th>
						<th>회원가입 일시</th>
						<th>회원 삭제</th>
						<th>회원 정지</th>
						<th>회원 정지해제</th>
					</tr>
					
					<c:forEach var="member" items="${MemberSuspendList}">
						<tr>
							<td>${member.MEMBER_ID}</td>
							<td>${member.MEMBER_DATE}</td>
							<!-- <td><button type="button" class="btn" onclick="location.href='memberDrop.kly?MEMBER_ID=${member.MEMBER_ID}'">삭제</button></td> -->
							<td><button type="button" class="btn" onclick="location.href='memberSuspedDelete.kly?MEMBER_ID=${member.MEMBER_ID}'">삭제</button></td>
							<td><button type="button" class="btn" data-toggle="modal"
									data-target="#board${member.MEMBER_ID}">정지</button> <!-- The Modal -->
								<form action="./memberSuspend.kly" method="get"
									id="memberSuspend" onsubmit="return alertSelectCategory()">
									<div class="modal fade" id="board${member.MEMBER_ID}">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">
												<input type="text" name="MEMBER_ID"
													value="${member.MEMBER_ID}">
												<!-- Modal Header -->
												<div class="modal-header">
													<h4 class="modal-title">회원 정지</h4>
													<button type="button" class="close" data-dismiss="modal">&times;</button>
												</div>
	
												<!-- Modal body -->
												<div class="modal-body">
													<div class="Zform-group" id="category">
														<!-- <label for="category" style="display: inline;">게시판</label> -->
														<select class="form-control" name="category"
															id="selectedCategory">
															<option value="select" selected="selected">정지일수를
																선택하세요</option>
															<option value="7">7일</option>
															<option value="15">15일</option>
															<option value="30">1달</option>
															<option value="99999">영구</option>
														</select>
													</div>
												</div>
	
												<!-- Modal footer -->
												<div class="modal-footer">
													<button type="submit" class="btn btn-primary">정지</button>
													<!-- data-dismiss="modal" -->
												</div>
											</div>
										</div>
									</div>
								</form> <!-- <td><button type="button" class="btn" onclick="location.href='memberSuspend.kly?MEMBER_ID=${member.MEMBER_ID}'">정지</button></td> -->
							<td><button type="button" class="btn" onclick="location.href='memberSuspedRelieve.kly?MEMBER_ID=${member.MEMBER_ID}'">해제</button></td>
						</tr>
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
<script>
	/* function alertSelectCategory() {
		var whatCategory = document.getElementById("selectedCategory");
		if (whatCategory.value == "select") {
			alert('정지일수를 선택하세요.');
			document.getElementById("category").focus();
			return false;
		} else {
			return true;
		}
	} */
</script>
</html>