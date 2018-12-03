<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pack_JDBC.*"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />
<%
String id = request.getParameter("id");
boolean result = mMgr.checkId(id);
%>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>ID중복체크</title>
<style>
</style>
</head>
<body>
	<div id="wrap">
	<form name="idCheckFrm" method="post" action="idCheck.jsp" style="text-align: center; font-size: 20px; margin-top: 30px;">
			<%=id%>
			<%
if (result) {
	out.print(" 는 사용중인 ID입니다.");
	%> 
	<input type="hidden" name="check" value="0">
	
	<%
} else {
	out.print(" 는 사용가능합니다.");
	%>
	<input type="hidden" name="check" value="1">
	<% 
}
%>
			<br>
			<br> <a href="#" onclick="chkClose()">닫기</a>
		</form>

	</div>
	
	<script>
	function chkClose(){
		opener.regFrm.idChkValue.value = document.idCheckFrm.check.value;
		self.close();
	}
	
	</script>
</body>
</html>