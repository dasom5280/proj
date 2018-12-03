<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pack_JDBC.*" %>    
    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="pack_JDBC.adminMgr" scope="page" />
<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");

if((id.equals("admin") && pass.equals("1234"))){ //이 줄에서 에러남
	session.setAttribute("id", id);
	response.sendRedirect("adminMain.jsp");
} else {
	response.sendRedirect("adminLogin.jsp");
}
%>

    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8"> 
<title>프로젝트</title>
<script>
	alert("로그인 실패");
	location.href="adminLogin.jsp";
</script>

</head>
<body>
	<div id="wrap">
		

	</div>
</body>
</html>