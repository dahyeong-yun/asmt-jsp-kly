<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="bean.BoardBean" %>

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

	<!-- 리스트 출력 프로세스 -->
	<script type="text/javascript">
		function aws() { // 이게 페이지 로드 시 출력되게 수정, 아마 window.onload
			var req = new XMLHttpRequest();
		
			req.onreadystatechange = function() {
				if(this.readyState == 4 && this.status == 200) {
					var arr = JSON.parse(this.responseText);
					var out =
						"<tr>" +
							"<td>" + arr.value0[0] + "</td>"+
							"<td><a href=\"./boardList.kly\"><img src=\"" + arr.value0[1] + "\"></a></td>"+
							"<td>" + arr.value0[2] + "</td>"+
							"<td>" + arr.value0[3] + "</td>"+
							"<td>" + arr.value0[4] + "</td>"+
						"</tr>" +
						"<tr>" +
							"<td>" + arr.value1[0] + "</td>"+
							"<td><a href=\"./boardList.kly\"><img src=\"" + arr.value1[1] + "\"></a></td>"+
							"<td>" + arr.value1[2] + "</td>"+
							"<td>" + arr.value1[3] + "</td>"+
							"<td>" + arr.value1[4] + "</td>"+
						"</tr>" +
						"<tr>" +
							"<td>" + arr.value2[0] + "</td>"+
							"<td><a href=\"./boardList.kly\"><img src=\"" + arr.value2[1] + "\"></a></td>"+
							"<td>" + arr.value2[2] + "</td>"+
							"<td>" + arr.value2[3] + "</td>"+
							"<td>" + arr.value2[4] + "</td>"+
						"</tr>";
					}
				
					document.getElementById("topReadcountList").innerHTML = out;
				}
			
			req.open("GET","./indexTopList.kly", true);
			req.send();
		}
		
		function ajs() { // 이게 페이지 로드 시 출력되게 수정, 아마 window.onload
			var req= new XMLHttpRequest();
			req.onreadystatechange = function() {
				if(this.readyState == 4 && this.status ==200) {
					var arr = JSON.parse(this.responseText);
					var out =
						"<tr>" +
							"<td>" + arr.value0[0] + "</td>"+
							"<td><a href=\"./boardList.kly\"><img src=\"" + arr.value0[1] + "\"></a></td>"+
							"<td>" + arr.value0[2] + "</td>"+
							"<td>" + arr.value0[3] + "</td>"+
							"<td>" + arr.value0[4] + "</td>"+
						"</tr>" +
						"<tr>" +
							"<td>" + arr.value1[0] + "</td>"+
							"<td><a href=\"./boardList.kly\"><img src=\"" + arr.value1[1] + "\"></a></td>"+
							"<td>" + arr.value1[2] + "</td>"+
							"<td>" + arr.value1[3] + "</td>"+
							"<td>" + arr.value1[4] + "</td>"+
						"</tr>" +
						"<tr>" +
							"<td>" + arr.value2[0] + "</td>"+
							"<td><a href=\"./boardList.kly\"><img src=\"" + arr.value2[1] + "\"></a></td>"+
							"<td>" + arr.value2[2] + "</td>"+
							"<td>" + arr.value2[3] + "</td>"+
							"<td>" + arr.value2[4] + "</td>"+
						"</tr>";
					}
				
					document.getElementById("topLikedList").innerHTML = out;
				}
			
			req.open("GET","./indexLikeList.kly", true);
			req.send();
		}
	</script>

	<style>
		td img {
			max-width : 120px;
		}
		tbody td {
			vertical-align:center;
		}
		
	</style>
	
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
				<form class="form mb-2" action="./boardSearch.kly" method="post" style="max-width:400px;">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" name="search" placeholder="검색어를 입력해 주세요.">
							<div class="input-group-append">
								<button type="button" onclick="searchCheck()" class="btn btn-success">검색</button>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="col-lg-4 col-md-3"></div>
		</div>
		
		<script>
		/* 검색어 제한 함수 */
		function searchCheck() {
			var search = document.getElementById("search");
			if(search.value == "") {
				alert('검색 값을 입력해주세요.')
			} else {
				document.getElementById("searchForm").submit();
			}
		}
		</script>
	
		<div class="row my-3">
			<div class="col-lg-6">
				<table class="table table-hover mt-3" style="text-align: center;">
					<thead class="thead-light">
						<tr>
							<th colspan="5" style="text-align: center;">
								조회수 상위 5개 게시물
							</th>
						</tr>
						<tr style="font-weight: bold;">
							<td>번호</td>
							<td colspan="2">제목</td>
							<td>좋아요</td>
							<td>조회수</td>
						</tr>
					</thead>
					<tbody id="topReadcountList"></tbody>
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
						<tr style="font-weight: bold;">
							<td>번호</td>
							<td colspan="2">제목</td>
							<td>좋아요</td>
							<td>조회수</td>
						</tr>
					</thead>
					
					<tbody id="topLikedList"></tbody>
					</table>
			</div>
		</div>
		
		<!-- <div class="container" id="demo">
			<button onclick="ajs()" >Ajax Test Button</button>
		</div> -->
		
	</div>

	<!-- 하단바(footer) -->
	<div class="jumbotron text-center">
		<p>&copy; 2018 kly</p>
	</div>
	
	<script>
	 	ajs();
	 	aws();
	</script>
	
</body>
</html>
