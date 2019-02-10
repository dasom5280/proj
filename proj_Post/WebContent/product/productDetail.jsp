<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page"/>
<% 
request.setCharacterEncoding("utf-8");
int productNum = Integer.parseInt(request.getParameter("productNum")); 
ProductBean pbean = pMgr.getProduct(productNum);
MemberBean bean = (MemberBean) session.getAttribute("loginBean");
String proType = pbean.getProductType();
String proName = pbean.getProductName();
int proNum = pbean.getProductNum();
String price = pbean.getPrice();
String filename = pbean.getFilename();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="../css/mainStyle.css">
</head>

<body>
	<div id="wrap">

		<header class="top">
			<img id="headerLogo" src="../images/headerLogo.png" alt="로고">
		</header>

		<nav>
			<ul>
				<li <%if(proType.equals("outer")) {%> id="selected" <%} %>><a href="productList.jsp?productType=outer" title="Outer">Outer</a></li>
				<li <%if(proType.equals("top")) {%> id="selected" <%} %>><a href="productList.jsp?productType=top" title="Top">Top</a></li>
				<li <%if(proType.equals("bottom")) {%> id="selected" <%} %>><a href="productList.jsp?productType=bottom" title="Bottom">Bottom</a></li>
				&nbsp;<li>||</li>&nbsp;
				<li><a href="../board/memberBoard/noticelist.jsp" title="Notice">Notice</a></li>
				<li><a href="../admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li><a href="../board/freeBoard/freeList.jsp" title="freeBoard">FreeBoard</a></li>
				<li><a href="../board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
				&nbsp;<li>||</li>&nbsp;
			<%
				if (bean != null) {
					String id = bean.getId();
						if (id != null) {
			%>
				<li><a href="#" title="Id">ID : <%= id %></a></li>
				<li><a href="../memberPage/myPage.jsp" title="Mypage">Mypage</a></li>
				<li><a href="../member/logout.jsp" title="">Logout</a></li>
			<% 
				} 
			}else {
			%>
			<li><a href="../member/login.jsp" title="Login">Login</a></li>
			<%
				}
			%>			
			</ul>
		</nav>
		
		<div id="tablecontainer">

			<div class="tablerow">
				<div id="main">
					<form name="proFrm" method="post" action="">
						<table>

							<tr>
							<td colspan="2" rowspan="4"><img src="../admin/img_Product/<%=filename%>.jpg"></td>
							<td>상품이름</td>
							<td><%=proName %></td>
							</tr>
							<tr>
							<td>가격</td>
							<td>
							<!-- 세일 처리 세일이면 강조하는 것 추가해주기!! -->
							<%=price %>
							</td>
							</tr>
							
							<tr>
							<td>수량</td>
							<td>
							<input type="text" value="" max="10" size="3"></td>
							</tr>
							<tr>
							<td>
							<input type="button" value="장바구니 담기">
							</td>
							<td>
							<input type="button" value="바로구매">
							</td>
							</tr>
							<tr>
							</tr>
							<tr>
							<td colspan="2">
							<%= pbean.getExplanation() %>
							</td>
							</tr>
							
							
	</table>
	</form>
	</div>
	</div>
	</div>
	
		<footer>
			&copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
	</div>
</body>
</html>