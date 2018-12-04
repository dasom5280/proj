<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="session" />
<jsp:useBean id="upBean" class="pack_Bean.MemberBean" scope="session" />
<jsp:setProperty property="*" name="upBean" />

<%
	mMgr.updateMember(upBean);
	session.setAttribute("loginBean", upBean);
	String url = "passCheck.jsp;";
	response.sendRedirect(url);
		
%>
	<script>
	alert("회원정보가 수정되었습니다.");
	</script>
</head>
<body>
	<div id="wrap"></div>
	
</body>
</html>