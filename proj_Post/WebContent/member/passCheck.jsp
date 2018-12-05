<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>

<link rel="stylesheet" href="../css/myPageStyle.css">
</head>
<body>
	<div id="wrap">
	
		<header class="top">
			<a href="../main/main.jsp" title="로고"><img id="headerLogo" src="images/headerLogo.gif" alt="로고"></a><br>
			<br>
			<h2>
				<b>마이페이지</b>
			</h2>
		</header>
		
		<div id="main">
		<div id="passCheckMain">
		<h3>비밀번호를 입력해주세요</h3>
		<form name="passFrm" method="post" action="updateMember.jsp">
			<input type="password" name="pass"> <br><br>
			<input
				type="button" onclick="passCheck()" value="확인">
		</form>
		</div>
		</div>
		<div id="aside">
			<table>
				<tr class="selected">
					<td>
					<a href="../member/passCheck.jsp" title="회원정보수정">
					회원정보수정</a></td>
				</tr>
				<tr>
					<td>
					<a href="../memberPage/accessPage.jsp" title="로그인기록확인">
					로그인기록확인</a></td>
				</tr>
				<tr>
					<td>
					<a href="#" title="장바구니">
					장바구니</a></td>
				</tr>
				<tr>
					<td>
					<a href="#" title="구매내역">
					구매내역</a></td>
				</tr>
			</table>
		</div>

		<footer>
		&copy; 2018, 쇼핑몰이름
		<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>

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