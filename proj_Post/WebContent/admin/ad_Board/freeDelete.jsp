<%@page import="pack_Bean.freeBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>freeBoard Delete</title>
<link rel="stylesheet" href="../css/ad_freeBoard.css">

<jsp:useBean id="bMgr" class="pack_JDBC.freeBoardMgr" scope="page"/>
<%@page import="pack_Bean.MemberBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean memberbean = (MemberBean) request.getAttribute("adminBean");

	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	if (request.getParameter("pass") != null) {
		
		String inPass = request.getParameter("pass");
		freeBoardBean bean = bMgr.getfreeBoard(num);
		String oriPass = bean.getPass();
	
		if (inPass.equals(oriPass)) {
			bMgr.deletefreeBoard(num);
			String url = "freeList.jsp?nowPage=" + nowPage;
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
		<form name="delFrm" method="post" action="freeDelete.jsp">
			<table class="deleteTable">
				<tr>
					<td><input type="password" name="pass" size="17"
						maxlength="15"></td>
				</tr>

				<tr>
					<td><span></span></td>
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