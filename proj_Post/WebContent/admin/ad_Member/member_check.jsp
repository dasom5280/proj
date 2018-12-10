<%@page import="pack_Bean.Ad_QnABean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page"/>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("mid");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호</title>
</head>
<body>
	<div id="wrap">
	<form name="deleteFrm">
	<table>
				<tr>
					<td>
					ID :<%=id%>를(을) 탈퇴처리하시겠습니까?
					</td>
				</tr>
				<tr>
					<td>
					<input type="button" value="탈퇴" onclick="delCheck()">
					&nbsp;&nbsp;
					<input type="button" value="취소" onclick="self.close()">
					</td>
				</tr>
	</table>
	</form>
	</div>
	<script type="text/javascript">
	function  delCheck(){
	
		opener.document.delFrm.id.value = "<%= id %>";
		opener.document.delFrm.action="member_delete.jsp";
		opener.document.delFrm.submit();
		self.close();
	}
	</script>
</body>
</html>