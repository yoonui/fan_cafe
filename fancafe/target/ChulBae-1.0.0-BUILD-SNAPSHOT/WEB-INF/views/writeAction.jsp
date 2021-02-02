<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- UserDAO의 클래스 가져옴 -->
<%@ page import="board.BoardDAO" %> <!-- BoardDAO의 클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%> <!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 1명의 회원정보를 담는 user 클래스를 자바 빈즈로 사용 -->
<jsp:useBean id="board" class="board.BOARD" scope="page" />
<jsp:setProperty name="board" property="bdpost" />
<jsp:setProperty name="board" property="bbsTitle" />
<jsp:setProperty name="board" property="bbsContent" />

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>나의 배나무</title>
</head>
<body>
	<%
		String userID = (String)session.getAttribute("id");
	
		UserDAO userdao = new UserDAO();
		String userNickname = userdao.nick(userID);
		
		if(board.getBdpost() == null || board.getBbsTitle() == null || board.getBbsContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script> alert('빈칸 없이 입력해주세요.'); history.back(); </script>");
		}
		else {
			BoardDAO boardDAO = new BoardDAO(); // 인스턴스 생성
			int result = boardDAO.write(board.getBbsTitle(), userID, userNickname, board.getBbsContent(), board.getBdpost());
			
			if(result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script> alert('글쓰기에 실패했습니다.'); history.back(); </script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script> location.href='/ChulBae'; </script>");
			}
		}
	%>
</body>
</html>

