<%@page import="pack_Bean.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page"/>
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="css/mainStyle.css">
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
			<h1>SHOP NAME</h1>
			</header>
			</div>
		</div>
		
		<nav>
			<ul class="nav nav-pills nav-fill flex-column flex-sm-row">
				<li class="nav-item"><a  class="nav-link" href="product/productList.jsp?productType=outer" title="Outer">OUTER</a></li>
				<li class="nav-item"><a class="nav-link" href="product/productList.jsp?productType=top" title="Top">TOP</a></li>
				<li class="nav-item"><a class="nav-link" href="product/productList.jsp?productType=bottom" title="Bottom">BOTTOM</a></li>
				<li class="nav-item"><a class="nav-link" href="board/memberBoard/noticelist.jsp" title="Notice">NOTICE</a></li>
				<li class="nav-item"><a class="nav-link" href="admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li class="nav-item"><a class="nav-link" href="board/freeBoard/freeList.jsp" title="freeBoard">FREEBOARD</a></li>
				<li class="nav-item"><a class="nav-link" href="board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
			<%
				if (bean != null) {
					String id = bean.getId();
						if (id != null) {
			%>
				<li class="nav-item"><a class="nav-link" href="member/passCheck.jsp" title="MyPage">ID : <%= id %></a></li>
				<li class="nav-item"><a class="nav-link" href="memberPage/basketPage.jsp" title="MyCart">MYCART</a></li>
				<li class="nav-item"><a class="nav-link" href="member/logout.jsp" title="">LOGOUT</a></li>
			<% 
				} 
			}else {
			%>
			<li class="nav-item"><a class="nav-link" href="member/login.jsp" title="Login">LOGIN</a></li>
			<%
				}
			%>			
			</ul>
		</nav>

			<div class="row">
				<div class="col">
				<div id="adv">
					<p>광고이미지 출력</p>
				</div>
				</div>
			</div>

			<div class="row">
				<div class="col">
				<div id="main">
					<div class="table-responsive">
					<h4>New Arrival</h4>
					<table class="table table-borderless">
						<tr>
							<td colspan="5" class="subtitle"><hr></td>
						</tr>
						<tr>
						<%
						Vector<ProductBean> vlist = pMgr.getNewList();
						int cnt = 0;
						for (int i = 0; i < vlist.size(); i++) {
							ProductBean pbean = vlist.get(i);
							int proNum = pbean.getProductNum();
							String proName = pbean.getProductName();
							String proType = pbean.getProductType();
							String price = pbean.getPrice();
							String filename = pbean.getFilename();
							int sale = pbean.getSale();
							cnt ++;
						%>
						<td>
						<table class="table">
										<tr>
											<td class="galleryImg2">
											<img src="admin/img_Product/<%=filename%>" width="120"
												height="150" alt="">
											</td>
										</tr>
										<tr>
											<td>
											<a href="javascript:location.href='product/productDetail.jsp?productNum=<%=proNum%>'">
											<% 
											if (sale==1) out.println("<span class='badge badge-danger'>sale</span>&nbsp;"); 
											%>
											<%=proName %></a>
											</td>
										</tr>
										<tr>
										<td>
												<%
													if (sale == 1) {
																int salePercent = pbean.getSalePercent();
																double saledprice = Double.parseDouble(price) * (1 - (double) salePercent / 100);
																out.println("<span style='font-size: 0.5em; color:#a8a8a8;'><s>"+price + "</s>→</span>" + "<span style='color:#606060;'>"+ (int) saledprice + "</span>");
															} else {
																out.println(price);
															}
												%>
										</td>
										</tr>
									</table>
								</td>
								
								<%
									if (cnt % 5 == 0) {
												out.print("</tr>");
											}
										
									}//for
								%>
						</tr>
						</table>
						</div>
						<br>
						<div class="table-responsive">
						<h4>Sale</h4>
						<table class="table table-borderless">
						<tr>
							<td colspan="5" class="subtitle"><hr></td>
						</tr>
						<tr>
						<%
						Vector<ProductBean> slist = pMgr.getSaleList();
						cnt = 0;
						for (int i = 0; i < slist.size(); i++) {
							ProductBean pbean = slist.get(i);
							int proNum = pbean.getProductNum();
							String proName = pbean.getProductName();
							String proType = pbean.getProductType();
							String price = pbean.getPrice();
							String filename = pbean.getFilename();
							int sale = pbean.getSale();
							cnt ++;
						%>
						<td>
						<table class="table">
										<tr>
											<td class="galleryImg2">
											<img src="admin/img_Product/<%=filename%>" width="120"
												height="150" alt="">
											</td>
										</tr>
										<tr>
											<td>
											<a href="javascript:location.href='product/productDetail.jsp?productNum=<%=proNum%>'">
											
											<%=proName %></a>
											</td>
										</tr>
										<tr>
										<td>
												<%
													if (sale == 1) {
																int salePercent = pbean.getSalePercent();
																double saledprice = Double.parseDouble(price) * (1 - (double) salePercent / 100);
																out.println("<span style='font-size: 0.5em; color:#a8a8a8;'><s>"+price + "</s>→</span>" + "<span style='color:#606060;'>"+ (int) saledprice + "</span>");
															} else {
																out.println(price);
															}
												%>
										</td>
										</tr>
									</table>
								</td>
								
								<%
									if (cnt % 5 == 0) {
												out.print("</tr>");
											}
										
									}//for
								%>
						</tr>
						</table>
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
</body>
</html>