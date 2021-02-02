<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BOARD" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
	<title>나의 배나무</title>
</head>
<body>
	<div>
		<div style="padding:10px;"></div>
		<div class="banner">
			<a href="/ChulBae">
				<img src="${pageContext.request.contextPath}/resources/img/banner.jpg" alt="나의배나무" width="1080"/>
			</a>
		</div>
	</div>
	<div class="special-menu">
		<div class="box-special-menu">
			<ul class="special-menus">
				<li class="dot"><a href="/ChulBae/bbs1" title="전체 게시글">전체글보기</a></li>
				<li class="dot"><a href="/ChulBae/bbs2" title="공지사항">공지사항</a></li>
				<li class="dot"><a href="/ChulBae/bbs3" title="철배가">철배가</a></li>
				<li class="dot"><a href="/ChulBae/bbs4" title="철배에게">철배에게</a></li>
				<li class="dot"><a href="/ChulBae/bbs5" title="철배뉴짤">철배님 뉴짤</a></li>
				<li><a href="/ChulBae/bbs6" title="자유게시판">자유게시판</a></li>
			</ul>
		</div>
	</div>
	
	<div style="padding:30px;">
    </div>
	
	<div class="cafe-login">
		<div class="cafe-loging">
			<form method="post" action="loginAction">
				<h2>로그인화면</h2>
				<div class="form-login">
					<input type="text" placeholder="아이디" name="id" maxlength="10">
				</div>
				<div class="form-login">
					<input type="password" placeholder="비밀번호" name="pw" maxlength="20">
				</div>
				<div class="login-btn"><input type="submit" value="로그인"></div>
			</form>
		</div>
	</div>
    <div>
    
        <footer class="foot">
            <h5>나의 배나무 | 네이버카페 디자인을 참고하였습니다.</h5>
        </footer>
        </div>
	<!-- 애니메이션 담당 제이쿼리 -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
	<!-- 부트스트랩 JS -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
</body>
</html>