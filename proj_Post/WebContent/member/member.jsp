<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../css/memberStyle.css">
<style type="text/css">
#wrap{
width: 60%;
margin: 0 auto;
}
</style>
</head>
<body onload="regFrm.id.focus()" id="member">
	<div id="wrap">
	
	<form name="regFrm" method="post"
	action="memberProc.jsp">
	<div class="container-fluid">
	
		<div class="row">
			<div class="col">
			<header>
			<div style="text-align:left;">
			<a id="left" style="color: black; font-weight: 100; font-size: 1.1em;"href="../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">회원가입</h1>
			</header>
			</div>
		</div>
		
		<div class="row">
			<div class="col">
			<div id="main" style="text-align:left;">
			<div class="table-responsive">
			<table class="table">	
				<tr>
				<td>아이디</td>
				<td>
				<div class="input-group input-group-sm mb-3">
				<input type="text" name="id" size="15" value="">
				<div class="input-group-append">
				<input class="btn btn-secondary" type="button" name="idChkBtn" value="ID 중복확인" onclick="idCheck(this.form.id.value)">
				</div>
				</div>
				</td>
				<td>아이디를 적어주세요.</td>
							
				<tr>
				<td>패스워드</td>
				<td><input type="password" name="pass" size="15" value=""></td>
				<td>패스워드를 적어주세요.</td>
				</tr>
				
				<tr>
				<td>패스워드 확인</td>
				<td><input type="password" name="repass" size="15" value=""></td>
				<td>패스워드를 확인합니다.</td>
				</tr>
				
				<tr>
				<td>이름</td>
				<td><input type="text" name="name" size ="15" value=""></td>
				<td>이름을 적어주세요.</td>
				</tr>
				
				<tr>
				<td>성별</td>
				<td>남<input type="radio" name="gender" value="1"> 여<input type="radio" name="gender" value="2" checked="checked">
				</td>
				<td>성별을 선택하세요.</td>
				</tr>
				
				<tr>
				<td>생년월일</td>
				<td><input type="text" name="birthday" size="15" value=""> ex)830815</td>
				<td>생년월일을 적어주세요.</td>
				</tr>
				
				<tr>
				<td>Email</td>
				<td><input type="text" name="email" size="40" value=""></td>
				<td>이메일을 적어주세요.</td>
				</tr>
				
				<tr>
				<td>우편번호</td>
				<td>
				<div class="input-group input-group-sm mb-3">
				<input type="text" name="zipcode" size="15" readonly>
				<div class="input-group-append">
				<input class="btn btn-secondary" type="button" value="우편번호찾기" onclick="zipCheck()">
				</div>
				</div>
				</td>
				<td>우편번호를 검색하세요.</td>
				</tr>
				
				<tr>
				<td>주소</td>
				<td><input type="text" name="address" size="40"></td>
				<td>주소를 적어주세요.</td>
				</tr>
				
				<tr>
				<td>전화번호</td>
				<td><input type="text" name="phone1" size="4" maxlength="3">
				&nbsp;-&nbsp;<input type="text" name="phone2" size="5" maxlength="4">
				&nbsp;-&nbsp;<input type="text" name="phone3" size="5" maxlength="4"></td>
				<td>전화번호를 입력하세요.</td>
				</tr>
				<tr>
				<td colspan="3" style="text-align: center;">
				<div class="btn-group" role="group" aria-label="Basic example">	
				<input class="btn btn-light" type="button" value="회원가입" onclick="inputCheck()">
				<input class="btn btn-light" type="reset" value="다시쓰기">
				<input class="btn btn-light" type="button" value="로그인" onclick="javascript:location.href='login.jsp'">
				</div>
				</td>
				</tr>
				</table>
				<input type="hidden" name="idChkValue" value="0">
				</div>
				</div>
				</div>
				</div>
				</div>
				</form>
	</div>
	<script src="../js/script.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
		function idCheck(id) {
			frm = document.regFrm;
			if (id.trim() == "") {
				alert("아이디를 입력해주세요.");
				frm.id.focus();
				return;
			}
			url = "idCheck.jsp?id=" + id;
			window.open(url, "IDCheck", "width=300 height=150 top= 200 left=600");
		}
	</script>
</body>
</html>