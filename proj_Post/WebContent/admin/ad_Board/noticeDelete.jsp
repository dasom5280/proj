<%@page import="pack_Bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>Board Delete</title>
<link rel="stylesheet" href="../../css/ad_Board.css">

<jsp:useBean id="bMgr" class="pack_JDBC.BoardMgr" scope="page"/>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	if (request.getParameter("pass") != null) {
		
		String inPass = request.getParameter("pass");
		BoardBean bean = bMgr.getBoard(num);
		String oriPass = bean.getPass();
	
		if (inPass.equals(oriPass)) {
			bMgr.deleteBoard(num);
			String url = "noticeList.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
		} else {
%>
	<script>
		alert("입력하신 비밀번호가 아닙니다.");
		history.back();
	</script>
<%
		}
		
	} else {
%>

<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div id="wrap">
		<h3 style="text-align:center;">사용자의 비밀번호를 입력해주세요.</h3>
		<form name="delFrm" method="post" action="noticeDelete.jsp">
			<table class="deleteTable">
				<tr>
					<td><input type="password" name="pass" size="17"
						maxlength="15"></td>
				</tr>

				<tr>
					<td><span></span></td>
				</tr>

				<tr>
					<td><input type="button" value="삭제완료" onclick="check()">
						<input type="reset" value="다시쓰기"> <input type="button"
						value="뒤로" onclick="history.go(-1)"></td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage %>">
			<input type="hidden" name="num" value="<%=num %>">
		</form>
		
		<%} %>
	</div>
	<script>
		function check() {
			if (document.delFrm.pass.value == "") {
				alert("패스워드를 입력하세요.");
				document.delFrm.pass.focus();
				return false;
			}
			document.delFrm.submit();
		}
	</script>
</body>
</html>