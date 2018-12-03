<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />

<%
	request.setCharacterEncoding("utf-8");

	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
	

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인 기록 정보</title>

<link rel="stylesheet" href="../css/myPageStyle.css">

</head>
<body>
	<div id="wrap">
		<header class="top">
			<a href="../main.jsp" title="로고"><img id="headerLogo"
				src="images/headerLogo.gif" alt="로고"></a><br> <br>
			<h2>
				<b>마이페이지</b>
			</h2>
		</header>

		<div id="main">
			<div id="passCheckMain"></div>
		</div>
		<div id="aside">
			<table>
				<tr>
					<td><a href="../member/passCheck.jsp" title="회원정보수정">
							회원정보수정</a></td>
				</tr>
				<tr class="selected">
					<td><a href="#" title="로그인기록확인"> 로그인기록확인</a></td>
				</tr>
				<tr>
					<td><a href="#" title="장바구니"> 장바구니</a></td>
				</tr>
				<tr>
					<td><a href="#" title="구매내역"> 구매내역</a></td>
				</tr>
			</table>
		</div>

		<footer>
			&copy; 2018, 쇼핑몰이름 <br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>

	</div>
</body>
</html>