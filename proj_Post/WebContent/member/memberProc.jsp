<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />
<jsp:useBean id="bean" class="pack_Bean.MemberBean" scope="page" />
<jsp:setProperty name="bean" property="*" />

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script>
<%
boolean result = mMgr.insertMember(bean);
String msg = "";
String url = "";
if(result) {
%>
	alert("회원가입을 하였습니다.");
	location.href="login.jsp";
<%
} else {
%>
	alert("회원가입에 실패하였습니다.");
	history.back();
<%
}
%>
	

</script>
</head>
<body>
</body>
</html>