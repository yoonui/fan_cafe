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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/write.css">
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
		
		int bbsid = 0;
		if(request.getParameter("bbsid") != null){
			bbsid = Integer.parseInt(request.getParameter("bbsid"));
		}
		if(bbsid == 0){
			PrintWriter s = response.getWriter();
			s.println("<script>alert('유효하지 않은 글입니다.'); location.href='/ChulBae'; </script>");
		}
		
		BOARD bbs = new BoardDAO().getBbs(bbsid);
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
	
	<div style="padding:20px;">
    </div>
    
	<div class="cafe-write">
		<h3>카페 글쓰기</h3>
		<div class="cafe-post-write">
			<div class="post-m">
				<form method="post" action="updateAction?bbsid=<%=bbsid%>">
					<select name="bdpost" class="post-select">
						<% if(bbs.getBdpost().equals("철배에게")) { %>
							<option value="철배에게">철배에게</option>
						<% } %>
						<% if(bbs.getBdpost().equals("철배님 뉴짤")) {%>
							<option value="철배님 뉴짤">철배님 뉴짤</option>
						<% } %>
						<% if(bbs.getBdpost().equals("자유게시판")) {%>
							<option value="자유게시판">자유게시판</option>
						<% } %>
					</select>
					<table>
						<tr>
							<td><input type="text" class="post1" placeholder="글 제목" name="bbsTitle" maxlength="20" value="<%=bbs.getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="post2" placeholder="글 내용" name="bbsContent" maxlength="2048"><%=bbs.getBbsContent()%></textarea></td>
						</tr>
					</table>
					<input type="submit" class="post-btn" value="글수정">	
				</form>
			</div>
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