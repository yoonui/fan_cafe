<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BOARD" %>
<%@ page import="board.BoardDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view.css">
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
		
		String str = request.getParameter("location");
		if(str == null){
			str="";
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
				<li class="dot"><a href="/ChulBae/profile" title="철배프로필">철배님 프로필</a></li>
				<li class="dot"><a href="/ChulBae/bbs3" title="철배말">철배님 말씀</a></li>
				<li class="dot"><a href="/ChulBae/bbs4" title="철배뉴짤">철배님 뉴짤</a></li>
				<li><a href="/ChulBae/bbs5" title="자유게시판">자유게시판</a></li>
			</ul>
		</div>
	</div>
	
	<div style="padding:20px;">
    </div>
    
    <div class="main">
        <div class="cafe-box-menus">
        	<% if(userID == null) {%>
	            <div class="cafe-login">
	                <a href="/ChulBae/login"><span>로그인</span></a>
	            </div>
	            <div class="cafe-join">
	                <a href="/ChulBae/join"><span>회원가입</span></a>
	            </div>
            <% } else { %>
	            <div class="cafe-mypage">
	                <a href="/ChulBae/mypage"><span>마이페이지</span></a>
	            </div>
	            <div class="cafe-logout">
	                <a href="logoutAction"><span>로그아웃</span></a>
	            </div>
            <% } %>
        </div>
        
        <div class="cafe-menus">
            <ul>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs1">전체글보기</a></li>
            </ul>
            <ul>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs2">공지사항</a></li>
            </ul>
            <div class="cafe-menus-title">
                <h3>철배님과 함께</h3>
            </div>
            <ul>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/profile">철배님 프로필</a></li>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs3">철배님 말씀</a></li>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs4">철배님 뉴짤</a></li>
            </ul>
            <div class="cafe-menus-title">
                <h3>팬 잔치</h3>
            </div>
            <ul>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs5">자유 게시판</a></li>
            </ul>
        </div>

        <div class="main-area">
        	<div>
        		<% if(userID !=null && userID.equals(bbs.getUserid())) {%>
                <a href="/ChulBae/update?bbsid=<%=bbsid%>" class="list-btn"><span>수정</span></a>
                <a onclick="return confirm('삭제하시겠습니까?')" href="/ChulBae/deleteAction?bbsid=<%=bbsid%>" class="list-btn"><span>삭제</span></a>
                <% } %>
                <a href="/ChulBae/<%=str%>" class="list-btn"><span>목록</span></a>
            </div>
        	<div class="post">
            	<div class="post-title">
                    <h2><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></h2>
                    <img src="${pageContext.request.contextPath}/resources/img/heart.png">
                    <p><%=bbs.getNickname()%><br><span><%=bbs.getBdDate()%></span></p>
            	</div>
            	<div class="post-content">
            		<p><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></p>
            	</div>
            </div>
            <div></div>
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