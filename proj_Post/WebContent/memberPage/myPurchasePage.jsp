<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="pack_Bean.BasketBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
	String id = null;
	if(bean == null)
		response.sendRedirect("../index.jsp");
	else {
		id = bean.getId();
	}
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>My page</title>
<style type="text/css">
iframe {
border: 1px solid black;
margin: 10px;
}
</style>
<link rel="stylesheet" href="../css/myPageStyle.css">
</head>
<body>
	<div id="wrap">
		<header class="top">
			<a href="../index.jsp" title="로고"><img id="headerLogo"
				src="images/headerLogo.gif" alt="로고"></a><br> <br>
			<h2>
				<b>마이페이지</b>
			</h2>
		</header>

		<div id="main">
			<div id="myPageMain">
				<h3>구매 상품</h3>
				<h4>배송 중인 상품</h4>
				<iframe src="delList.jsp" width="80%" height="15%"  
				frameborder="0" scrolling="yes">
				</iframe>
				
				<h4>배송 대기 상품</h4>
				<iframe src="purList.jsp" width="80%" height="15%"  
				frameborder="0" scrolling="yes">
				</iframe>
			</div>
		</div>

		<div id="aside">
			<table>

				<tr>
					<td><a href="../member/passCheck.jsp" title="회원정보수정">
							회원정보수정</a></td>
				</tr>
				<tr>
					<td><a href="accessPage.jsp" title="로그인기록확인"> 로그인기록확인</a></td>
				</tr>
				<tr>
					<td><a href="basketPage.jsp" title="장바구니"> 장바구니</a></td>
				</tr>
				<tr id="selected">
					<td><a href="myPurchasePage.jsp" title="구매내역"> 구매내역</a></td>
				</tr>
			</table>
		</div>
		<footer>
			&copy; 2018, 쇼핑몰이름 <br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
	</div>
</body>
</html>