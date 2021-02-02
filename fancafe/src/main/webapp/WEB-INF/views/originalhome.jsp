<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<title>나의 배나무</title>
	<style>
		.banner{
			text-align:center;
		}
		.Text{
			text-align:center;
			font-family: 'Noto Sans KR', sans-serif;
		}
	</style>
</head>
<body>
	<% // 로그인한 회원인지 확인
		String userID = null;
		if (session.getAttribute("id") != null) {
			userID = (String) session.getAttribute("id");
		}
	%>
	
	<nav class="navbar navbar-default"'>
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expaned="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/ChulBae/">나의 배나무</a>
		</div>
		<div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="/ChulBae/">메인</a></li>
				<li><a href="/ChulBae/bbs">게시판</a></li>
			</ul>
			<% if(userID==null) { // 로그인X %>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/ChulBae/login">로그인</a></li>
						<li><a href="/ChulBae/join">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<% } else { %>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/ChulBae/mypage">마이페이지</a></li>
							<li><a href="logoutAction">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			<% } %>
		</div>
	</nav>
	
	
	<div class="jumbotron" style="padding-top: 20px;">
		<h1 class="Text" style="padding-bottom:20px; font-size:50px;">@@@ 나의 배나무 @@@</h1>
		<div class="banner">
			<img src="${pageContext.request.contextPath}/resources/img/banner.jpg" style="margin-top:20px;"/>
		</div>
		<h3 class="Text" style="margin:50px;">곽철배 팬카페 '나의 배나무'에 오신 것을 환영합니다@^.^@</h3>
		<div class="Text" style="margin:20px; font-size:20px;"><a href="/ChulBae/profile">곽철배 프로필</a></div>
		<div class="Text" style="margin:20px; font-size:20px;">곽철배 인스타 -> 해킹당했어요ㅠㅠ</div>
		<div class="Text" style="margin:20px; font-size:20px;">곽철배 유튜브 -> 해킹당했어요ㅠㅠ</div>
	</div>
	
	<!-- 애니메이션 담당 제이쿼리 -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
	<!-- 부트스트랩 JS -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
</body>
</html>


