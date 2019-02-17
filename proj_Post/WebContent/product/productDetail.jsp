<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page" />
<%
	request.setCharacterEncoding("utf-8");

	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
	String id = null;
	if (bean != null)
		id = bean.getId();

	int productNum = Integer.parseInt(request.getParameter("productNum"));
	ProductBean pbean = pMgr.getProduct(productNum);
	String proType = pbean.getProductType();
	String proName = pbean.getProductName();
	String price = pbean.getPrice();
	String filename = pbean.getFilename();
	int sale = pbean.getSale();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/mainStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">

</head>

<body>
	<div id="wrap">

		<header class="top">
			<img id="headerLogo" src="../images/headerLogo.png" alt="로고">
		</header>

		<nav>
			<ul>
				<li <%if (proType.equals("outer")) {%> id="selected" <%}%>><a
					href="productList.jsp?productType=outer" title="Outer">Outer</a></li>
				<li <%if (proType.equals("top")) {%> id="selected" <%}%>><a
					href="productList.jsp?productType=top" title="Top">Top</a></li>
				<li <%if (proType.equals("bottom")) {%> id="selected" <%}%>><a
					href="productList.jsp?productType=bottom" title="Bottom">Bottom</a></li>
				&nbsp;
				<li>||</li>&nbsp;
				<li><a href="../board/memberBoard/noticelist.jsp"
					title="Notice">Notice</a></li>
				<li><a href="../admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li><a href="../board/freeBoard/freeList.jsp" title="freeBoard">FreeBoard</a></li>
				<li><a href="../board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
				&nbsp;
				<li>||</li>&nbsp;
				<%
					if (id != null) {
				%>
				<li><a href="../member/passCheck.jsp" title="MyPage">ID : <%= id %></a></li>
				<li><a href="../memberPage/basketPage.jsp" title="MyCart">MyCart</a></li>
				<li><a href="../member/logout.jsp" title="">Logout</a></li>
				<%
					} else {
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
					<form name="proFrm" method="post">
						<table>

							<tr>
								<td colspan="2" rowspan="7"><img
									src="../admin/img_Product/<%=filename%>" alt="" width="300"
									height="400"></td>
								<td>상품이름</td>
								<td><%=proName%></td>
							</tr>
							<tr>
								<td>가격</td>
								<td>
									<!-- 세일 처리 세일이면 강조하는 것 추가해주기!! --> <%
 	if (sale == 1)
 		out.println("<span style='color:red;'>[sale]</span>");
 %>
									<%
										if (sale == 1) {
											int salePercent = pbean.getSalePercent();
											double saledprice = Double.parseDouble(price) * (1 - (double) salePercent / 100);
											price = Integer.toString((int) saledprice);

											out.println((int) saledprice);
										} else {
											out.println(price);
										}
									%>
								</td>
							</tr>

							<tr>
								<td>수량</td>
								<td><input id="spinner" type="text" name="quantity" min="1"
									max="20" value="1" size="3"></td>
							</tr>
							<tr>
								<td><input type="button" value="장바구니 담기"
									onclick="javascript:basketProc('<%=id%>')"></td>
								<td><input type="button" value="바로구매"
									onclick="javascript:purchaseProc('<%=id%>')"></td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
							<tr>
								<td><br></td>
							</tr>

							<tr>
								<td colspan="2"><%=pbean.getExplanation()%></td>
							</tr>


						</table>

						<input type="hidden" name="id" value="<%=id%>"> <input
							type="hidden" name="productName" value="<%=proName%>"> <input
							type="hidden" name="productNum" value="<%=productNum%>">
						<input type="hidden" name="productType" value="<%=proType%>">
						<input type="hidden" name="price" value="<%=price%>">


					</form>
				</div>
			</div>
		</div>

		<footer>
			&copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
	</div>

	<script>
		$(function() {

			$('#spinner').spinner({
				max : 30,
				min : 1,
				step : 1
			});
		});

		function basketProc(id) {

			if (id == "null") {
				logchk = confirm("로그인이 필요합니다.\n확인을 누르시면 로그인 페이지로 이동됩니다.");
				if (logchk) {
					location.href = "../member/login.jsp";
				}
			} else {

				if (document.proFrm.quantity.value == "") {
					alert("수량을 입력해주세요");
					document.proFrm.quantity.focus();
				}
				document.proFrm.action = "basketProc.jsp";
				document.proFrm.submit();
			}
		}
		function purchaseProc(id) {
			if (id == "null") {
				logchk = confirm("로그인이 필요합니다.\n확인을 누르시면 로그인 페이지로 이동됩니다.");
				if (logchk) {
					location.href = "../member/login.jsp";
				}
			} else {

				if (document.proFrm.quantity.value == "") {
					alert("수량을 입력해주세요");
					document.proFrm.quantity.focus();
				}

				document.proFrm.action = "purchasePage.jsp";
				document.proFrm.submit();
			}
		}
	</script>
</body>
</html>