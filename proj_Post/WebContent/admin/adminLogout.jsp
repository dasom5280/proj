<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>Admin Logout</title>
<%
session.invalidate();
%>
<script>
	alert("로그아웃 하셨습니다.");
	location.href="../index.jsp";
</script>

</head>
<body>
	<div id="wrap"></div>
</body>
</html>