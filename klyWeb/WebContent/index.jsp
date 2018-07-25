<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="./style.css" type="text/css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    
    <script src="./script.js"></script>
    <title>kly</title>

</head>

<body>

	<!-- 상단바(footer) -->
	<%@include file="./navbarTemplate.jsp" %>

	<!-- 내용 부분 -->
	<div class="container">
		<img class="mx-auto d-block" src="./images/kly.png" style="height: 400px"/>

		<!-- 검색메뉴 -->
		<div class="row">
			<div class="col-lg-4 col-md-3"></div>
			<div class="col-lg-4 col-md-6">
				<form class="form mb-2" action="./List.jsp" method="get" style="max-width:400px;">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" name="search" placeholder="검색어를 입력해 주세요.">
							<div class="input-group-append">
								<button type="submit" class="btn btn-success">검색</button>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="col-lg-4 col-md-3"></div>
		</div>
		
	
		<div class="row my-3">
			<div class="col-lg-6">
				<table class="table table-hover mt-3" style="text-align: center;">
					<thead class="thead-light">
						<tr>
							<th colspan="5" style="text-align: center;">
								조회수 상위 5개 게시물
							</th>
						</tr>
					</thead>
					<tbody>
			            <tr style="font-weight: bold;">
			                <td>번호</td>
			                <td colspan="2">제목</td>
			                <td>좋아요</td>
			                <td>조회수</td>
			            </tr>
					<!-- 여기서 게시물 반복 -->
			            <tr>
			                <td>1</td>
			                <td>img</td>
			                <td>subject</td>
			                <td>12</td>
			                <td>2</td>
			            </tr>
					<!-- 여기까지 -->
			            <tr>
			                <td>2</td>
			                <td>img</td>
			                <td>subject</td>
			                <td>12</td>
			                <td>2</td>
			            </tr>
			            <tr>
			                <td>3</td>
			                <td>img</td>
			                <td>subject</td>
			                <td>12</td>
			                <td>2</td>
			            </tr>
		            </tbody>
		        </table>	
			</div>
			
			<!-- <div class="col-lg-2"></div> -->
			
			<div class="col-lg-6">
				<table class="table table-hover mt-3" style="text-align: center;">
					<thead class="thead-light">
						<tr>
							<th colspan="5">
			                    	추천수 상위 5개 게시물
			                </th>
						</tr>
					</thead>
		            <tbody>
			            <tr style="font-weight: bold;">
			                <td>번호</td>
			                <td colspan="2">제목</td>
			                <td>좋아요</td>
			                <td>조회수</td>
			            </tr>
			            <tr>
			                <td>1</td>
			                <td>img</td>
			                <td>subject</td>
			                <td>12</td>
			                <td>2</td>
			            </tr>
			            <tr>
			                <td>2</td>
			                <td>img</td>
			                <td>subject</td>
			                <td>12</td>
			                <td>2</td>
			            </tr>
			            <tr>
			                <td>3</td>
			                <td>img</td>
			                <td>subject</td>
			                <td>12</td>
			                <td>2</td>
			            </tr>
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
