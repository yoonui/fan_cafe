<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- UserDAO의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 1명의 회원정보를 담는 user 클래스를 자바 빈즈로 사용 -->
<jsp:useBean id="user" class="user.USERS" scope="page"/>
<jsp:setProperty name="user" property="id"/>
<jsp:setProperty name="user" property="pw"/>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>나의 배나무</title>
</head>
<body>
	<%
		UserDAO userdao = new UserDAO();
		int result = userdao.login(user.getId(), user.getPw());
		
		if(result == 1){
			session.setAttribute("id", user.getId()); // 로그인한 회원에게 세션 부여
			PrintWriter script = response.getWriter();
			script.println("<script> location.replace('/ChulBae'); </script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script> alert('비밀번호가 틀립니다.'); history.back(); </script>");
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script> alert('존재하지 않는 아이디입니다.'); history.back(); </script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script> alert('DB 오류가 발생했습니다.'); history.back(); </script>");
		}
	%>
</body>
</html>


