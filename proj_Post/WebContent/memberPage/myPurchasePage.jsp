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
<title>SHOPNAME</title>

<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/myPageStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<style type="text/css">
iframe{
margin: 2%;
}
</style>
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
			<div id="purPageMain">
				<h4>구매 상품</h4>
				<br>
				<h5>배송 중인 상품</h5>
				<iframe src="delList.jsp" width="80%" height="15%"  
				frameborder="0" scrolling="yes">
				</iframe>
				<br><br>
				<h5>배송 대기 상품</h5>
				<iframe src="purList.jsp" width="80%" height="15%"  
				frameborder="0" scrolling="yes">
				</iframe>
			</div>
		</div>
	
		<div id="aside">
			<div class="table-responsive">
				<table class="table table-borderless">
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
		</div>
		
		<footer>
			&copy; 2018, 쇼핑몰이름 <br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
	</div>
	</div>
</div>
</div>
	
</body>
</html>