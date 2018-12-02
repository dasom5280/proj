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
		<h3>회원 탈퇴</h3>
		<p>정말로 탈퇴하시겠습니까?</p>
		<form name="quitFrm" method="post" action="quitProc.jsp">
			비밀번호 입력&nbsp;&nbsp;<input type="password" name="pass"> <br>
			<br> <input type="button" name="quitBtn" value="확인"
				onclick="passCheck()">
		</form>
	</div>

	<script>
		function passCheck() {
			if (document.quitFrm.pass.value == "") {
				alert("비밀번호를 입력해주세요.");
				document.quitFrm.pass.focus();
				return;
			} else {
				document.quitFrm.submit();
			}
		}
	</script>
</body>
</html>