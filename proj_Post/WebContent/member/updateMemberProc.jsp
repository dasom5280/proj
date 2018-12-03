<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />
<jsp:useBean id="upBean" class="pack_Bean.MemberBean" scope="page" />
<jsp:setProperty property="*" name="upBean" />

<%
	mMgr.updateMember(upBean);
	session.setAttribute("loginBean", upBean);
	String url = "updateMember.jsp";
	response.sendRedirect(url);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>