<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<link rel="stylesheet" href="../css/style.css">
<script src="../js/script.js"></script>
</head>
<body onload="regFrm.id.focus()" id="member">
	<div id="wrap">
	<form name="regFrm" method="post"
	action="memberProc.jsp">
	
	<table>
	
	<tr>
	<td colspan="3"><b>회원가입</b></td>
	</tr>
	
	<tr>
	<td>아이디</td>
	<td><input type="text" name="id" size="15" value="">
	<input type="button" name="idChkBtn" value="ID 중복확인" onclick="idCheck(this.form.id.value)">
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
	<td><input type="text" name="birthday" size="6" value=""> ex)830815</td>
	<td>생년월일을 적어주세요.</td>
	</tr>
	
	<tr>
	<td>Email</td>
	<td><input type="text" name="email" size="30" value=""></td>
	<td>이메일을 적어주세요.</td>
	</tr>
	
	<tr>
	<td>우편번호</td>
	<td><input type="text" name="zipcode" size="7" readonly>
	<input type="button" value="우편번호찾기" onclick="zipCheck()"></td>
	<td>우편번호를 검색하세요.</td>
	</tr>
	
	<tr>
	<td>주소</td>
	<td><input type="text" name="address" size="45"></td>
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
	<td colspan="3">
	<input type="button" value="회원가입" onclick="inputCheck()">
	&nbsp;&nbsp;
	<input type="reset" value="다시쓰기">
	&nbsp;&nbsp;
	<input type="button" value="로그인" onclick="javascript:location.href='login.jsp'"></td>
	</tr>
	</table>
	<input type="hidden" name="idChkValue" value="0">
	</form>
	</div>

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

		function zipCheck() {
			url = "zipCheck.jsp?check=y";
			window.open(url, "ZipCodeSearch",
					"width=500, height=300, scrollbars=yes top=200 left=600");
		}
	</script>
</body>
</html>