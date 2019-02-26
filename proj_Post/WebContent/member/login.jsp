<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
<style type="text/css">
.fc {
text-align: center;
background: #f8f9fa;
}
</style>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../css/memberStyle.css">
</head>
<body>
	<div id="wrap">
		<div class="container-fluid">
		
		<%
			if (bean != null) {
			String id = bean.getId();
			if (id != null) {
				response.sendRedirect("../index.jsp");
			}

			} else {
		%>
		
		<div class="row">
			<div class="col">
			<header>
			<div style="text-align:left;">
			<a id="left" style="color: black; font-weight: 100; font-size: 1.1em;"href="../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">로그인</h1>
			</header>
			</div>
		</div>
		
		<div class="row">
		<div class="col">
		<div id="main" style="text-align:left;">
		<div class="table-responsive">
		<form name="loginFrm" id="loginFrm">
			<table class="table">
			
				<tr>
					<td class="fc" style="width:30%;">아이디</td>
					<td><input type="text" name="id" maxlength="15" size="20"></td>
					<td rowspan="2" style="background-color: #f8f9fa; width: 40%; vertical-align: middle;">
					<input class="btn btn-light btn-block btn-lg" type="button" value="로그인" onclick="loginCheck()"></td>
				</tr>
				<tr>
					<td class="fc" style="width:30%;">비밀번호</td>
					<td><input type="password" name="pass" maxlength="20"
						size="20"></td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: center;">
					<br>
					<div class="btn-group" role="group" aria-label="Basic example">
					<input class="btn btn-light" type="button" value="회원가입" onclick="location.href='member.jsp'">
					<input class="btn btn-light" type="button" value="관리자 로그인" onclick="location.href='../admin/adminLogin.jsp'">
					</div>
					</td>
				</tr>
			</table>
					<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>" >
		</form>
		<%
			}
		%>
	</div>
	</div>
	</div>
	</div>
</div>
</div>
<script src="../js/script.js"></script>
</body>
</html>