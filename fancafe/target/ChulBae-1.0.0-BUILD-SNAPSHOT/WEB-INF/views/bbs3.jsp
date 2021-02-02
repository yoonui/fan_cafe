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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bbs.css">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
	<title>나의 배나무</title>
</head>
<body> <!-- 철배가 -->

	<% // 로그인한 회원인지 확인
		String userID = null;
		if (session.getAttribute("id") != null) {
			userID = (String) session.getAttribute("id");
		}
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs3">철배가</a></li>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs4">철배에게</a></li>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs5">철배님 뉴짤</a></li>
            </ul>
            <div class="cafe-menus-title">
                <h3>팬 잔치</h3>
            </div>
            <ul>
                <li><img src="${pageContext.request.contextPath}/resources/img/post.png" width="12" height="12"><a href="/ChulBae/bbs6">자유 게시판</a></li>
            </ul>
        </div>

        <div class="main-area">
            <div class="cafe-post-all"><h3>철배가</h3></div>
            <div class="cafe-post">
           		<ul>
                    <li>제목</li>
                    <li>작성자</li>
                    <li>작성일</li>
                </ul>
              
                <%
                	BoardDAO boarddao = new BoardDAO();
                	ArrayList<BOARD> list = boarddao.getList(pageNumber, "철배가");
                	for(int i = 0; i<list.size(); i++){
                %>
                <ul class="cafe-post-middle">
                    <li><div class="cafe-post-dot"></div><a href="/ChulBae/view?location=bbs3&&bbsid=<%=list.get(i).getBbsid()%>"><%=list.get(i).getBbsTitle()%></a></li>
                    <li><%=list.get(i).getNickname()%></li>
                    <li><%=list.get(i).getBdDate()%></li>
                </ul>
                <% } %>
            </div>
            
            <% if(userID != null) {%>
	            <div class="cafe-write">
	                <a href="/ChulBae/write"><span>글쓰기</span></a>
	            </div>
            <%} %>
             <%if(pageNumber!=1) {%>
	            <div class="cafe-arrow">
	                <a href="/ChulBae/bbs3?pageNumber=<%=pageNumber-1%>"><span>이전</span></a>
	            </div>
            <%} if(boarddao.nextPage(pageNumber+1, "철배가")) {%>
	            <div class="cafe-arrow">
	                <a href="/ChulBae/bbs3?pageNumber=<%=pageNumber+1%>"><span>다음</span></a>
	            </div>
            <%} %>
            
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