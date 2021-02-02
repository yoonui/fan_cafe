<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BOARD" %> <!-- Board의 클래스를 가져옴 -->
<%@ page import="board.BoardDAO" %> <!-- BoardDAO의 클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>나의 배나무</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("id") != null) {
			userID = (String) session.getAttribute("id");
		}
		
		/* 글이 유효한지 판별*/
		int bbsid = 0;
		if(request.getParameter("bbsid") != null){
			bbsid = Integer.parseInt(request.getParameter("bbsid"));
		}
		if(bbsid == 0) {
			PrintWriter s = response.getWriter();
			s.println("<script> alert('유효하지 않은 글입니다.'); location.href='/ChulBae'; </script>");
		}
		
		BoardDAO boarddao = new BoardDAO();
		int r = boarddao.delete(bbsid);
		if(r == -1) {
			PrintWriter s = response.getWriter();
			s.println("<script> alert('글 삭제에 실패했습니다.'); history.back(); </script>");
		}
		else {
			PrintWriter s = response.getWriter();
			s.println("<script> alert('글 삭제에 성공했습니다.'); location.href='/ChulBae'; </script>");
		}
	%>
</body>
</html>

