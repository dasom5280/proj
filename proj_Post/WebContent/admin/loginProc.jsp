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
		mMgr.insertARecord(id, ip);
		session.setAttribute("id", id);
		url = "adminMain.jsp";
		msg = "관리자로 로그인 됨";
	} else {
		msg = "로그인 실패";
	}
%>


<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>프로젝트</title>
<script>
	alert("<%=msg%>");
	location.href= "<%=url%>";
</script>

</head>
<body>
	<div id="wrap"></div>
</body>
</html>