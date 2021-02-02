<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- UserDAO의 클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%> <!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 1명의 회원정보를 담는 user 클래스를 자바 빈즈로 사용 -->
<jsp:useBean id="user" class="user.USERS" scope="page" />
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="pw" />
<jsp:setProperty name="user" property="nickname" />

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>나의 배나무</title>
</head>
<body>
	<%
		if(user.getId() == null || user.getPw() == null || user.getNickname() == null){
			PrintWriter script = response.getWriter();
			script.println("<script> alert('빈칸 없이 입력해주세요.'); history.back(); </script>");
		}
		else {
			UserDAO userDAO = new UserDAO(); // 인스턴스 생성
			if(userDAO.overlap(user.getId(), user.getNickname()) == 0){
				PrintWriter s = response.getWriter();
				s.println("<script> alert('닉네임이 중복됩니다.'); history.back(); </script>");
			}
			else{
			
				int result = userDAO.join(user);
				
				if(result == -1) { // id가 기본키. 중복되면 오류.
					PrintWriter script = response.getWriter();
					script.println("<script> alert('이미 존재하는 아이디입니다.'); history.back(); </script>");
				}
				else { // 회원가입 성공
					PrintWriter script = response.getWriter();
					script.println("<script> location.replace('/ChulBae'); </script>");
				}
			}
		}
	%>
</body>
</html>

