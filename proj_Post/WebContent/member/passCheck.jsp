<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div id="wrap">
		<h2>마이페이지</h2>
		<h3>회원 정보 수정</h3>

		<form name="passFrm" method="post" action="updateMember.jsp">
			<p>비밀번호를 입력해주세요</p>
			<input type="password" name="pass"> <br><br>
			<input
				type="button" onclick="passCheck()" value="확인">
		</form>
	</div>

	<script>
		function passCheck() {
			if (document.passFrm.pass.value == "") {
				alert("비밀번호를 입력해주세요");
				document.passFrm.pass.focus();
				return;
			} else {

				document.passFrm.submit();
			}

		}
	</script>
</body>
</html>