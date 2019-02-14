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
<title>Login</title>
<link rel="stylesheet" href="../css/style.css">

</head>
<body>
	<div id="wrap">

		<%
			if (bean != null) {
			String id = bean.getId();
			if (id != null) {
				response.sendRedirect("../index.jsp");
			}

			} else {
		%>
		<form name="loginFrm" id="loginFrm">
			<table>
				<tr>
					<td colspan="2" style="text-align: center; font-weight: bold;">로그인</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" maxlength="15" size="17"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass" maxlength="15"
						size="18"></td>
				</tr>
				<tr>
					<td colspan="2" id="tdRange">
					<input type="button" value="로그인" onclick="loginCheck()">&nbsp;&nbsp;&nbsp; 
					<input type="button" value="회원가입" onclick="location.href='member.jsp'">
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align : center; padding : 10px;">
					<input type="button" value="관리자 로그인" onclick="location.href='../admin/adminLogin.jsp'">
					</td>
				</tr>
			</table>
					<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>" >
		</form>
		<%
			}
		%>

	</div>
<script src="../js/script.js"></script>
</body>
</html>