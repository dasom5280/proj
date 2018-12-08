<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pack_Bean.*, java.util.*" %>    

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="pack_JDBC.BoardMgr" scope="page" />
<%
String nowPage = request.getParameter("nowPage");
int num = Integer.parseInt(request.getParameter("num"));
BoardBean bean = bMgr.getBoard(num);
String oriPass = bean.getPass();

%>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>비밀번호 입력</title>
<link rel="stylesheet" href="">
</head>
<body>
	<div id="wrapZip">
		
		<form name="passFrm">
			<input type="hidden" name="check" value="n">
			<table>
				<tr>
					<td>
					비밀번호 입력 
					<input type="hidden" name="num" value="<%=num %>">
					<input type="hidden" name="nowPage" value="<%=nowPage %>">
					<input type="text" name="inPass">
					&nbsp;
					<input type="button" value="완료" onclick="passCheck()">
					</td>
				</tr>
				<tr>
					<td><a href="#" onclick="javascript:self.close()">닫기</a></td>
				</tr>
		</table>	
		</form>

	</div>
<script type="text/javascript">
function passCheck() {
	frm = document.passFrm;
	if (frm.inPass.value == "") {
		alert("비밀번호를 입력하세요");
		frm.inPass.focus();
		return;
	} else {
		if(frm.inPass.value ==<%=oriPass%>){
	
		opener.location.href="noticeDelete.jsp";
		ofrm = opener.document.delFrm;
		ofrm.num.value=<%=num%>;
		ofrm.nowPage.value=<%=nowPage%>;
		ofrm.inPass.value= self.document.passFrm.inPass.value;
		ofrm.action="noticeDelete.jsp";
		ofrm.submit();
		self.close();
		}  else {
			alert("비밀번호가 일치하지 않습니다.");
			frm.inPass.focus();
			return;
		}
	}
	
}
</script>	
</body>
</html>