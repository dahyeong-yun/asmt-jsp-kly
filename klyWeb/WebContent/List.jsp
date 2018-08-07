<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bean.BoardBean"%>
<%@ page import="bean.CommentBean"%>
<%@ page import="bean.PageInfo"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	ArrayList<BoardBean> boardList = (ArrayList<BoardBean>) request.getAttribute("boardlist");
	//페이징 정보 가져오기
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int maxPage = pageInfo.getMaxPage();
	int listCount = pageInfo.getListCount();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
body {
	overflow-x: auto;
}

#leftbody {
	padding: 5px;
}

#category {
	margin: 5px 5px 20px 5px;
}

#register {
	margin: 5px 5px 20px 5px;
}

#card {
	float: left;
	width: 260px;
	height: 240px;
	margin: 20px;
}

.view {
	float: left;
}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	
<title>Title</title>
<script>
	var view = null;
	
	function viewCount(id, boardNum) {
		if(view == null) {
			var content = document.getElementById(id);
			content.style.display = 'block';
			view = id;
		} else {
			var content = document.getElementById(id);
			content.style.display = 'block';
			var activeContent = document.getElementById(view);
			activeContent.style.display='none';
			view = id;
		}
		content.scrollIntoView();
		
		
		var req = new XMLHttpRequest();
		req.onreadystatechange = function () {
			if(this.state == 4 && this.status == 200) {
				var result = JSON.parse(responseText);
				console.log("조회 수 증가 결과 : "+result.result);
			}
		}
		
		req.open("GET","./viewCount.kly?boardNum="+boardNum, true);
		req.send();
	}
</script>
</head>

<body>
	<!-- 상단바(footer) -->
	<%@include file="./navbarTemplate.jsp"%>

	<!--리스트 페이지의 몸통부분 -->
	<div class="main" style="height: 1080px; width: 1920px">
		<!--몸통부분의 왼쪽 부분으로 동영상을 분류 별로 선택해서 보는 기능 으로 
	category 값을 BoardCategoryAction 으로 넘김  -->
		<div class="bg-light" id="leftbody"
			style="height: 100%; width: 250px; float: left;">
			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="category"
				onclick="location='boardList.kly?'">전체보기</button>
			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="category"
				onclick="location='boardCategory.kly?category=유머'">유머</button>
			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="category"
				onclick="location='boardCategory.kly?category=정보'">정보</button>
			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="category"
				onclick="location='boardCategory.kly?category=게임'">게임</button>
			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="category"
				onclick="location='boardCategory.kly?category=감동'">감동</button>
			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="category"
				onclick="location='boardCategory.kly?category=스포츠'">스포츠</button>
			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="category"
				onclick="location='boardCategory.kly?category=취미'">취미</button>
			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="category"
				onclick="location='boardCategory.kly?category=동물'">동물</button>
			<button type="button" class="btn btn-outline-info"
				style="width: 95%; margin: 5px 5px 80px 5px;" id="category"
				onclick="location='boardCategory.kly?category=기타'">기타</button>


			<button type="button" class="btn btn-outline-info"
				style="width: 95%;" id="register" data-toggle="modal"
				data-target="#board">게시글 등록</button>

			<!-- 검색기능  태그나 게시글 제목을 입력해 검색할 수 있음-->
			<form action="./boardSearch.kly" method="post" id="searchForm">
				<div class="input-group mb-3">
					<input type="text" class="form-control" placeholder="Search"
						name="search" id="search">
					<div class="input-group-append">
						<button class="btn btn-success" type="button"
							onclick="searchCheck()">검색</button>
					</div>
				</div>
			</form>
		</div>

		<script>
			function searchCheck() {
				var search = document.getElementById("search");
				if (search.value == "") {
					alert('검색 값을 입력해주세요.')
				} else {
					document.getElementById("searchForm").submit();
				}
			}
		</script>
		
		<!-- 조회 수,추천 수 중 정렬기준을 정하는 기능 array와 category 값을 같이넘겨서 카테고리 내에서도 정렬 기준을 선택 할 수 있음(전체목록 정렬이 안됨)-->
		<div class="main" id="rightbody" style="height: 100%; width: 1670px; float: right; overflow-x: auto;">
			<div class="dropdown">
				<button type="button"
					class="btn btn-outline-primary dropdown-toggle"
					data-toggle="dropdown">정렬 기준</button>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="#"
						onclick="location='boardArray.kly?array=추천&category=${category.BOARD_CATEGORY}'">추천
						수</a> <a class="dropdown-item" href="#"
						onclick="location='boardArray.kly?array=조회&category=${category.BOARD_CATEGORY}'">조회
						수</a>
				</div>
			</div>
			<!-- 간단한 정보만 출력하고 버튼 클릭시 영상과 함께 댓글을 볼 수 도있고 달 수 도있는 기능 
				display:none 으로 인해 보이지 않는 페이지가 버튼을 클릭하면 block으로 바뀌어서 볼수 있음 -->
			<c:forEach var="board" items="${boardlist}" varStatus="status">
				
				<div id="id0${status.count}" class="panel black display-container"
					style="display: none">
					<span onclick="this.parentElement.style.display='none'"><i
						class="fa fa-close btn-light"></i></span>
					
					<div>
						<div class="view" style="width: 46%; height: 494px">
							<div class="list-group" style="float: right">
								<div class="bg-light rounded-top"
									style="border: 1px solid; height: 32px; width: 560px;">
									<span style="font-size: 25px;">&nbsp;${board.BOARD_SUBJECT}</span>
									<span style="color: skyblue">&nbsp;&nbsp;${board.MEMBER_ID}</span>
								</div>
								<div>${board.BOARD_VIDEO_URL}</div>
							</div>
						</div>
						
						<div class="view"
							style="position: relative; width: 52%; height: 494px">
							<div class="bg-light rounded"
								style="width: 560px; height: 480px; border: 1px solid">
								<div style="border-bottom: 1px solid">
									<!--하나의 게시물에 계정당 한번의 추천 , 신고를 할 수 있음 , 자신의 게시물만 삭제 할 수 있음 
		 								게시번호 값과 로그인한 계정의 id 값을 넘겨 비교해 이미 추천,신고를 한번 했으면 더이상 못함
		 								삭제도 마찬가지로 작성자 id와 로그인중인 계정을 비교해 다르면 권한이 없다며 삭제되지 않음-->
									<div>
										<img class="btn-img" src="./images/like.png"
											onclick="location='boardLike.kly?board_num=${board.BOARD_NUM}&member_id=${loginInfo.MEMBER_ID}'">
										<span style="color: blue">${board.BOARD_LIKECOUNT}</span>
										<div class="btn-group">
											<img class="btn-img" src="./images/report.jpg"
												onclick="location='boardReport.kly?board_num=${board.BOARD_NUM}&member_id=${loginInfo.MEMBER_ID}'">
											&nbsp;<img class="btn-img" src="./images/delete.png"
												onclick="location='boardDelete.kly?board_num=${board.BOARD_NUM}&member_id=${loginInfo.MEMBER_ID}'">
										</div>
										<span style="color: cadetblue;"><img
											src="./images/tag.png">${board.BOARD_TAG }</span>
									</div>
								</div>
								<div>
									<!-- if문으로 댓글이 가진 게시번호 값과 현재 보고있는 게시번호 값이 일치하는 댓글들을 출력 -->
									<div>
										<c:forEach var="comment" items="${commentlist}">
											<c:if test="${comment.BOARD_NUM == board.BOARD_NUM}">
												<div>${comment.MEMBER_ID}:${comment.COMMENT_CON}</div>
											</c:if>
										</c:forEach>
									</div>
									<div style="vertical-align: bottom;">
										<!-- 댓글을 등록하는 부분  java.sql.SQLIntegrityConstraintViolationException 에러 뜸-->
										<form
											action="./boardComment.kly?board_num=${board.BOARD_NUM}&member_id=${loginInfo.MEMBER_ID}"
											method="post">
											<div class="input-group mb-3"
												style="width: 556px; position: absolute; bottom: 0px; margin-left: 1px">
												<input type="text" class="form-control" name="comment">
												<div class="input-group-append">
													<button class="btn btn-success" type="submit">등록</button>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			
			<c:set var="i" value="0" />
			<c:set var="j" value="5" />
			
			<table id="video">
				<c:forEach var="board" items="${boardlist}" varStatus="status">
					<c:if test="${i%j == 0 }">
						<tr>
					</c:if>
					<td>
						<div class="card" id="card" style="height: 260px">
							<div class="card-body text-center">
								<div class="videoplay">
									<img class="btn-img"
										src="https://img.youtube.com/vi/${board.BOARD_YOUTUBE_ID}/0.jpg"
										style="width: 200px; height: 120px;"
										onclick="viewCount('id0${status.count}', ${board.BOARD_NUM})">
									<div>
										<span class="writer" style="color: blueviolet;">${board.MEMBER_ID}</span>
										<span class="videotitle">${board.BOARD_SUBJECT}</span>
									</div>
									<div>
										<span class="videoCategory" style="color:lightpink">분류:${board.BOARD_CATEGORY}</span>
										<span class="videoLike" style="color: blue"><img
											src="./images/like.png">${board.BOARD_LIKECOUNT}</span> <span
											class="videoReadCount"><img src="./images/view.jpg">${board.BOARD_READCOUNT}</span>
									</div>
									<div>
										<span class="videoUptime">${board.BOARD_DATE}</span> <span
											class="videoTag" style="color: cadetblue"><img
											src="./images/tag.png">${board.BOARD_TAG}</span>
									</div>
								</div>
							</div>
						</div>
					</td>
					
					<c:if test="${i%j == j-1 }">
						</tr>
					</c:if>
					<c:set var="i" value="${i+1 }" />
				</c:forEach>
			</table>
			<div style="text-align: center">
				<%
					if (nowPage <= 1) {
				%>
				<button type="button" class="btn btn-outline-info">이전</button>
				<%
					} else {
				%>
				<button type="button" class="btn btn-outline-info"
					onclick="location='boardList.kly?page=<%=nowPage - 1%>'">이전</button>
				<%
					}
				%>
				<div class="btn-group">
					<%
					for (int a = startPage; a <= endPage; a++) {
						if (a == nowPage) {
				%>
					<button type="button" class="btn btn-info"><%=a%></button>
					<%
					} else {
				%>
					<button type="button" class="btn btn-outline-info"
						onclick="location='boardList.kly?page=<%=a%>'"><%=a%></button>
					<%
					}
				%>
					<%
					}
				%>
				</div>
				<%
					if (nowPage >= maxPage) {
				%>
				<button type="button" class="btn btn-outline-info">다음</button>
				<%
					} else {
				%>
				<button type="button" class="btn btn-outline-info"
					onclick="location='boardList.kly?page=<%=nowPage + 1%>'">다음</button>
				<%
					}
				%>


			</div>
		</div>
	</div>



	<!-- 게시글 등록 -->
	<form action="./boardWrite.kly" method="get" id="boardWrite"
		onsubmit="return alertSelectCategory()">
		<div class="modal fade" id="board">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">게시물 등록</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<div class="form-group" id="category">
							<label for="category" style="display: inline;">분류</label> <select
								class="form-control" name="category" id="selectedCategory">
								<option value="select" selected="selected">분류를 선택하세요</option>
								<!-- '게시판을 선택하세요'입력하면 alert : '게시판을 선택하세요' -->
								<option value="유머">유머</option>
								<option value="정보">정보</option>
								<option value="게임">게임</option>
								<option value="감동">감동</option>
								<option value="스포츠">스포츠</option>
								<option value="취미">취미</option>
								<option value="동물">동물</option>
								<option value="기타">기타</option>
							</select>
						</div>

						<input type=hidden name="ID" value="${loginInfo.getMEMBER_ID()}">

						<div id="subject">
							<label for="subject" style="display: inline;">제목</label> <input
								type="text" class="form-control" name="subject" maxlength="30"
								placeholder="게시글 제목을 입력하세요" required>
						</div>

						<div id="video">
							<label for="video_upload">동영상 올리기</label>
							<input type="radio" id="video_upload" name="videoFile" value="upload" 
							onclick="switchDisplay('input_upload');">
							
							<label for="video">URL</label>
							<input type="radio" id="video_URL" name="videoURL" value="url" checked="checked">

							<div id="input_url">
								<input type="url" class="form-control" name="video_URL"
									placeholder="https://">
							</div>
						</div>
	

						<div id="tag">
							<label for="tag">태그</label> <input type="text"
								class="form-control" name="tag" maxlength="30"
								placeholder="태그와 태그는 해쉬태그로 구분하며, 30자까지 입력하실 수 있습니다.">
							<!-- <input type="text" name="tagnames" id="tagnames" class="box_input _click(TagValidator|TagNames) _keyup(TagValidator|ValidateTagNames) _blur(TagValidator|ValidateTagNames)"> -->
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">등록</button>
							<!-- data-dismiss="modal" -->
						</div>
					
					</div>
				</div>
			</div>
		</div>
	</form>

	<script>
		function alertSelectCategory() {
			var whatCategory = document.getElementById("selectedCategory");
			if (whatCategory.value == "select") {
				alert('게시판을 선택하세요.');
				document.getElementById("category").focus();
				return false;
			} else {
				return true;
			}
		}
	</script>

</body>
</html>