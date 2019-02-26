<%@page import="pack_Bean.MemberBean"%>
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
		<form name="regFrm" method="post" action="updateMemberProc.jsp">
			<div class="table-responsive">
			<h4>회원 정보</h4>
			<table class="table table-borderless">
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
		<td><input type="text" name="birthday" size="15" value="<%= birthday%>"></td>
		</tr>
		
		<tr>
		<td>Email</td>
		<td><input type="text" name="email" size="40" value="<%= email %>"></td>
		</tr>
		
		<tr>
		<td>우편번호</td>
		<td>
		<div class="input-group input-group-sm mb-3">
		<input type="text" name="zipcode" size="15" value="<%=zipcode %>" readonly="readonly">
		<div class="input-group-append">
		<input  class="btn btn-secondary"  type="button" value="우편번호찾기" onclick="zipCheck()">
		</div>
		</div>
		</td>
		</tr>
		
		<tr>
		<td>주소</td>
		<td><input type="text" name="address" size="40" value ="<%=address %>" readonly="readonly"></td>
		</tr>
		
		<tr>
		<td>전화번호</td>
		<td><input type="text" name="phone1" size="5" maxlength="3" value="<%= phone1 %>">
		&nbsp;-&nbsp;&nbsp;<input type="text" name="phone2" size="5" maxlength="4" value="<%=phone2%>">
		&nbsp;-&nbsp;&nbsp;<input type="text" name="phone3" size="5" maxlength="4" value="<%=phone3 %>"></td>
		</tr>
		<tr>
		<td colspan="3" style="text-align: right;">
		<input class="btn btn-secondary" type="reset" value="다시쓰기">
		<input  class="btn btn-secondary" type="button" value="정보수정" onclick="inputCheck()">
		</td>
		</tr>
		<tr>
		<td colspan="3" style="text-align: right;"> 
		<input class="btn btn-secondary" type="button" value="회원탈퇴" onclick="location.href='quitMember.jsp'"></td>
		</tr>
		</table>
		</div>
		</form>
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
		} else if (frm.pass.value != ""&&frm.repass.value == "") {
			alert("비밀번호를 확인해주세요");
			frm.repass.focus();
		} else if (frm.pass.value != frm.repass.value) {
				alert("비밀번호가 일치하지 않습니다");
				frm.repass.value = "";
				frm.pass.focus();
		}else if (frm.name.value == "") {
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
			frm.action = "passCheck.jsp";
			frm.submit();
			alert("정보수정이 완료되었습니다.");
		}
	}
	</script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>	
	<script type="text/javascript">
	function zipCheck(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	        	 var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	           			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.regFrm.address.value = extraAddr;
	                
	                } else {
	                    document.regFrm.address.value = '';
	                } 

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.regFrm.zipcode.value = data.zonecode;
	                document.regFrm.address.value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	            }
	    }).open();
	}
	</script>
</body>
</html>