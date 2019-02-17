<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="../css/myPageStyle.css">

<%
	request.setCharacterEncoding("UTF-8");

	String insPass = request.getParameter("pass");

	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
	if(bean != null){
		
	String oriPass = bean.getPass();
	
	if(insPass.trim().equals(oriPass.trim())){
		
		String id = bean.getId();
		String name = bean.getName();
		String gender = bean.getGender();
		String email = bean.getEmail();
		String birthday = bean.getBirthday();
		String zipcode = bean.getZipcode();
		String address = bean.getAddress();
		String phone1 = bean.getPhone1();
		String phone2 = bean.getPhone2();
		String phone3 = bean.getPhone3();
%>


</head>
<body>

	<div id="wrap">
	
		<header class="top">
			<a href="../index.jsp" title="로고"><img id="headerLogo" src="images/headerLogo.gif" alt="로고"></a><br>
			<br>
			<h2>
				<b>마이페이지</b>
			</h2>
		</header>
		
		<div id="main">
		
		<form name="regFrm" method="post" action="updateMemberProc.jsp">
		<table>
		
		<tr>
		<td colspan="3"><b>회원 정보</b></td>
		</tr>
		
		<tr>
		<td>아이디</td>
		<td><input type="text" name="id" size="15" readonly="readonly" value="<%=id%>">
		</td>
		
		<tr>
		<td>패스워드</td>
		<td><input type="password" name="pass" size="15" value=""></td>
		</tr>
		
		<tr>
		<td>패스워드 확인</td>
		<td><input type="password" name="repass" size="15" value=""></td>
		</tr>
		
		<tr>
		<td>이름</td>
		<td><input type="text" name="name" size ="15" value="<%=name%>"></td>
		</tr>
		
		<tr>
		<td>성별</td>
		<td>남<input type="radio" name="gender" value="1" <% if(gender.equals("1")){ %> checked="checked" <% } %>> 
		 여<input type="radio" name="gender" value="2" <% if(gender.equals("2")){ %> checked="checked"<% } %> >
		</td>
		</tr>
		
		<tr>
		<td>생년월일</td>
		<td><input type="text" name="birthday" size="6" value="<%= birthday%>"></td>
		</tr>
		
		<tr>
		<td>Email</td>
		<td><input type="text" name="email" size="30" value="<%= email %>"></td>
		</tr>
		
		<tr>
		<td>우편번호</td>
		<td><input type="text" name="zipcode" size="7" value="<%=zipcode %>" readonly>
		<input type="button" value="우편번호찾기" onclick="zipCheck()"></td>
		</tr>
		
		<tr>
		<td>주소</td>
		<td><input type="text" name="address" size="45" value ="<%=address %>"></td>
		</tr>
		
		<tr>
		<td>전화번호</td>
		<td><input type="text" name="phone1" size="4" maxlength="3" value="<%= phone1 %>">
		&nbsp;-&nbsp;<input type="text" name="phone2" size="5" maxlength="4" value="<%=phone2%>">
		&nbsp;-&nbsp;<input type="text" name="phone3" size="5" maxlength="4" value="<%=phone3 %>"></td>
		</tr>
		<tr>
		<td colspan="3">
		<input type="button" value="정보수정" onclick="inputCheck()">
		&nbsp;&nbsp;
		<input type="reset" value="다시쓰기"></td>
		</tr>
		<tr>
		<td>
		<input type="button" value="회원탈퇴" onclick="location.href='quitMember.jsp'"></td>
		</tr>
		</table>
		</form>

		</div>

		<div id="aside">
			<table>
				<tr id="selected">
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

		<footer>
		&copy; 2018, 쇼핑몰이름
		<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
		
	</div>
		<% 
		} else {
		%>
		<script>
		alert("비밀번호가 일치하지 않습니다");
		location.href = "passCheck.jsp";
		</script>
		<% }
		} else {
			response.sendRedirect("../index.jsp");
		}
		%>
	<script>
	function inputCheck() {
		frm = document.regFrm;
		if (frm.id.value == "") {
			alert("아이디를 입력해주세요");
			frm.id.focus();
		} else if (frm.pass.value == "") {
			alert("비밀번호를 입력해주세요");
			frm.pass.focus();
		} else if (frm.repass.value == "") {
			alert("비밀번호를 확인해주세요");
			frm.pass.focus();
		}else if (frm.pass.value != frm.repass.value) {
			alert("비밀번호가 일치하지 않습니다");
			frm.repass.value = "";
			frm.pass.focus();
		} else if (frm.name.value == "") {
			alert("이름을 입력해주세요");
			frm.name.focus();
		} else if (frm.birthday.value == "") {
			alert("생년월일을 입력해주세요");
			frm.birthday.focus();
		} else if (frm.email.value == "") {
			alert("이메일을 입력해주세요");
			frm.email.focus();
		} else if (frm.zipcode.value == "") {
			alert("우편번호를 입력해주세요");
			frm.zipcode.focus();
		} else if (frm.address.value == "") {
			alert("주소를 입력해주세요");
			frm.address.focus();
		} else {
			frm.method = "post";
			frm.action = "updateMemberProc.jsp";
			frm.submit();
		}
	}
		function zipCheck() {
			url = "zipCheck.jsp?check=y";
			window.open(url, "ZipCodeSearch",
					"width=500, height=300, scrollbars=yes top=200 left=600");
		}
	</script>
</body>
</html>