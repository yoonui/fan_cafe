<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>나의 배나무</title>
</head>
<body>
	<%
		session.invalidate(); // 접속한 회원의 세션의 뺴앗음
	%>
	
	<script>
	location.replace('/ChulBae');
	</script>
</body>
</html>

