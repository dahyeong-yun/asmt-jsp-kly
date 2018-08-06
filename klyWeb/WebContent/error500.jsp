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
	<div class="container" style="max-width:560px;text-align: center;">
		<h1>500 Error</h1>
		<img src="error/500robot.svg" style="max-width:300px;" />
		<div class="alert alert-warning mt-4" role="alert">
			페이지가 동작하지 않습니다.
		</div>
	</div>

	<!-- 하단바(footer) -->
	<div class="jumbotron text-center">
		<p>&copy; 2018 kly</p>
	</div>

</body>
</html>
