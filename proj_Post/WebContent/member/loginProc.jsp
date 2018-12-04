<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pack_JDBC.*" %>    
    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />
<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String ip = request.getParameter("ip");
boolean result = mMgr.loginMember(id, pass);

String url = "login.jsp";
String msg = "아이디와 비밀번호를 확인해주세요";

if (result) {
	MemberBean bean = new MemberBean();
	
	bean = mMgr.getMember(id, pass);
	
	if(bean != null){
	mMgr.insertARecord(id, ip);
	
	session.setAttribute("loginBean", bean);
	
	msg = id + " 님 안녕하세요~ ";
	url = "../main/main.jsp";
	} else {
		msg = "예외 발생";
	}
}
%>

    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8"> 
<title>로그인</title>
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