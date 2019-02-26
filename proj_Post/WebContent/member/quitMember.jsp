<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/myPageStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">

</head>
<body>
	<div id="wrap">
		<div class="container-fluid">
		
		<div class="row">
		<div class="col">
		<header>
			<div style="text-align:left;">
			<a id="left" style="color: black; font-weight: 100; font-size: 1.1em;" href="../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">MyPage</h1>
			</header>
		</div>
		</div>
		
		<div class="row">
		<div class="col"> 	
		<div id="main">
		<div id="quitMemberMain">
		<h4>회원 탈퇴</h4>
		<br>
		<p>정말로 탈퇴하시겠습니까?</p>
		<form name="quitFrm" method="post" action="quitProc.jsp">
			
			<div class="input-group mb-3 input-group-sm" style="width: 65%;">
			 <div class="input-group-prepend">
    		<span class="input-group-text" id="">비밀번호 입력</span>
  			</div>
			<input class="form-control" type="password" name="pass">
			<div class="input-group-append">
			<input class="btn btn-secondary btn-sm" type="button" name="quitBtn" value="확인"
				onclick="passCheck()">
			</div>
			</div>
		</form>
		</div>
		</div>
		
		<div id="aside">
				<div class="table-responsive">
				<table class="table table-borderless">
				<tr id="selected">
					<td>
					<a href="passCheck.jsp" title="회원정보수정">
					회원정보수정</a></td>
				</tr>
				<tr>
					<td>
					<a href="../memberPage/accessPage.jsp" title="로그인기록확인">
					로그인기록확인</a></td>
				</tr>
				<tr>
					<td>
					<a href="../memberPage/basketPage.jsp" title="장바구니">
					장바구니</a></td>
				</tr>
				<tr>
					<td>
					<a href="../memberPage/myPurchasePage.jsp" title="구매내역">
					구매내역</a></td>
				</tr>
			</table>
		</div>
		</div>

		<footer>
		&copy; 2018, 쇼핑몰이름
		<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
		</div>
		</div>
	</div>
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