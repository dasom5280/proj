<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 request.setCharacterEncoding("utf-8");
 MemberBean aBean = (MemberBean) session.getAttribute("adminBean");
 
 if(aBean != null){
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>ADMIN</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<style type="text/css">
body {
color : #606060;
}

#wrap{
padding: 3%;
width: 60%;
margin: 0 auto;
}
a:visited {
color : black;
text-decoration: none;
}

a:hover {
color : silver;
}

a {
color : black;
text-decoration: none;
}
</style>

</head>

<body>
 <div id="wrap">
 
 <!-- header -->
  
  <header>
  <div align="right">
  <a href="adminLogout.jsp"> 로그아웃 </a>
  </div>
  
  <div align="center">
   <h1 id="title"><a href="adminMain.jsp"> 쇼핑몰이름 </a></h1>
  </div>
  </header>
	<br><br>
 
 <div id="main" align="">
  <h3 title="회원관리">회원관리</h3>
   <ul>
    <li><a href="ad_Member/member_infor.jsp" title="회원관리">회원관리</a></li>
   </ul>
   
   <h3 title="게시판관리">게시판관리</h3>
   <ul>
   	<li><a href="ad_Board/noticeList.jsp" title="공지게시판관리">공지게시판</a></li>
   	<li><a href="ad_Board/noticeFAQ.jsp" title="FAQ관리">FAQ</a></li>
   	<li ><a href="../board/freeBoard/freeList.jsp" title="자유게시판관리">자유게시판</a></li>
   	<li><a href="ad_Board/qnAlist.jsp" title="Q&A관리">Q&A</a></li>
   </ul>
   
   <h3 title="쇼핑몰관리">쇼핑몰관리</h3>
   <ul>
  
    <li><a href="ad_Product/productList.jsp" title="상품관리">상품관리</a></li>
   <li><a href="ad_Product/basketList.jsp" title="장바구니관리">장바구니관리</a></li>
    <li><a href="ad_Product/purchaseList.jsp" title="주문내역관리">주문내역관리</a></li>
    <li><a href="ad_Product/deliveryList.jsp" title="배송내역관리">배송내역관리</a></li>
   </ul>
   
   </div>
   <br><br>
  <footer style="text-align: center">
   &copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
  </footer>

</div>
<%
} else {
	// 주소 수정 필요
	response.sendRedirect("../index.jsp");
}
	%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="../../js/ad_member.js"></script>

</body>

</html>