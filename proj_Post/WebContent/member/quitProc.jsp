<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

<%
	request.setCharacterEncoding("utf-8");
	String insPass = request.getParameter("pass");
	MemberBean bean = (MemberBean) session.getAttribute("loginBean");

	String oriPass = bean.getPass();

	if (!insPass.equals(oriPass)) {
%>
<script>
	alert("비밀번호가 일치하지 않습니다");
	location.href = "quitMember.jsp";
</script>
<%
	} else {
%>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />

<%
	boolean chkDel = mMgr.deleteMember(bean.getId(), insPass);
		if (chkDel) {
			session.invalidate();
%>
<script>
	alert("탈퇴가 완료되었습니다.");
	location.href = "../main.jsp";
</script>
<%
	} else {
%>
<script>
	alert("비밀번호가 일치하지 않습니다");
	history.back();
</script>
<%
	}

	}
%>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>