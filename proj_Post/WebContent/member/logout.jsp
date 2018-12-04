<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	session.invalidate();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
<script>
	alert("로그아웃 되었습니다.");
	location.href = "../main/main.jsp";
</script>
<style>
div#wrap {
	width: 640px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>