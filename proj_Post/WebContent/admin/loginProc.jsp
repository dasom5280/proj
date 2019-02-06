<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pack_JDBC.*"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="aMgr" class="pack_JDBC.adminMgr" scope="page" />
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />

<%
	String id = request.getParameter("adminId");
	String pass = request.getParameter("adminPw");
	String ip = request.getParameter("ip");

	boolean result = aMgr.loginAdmin(id, pass);

	String url = "adminLogin.jsp";
	String msg = "아이디와 비밀번호를 확인해주세요";

	if (result) { //이 줄에서 에러남
		MemberBean bean = new MemberBean();
		bean = mMgr.getMember(id, pass);
		if(bean != null){
		mMgr.insertARecord(id, ip);
	
		session.setAttribute("adminBean", bean);
		
		url = "adminMain.jsp";
		msg = "관리자로 로그인 됨";
	} else {
		msg = "로그인 실패";
	}
	}
%>


<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<script>
	alert("<%=msg%>");
	location.href= "<%=url%>";
</script>

</head>
<body>
	<div id="wrap"></div>
</body>
</html>