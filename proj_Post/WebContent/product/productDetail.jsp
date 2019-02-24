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
<title>SHOPNAME</title>
<style type="text/css">
.detail {
text-align: left;
}

table {
margin: 0 auto;
}

td {
color: #606060;
font-size: 1.2em;
font-weight: 140;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="../css/mainStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">

</head>

<body>
	<div id="wrap">

		<div class="container-fluid">
		<div class="row">
			<div class="col" style="text-align: center;">
			<header>
			<h1 onclick="javascript:location.href='../index.jsp'">SHOP NAME</h1>
			</header>
			</div>
		</div>

		<nav>
				<ul class="nav nav-pills nav-fill flex-column flex-sm-row">
				<li class="nav-item"<%if(proType.equals("outer")) {%> id="selected" <%} %>><a class="nav-link" href="productList.jsp?productType=outer" title="Outer">OUTER</a></li>
				<li class="nav-item"<%if(proType.equals("top")) {%> id="selected" <%} %>><a class="nav-link" href="productList.jsp?productType=top" title="Top">TOP</a></li>
				<li class="nav-item"<%if(proType.equals("bottom")) {%> id="selected" <%} %>><a class="nav-link" href="productList.jsp?productType=bottom" title="Bottom">BOTTOM</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/memberBoard/noticelist.jsp" title="Notice">NOTICE</a></li>
				<li class="nav-item"><a class="nav-link" href="../admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/freeBoard/freeList.jsp" title="freeBoard">FREEBOARD</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
			<%
					if (id != null) {
				%>
				<li class="nav-item"><a class="nav-link" href="../member/passCheck.jsp" title="MyPage">ID : <%= id %></a></li>
				<li class="nav-item"><a class="nav-link" href="../memberPage/basketPage.jsp" title="MyCart">MYCART</a></li>
				<li class="nav-item"><a class="nav-link" href="../member/logout.jsp" title="">LOGOUT</a></li>
			<% 
			} else {
			%>
			<li class="nav-item"><a class="nav-link" href="../member/login.jsp" title="Login">LOGIN</a></li>
			<%
				}
			%>			
			</ul>
		</nav>

			<div class="row">
				<div class="col">
				<div id="main">
					
					<div class="table-responsive">
						<form name="proFrm" method="post">
						<table class="table table-condensed table-borderless" >
						<tr>
						<td>
						<table>
							<tr>
								<td colspan="1" rowspan="5">
								<img
									src="../admin/img_Product/<%=filename%>" alt="" width="100%"
									height="100%"></td>
									<td colspan="1"></td>
							</tr>
							<tr>
								<td class="detail">상품이름</td>
								<td class="detail"><%=proName%></td>
								</tr>
							<tr>
								<td class="detail">가격</td>
								<td class="detail">
									<!-- 세일 처리 세일이면 강조하는 것 추가해주기!! --> <%
 	if (sale == 1)
 		out.println("<span class='badge badge-danger'>sale</span>&nbsp;");
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
								<td class="detail">수량</td>
								<td class="detail"><input id="spinner" type="text" name="quantity" min="1"
									max="20" value="1" size="3"></td>
							</tr>
							<tr>
								<td class="detail"><input class="btn btn-secondary btn-lg btn-block" type="button" value="장바구니 담기"
									onclick="javascript:basketProc('<%=id%>')"></td>
								<td class="detail"><input class="btn btn-secondary btn-lg btn-block" type="button" value="바로구매"
									onclick="javascript:purchaseProc('<%=id%>')"></td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
							<tr>
								<td colspan="3"><hr></td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
							<tr>
								<td colspan="3"><%=pbean.getExplanation()%></td>
							</tr>

						</table>
						</td>
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
	</div>


		<div class="row">
		<div class="col">
		<footer>
			&copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
		</div>
		</div>
	</div>
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