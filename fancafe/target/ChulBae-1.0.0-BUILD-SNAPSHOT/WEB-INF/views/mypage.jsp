<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BOARD" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="user.USERS" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
	<title>나의 배나무</title>
</head>
<body>
	
	<% // 로그인한 회원인지 확인
		String userID = null;
		if (session.getAttribute("id") != null) {
			userID = (String) session.getAttribute("id");
		}
		
		USERS user = new UserDAO().getuser(userID);
	%>
	
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
			<form method="post" action="mypageAction">
				<h2>마이페이지</h2>
				<table class="maypage-table">
					<tr>
						<td>아이디</td>
						<td><%=user.getId() %></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" placeholder="비밀번호" name="pw" maxlength="20" value="<%=user.getPw()%>"></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type="text" placeholder="닉네임" name="nickname" maxlength="10" value="<%=user.getNickname()%>"></td>
					</tr>
				</table>
				<div class="login-btn"><input type="submit" value="회원수정"></div>
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