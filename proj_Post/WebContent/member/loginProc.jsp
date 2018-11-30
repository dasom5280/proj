<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pack_JDBC.*" %>    
    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />
<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");
boolean result = mMgr.loginMember(id, pass);

String url = "login.jsp";
String msg = "아이디와 비밀번호를 확인해주세요";

if (result) {
	session.setAttribute("idKey", id);
	msg = id + " 님 안녕하세요~ ";
}
%>

    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8"> 
<title>JSP 테스트</title>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>

</head>
<body>
	<div id="wrap">
		

	</div>
</body>
</html>