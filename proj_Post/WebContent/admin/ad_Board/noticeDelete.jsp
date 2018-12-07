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
int number;
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	if (request.getParameter("pass") != null) {
		//비번을 입력을 해서 세션에 있는 pass 비교요청
		String inPass = request.getParameter("pass");
		BoardBean bean = (BoardBean) session.getAttribute("bean");
		String dbPass = bean.getPass();
		
		if (inPass.equals(dbPass)) {
			bMgr.deleteBoard(num);
			String url = "noticeList.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
		} else {
%>
	<script>
		alert("입력하신 비밀번호가 아닙니다.");
		history.back();
	</script>
<% 	}

	} else { %>
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


<% } %>

</head>
<body>
	<div id="wrap" style="width:300px; border: 1px solid black; margin : 0 auto;">
		
		<h1>비밀번호확인</h1>
		<form name="delFrm" method="post">
			<table>
				<tr>
					<td>
						<table>
							<tr>
								<td style="text-align : center;">
									<input type="password" name="pass" size="17" maxlength="15">
								</td>
							</tr>
							<tr>
								<td><hr></td>
							</tr>
							<tr>
								<td>
									<input type="button" value="삭제완료" onclick="check()"> 
									<input type="reset" value="다시쓰기">
									<input type="button" value="뒤로" onclick="history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="num" value="<%=num%>">
		</form>
		
		

	</div>
</body>
</html>