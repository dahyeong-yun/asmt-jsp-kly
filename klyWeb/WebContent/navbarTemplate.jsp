<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<!-- 상단 고정바(navbar) -->
<%

%>
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
        <!-- Brand/logo -->
        <a href="./index.jsp"><img src="./images/kly_logo_white.png" style="height: 45px" /></a>

        <!-- Links -->
		<ul class="navbar-nav mx-auto">
		    <li class="nav-item">
				<a class="btn btn-outline-warning" style="width:300px;" href="./boardList.kly">video list</a>
			</li>
		</ul>
        
        <c:choose>
        	<c:when test="${empty loginInfo.getMEMBER_ID()}">
        		<div class="btn-group">
		       		<button class="btn btn-outline-primary" data-toggle="modal" data-target="#loginForm">
						로그인
					</button>
		       		<button class="btn btn-outline-primary" data-toggle="modal" data-target="#joinForm">
						회원가입
		       		</button>
        		</div>
        	</c:when>
			
			<c:when test="${loginInfo.getMEMBER_ID().equals('admin')}">
        		<div class="btn-group">
		       		 <button class="btn btn-outline-info" onclick="location.href='./boardSuspendList.kly'">
	        	    	관리자 모드
	        	    </button>
	        	    <button class="btn btn-outline-danger" onclick="location.href='./memberLogout.kly'">
	        	    	로그아웃
	        	    </button>
        		</div>
        	</c:when>
        	
        	<c:otherwise>
	        	<div class="btn-group">
	        	    <button class="btn btn-outline-primary" onclick="location.href='./memberDetail.kly'">
	        	    	마이페이지
	        	    </button>
	        	    <button class="btn btn-outline-danger" onclick="location.href='./memberLogout.kly'">
	        	    	로그아웃
	        	    </button>
	        	</div>
        	</c:otherwise>
        </c:choose>
		
        <!-- 로그인(modal) -->
        <div class="modal" id="loginForm">
            <div class="modal-dialog">
                <div class="modal-content">
                    
                       <div class="modal-header">
                        <h4 class="modal-title">로그인</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    
                    <form action="memberLogin.kly" method="post">
                        <div class="form-group">
                            <div class="modal-body">
                                    <div class="container">
                                       <a href="./index.jsp"><img src="./images/kly.png" style="display:block; height: 300px" /></a>
                                    </div>
                                    
                                    <h5><label>아이디</label></h5>
                                    <input class="form-control" name="loginId" type="text" id="id" />
                                    <h5><label>비밀번호</label></h5>
                                    <input class="form-control" name="loginPwd" type="password" id="pwd" />
                                    <a data-toggle="modal" data-target="#MissingForm"><u>혹시 비밀번호를 잊어버리셨나요?</u></a>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-primary" type="submit">로그인</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
<script>
	/* 아이디 중복체크 */
	function idCheck() {
		var memberID = $('#id').val();
		$.ajax({
			type : "POST",
			url : "./memberJoinIdCheck.kly",
			data: {memberID : memberID},
			success: function(result) {
				if(result == 1) {
					$('#idCheckMessage').html('사용할 수 있는 아이디 입니다.');
					$('#checkType').attr('class','modal-content pannel-success');
				} else {
					$('#idCheckMessage').html('사용할 수 없 아이디 입니다.');
					$('#checkType').attr('class','modal-content pannel-warning');
				}
				$('#idCheckForm').modal("show");
			}
			
		})
	}
	
	function passCheck() {
		var pass1 = $("#pass1").val();
		var pass2 = $("#pass2").val();
		if(pass1 != pass2) {
			$("#passCheckMessage").html("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		} else {
			$("#passCheckMessage").html("");
		}
	}
</script>
        <!-- 회원가입(modal) -->
        <div class="modal" id="joinForm">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">회원가입</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <form action="memberJoin.kly" method="post">
                        <div class="form-group">
                            <div class="modal-body">
                                <div class="row">
									<div class="col-sm">
		                                <h5><label>아이디</label></h5>
		                                <input class="form-control" name="MEMBER_ID" type="text" id="id" placeholder="아이디를 입력해 주세요."/>
									<!-- </div>
									<div class="col-sm">
										<button class="btn btn-primary" onclick="idCheck()">아이디 중복체크</button> -->
									</div>
                                </div>

                                <div class="row mt-2 mb-2">
                                   <div class="col-sm">
                                       <label><h5>비밀번호</h5></label>
                                        <input class="form-control" name="MEMBER_PW" type="password" id="pass1" onkeyup="passCheck()" placeholder="비밀번호를 입력해 주세요."/>
                                    </div>
                                    <div class="col-sm">
                                        <label><h5>비밀번호 확인</h5></label>
                                        <input class="form-control" type="password" id="pass2" onkeyup="passCheck()" placeholder="비밀번호를 한번 더  입력해 주세요."/>
                                    </div>
                                </div>
                                
                                <label><h5>이메일</h5></label>
                                <input class="form-control" name="MEMBER_EMAIL" type="email" id="email" placeholder="이메일을 입력해 주세요."/>
                                
                                    
                            </div>
							<div class="modal-footer">
								<p style="color:red;" id="passCheckMessage"></p>
                                <button class="btn btn-primary" type="submit">가입</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

	<!-- 회원 비밀번호 찾기(modal) -->
	<form action="memberFindPass.kly" method="post">
	<div class="modal" id="MissingForm">
		<div class="modal-dialog  modal-lg">
			<div class="modal-content">
                   <div class="modal-header">
                       <h4 class="modal-title">비밀번호 찾기</h4>
                       <button type="button" class="close" data-dismiss="modal">&times;</button>
                   </div>
				
				<div class="modal-body">
					현재 아이디를 입력하시면, 가입 정보에 기입된 이메일로 안내 메일을 발송해 드립니다.
						<input class="form-control" type="text" name="memberID" placeholder="아이디를 입력해주세요.">
				</div>
				
				<div class="modal-footer">
					<p style="color:red;" id="passCheckMessage"></p>
					<button class="btn btn-info" type="submit">이메일 전송</button>
	
				</div>
			</div>
		</div>
	</div>
	</form>
	
	<!-- 아이디 중복 체크 -->
	<div class="modal" id="idCheckForm" tabindex="-1" role="diolog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content panel-info %>" id="checkType">
				 <div class="modal-header">
					<h4 class="modal-title">확인 메세지</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				
				<div class="modal-body" id="idCheckMessage">
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>
	</nav>
    
</body>
</html>