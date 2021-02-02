<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.USERS" %>
<%@ page import="user.UserDAO" %>
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
		/* 마이페이지에서 아이디를 받아옴 */
		String userid = null;
		if (session.getAttribute("id") != null) {
			userid = (String) session.getAttribute("id");
		}
		
		USERS bbs = new UserDAO().getuser(userid);
		
		if(request.getParameter("pw") == null || request.getParameter("nickname") == null
			|| request.getParameter("pw").equals("") || request.getParameter("nickname").equals("")) {
			PrintWriter s = response.getWriter();
			s.println("<script> alert('빈칸 없이 입력해주세요.'); history.back(); </script>");
		}
		else {
			UserDAO userdao = new UserDAO();
			if(userdao.overlap(userid, request.getParameter("nickname")) == 0){
				PrintWriter s = response.getWriter();
				s.println("<script> alert('닉네임이 중복됩니다.'); history.back(); </script>");
			}
			else{
				int r = userdao.update(userid, request.getParameter("pw"), request.getParameter("nickname"));
				if(r == -1) {
					PrintWriter s = response.getWriter();
					s.println("<script> alert('회원 수정에 실패했습니다.'); history.back(); </script>");
				}
				else {
					PrintWriter s = response.getWriter();
					s.println("<script> alert('회원 수정이 완료되었습니다.'); location.href='/ChulBae'; </script>");
				}
			}
		}
	%>
</body>
</html>

