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
<link rel="stylesheet" type="text/css" href="css/mainStyle.css">

</head>
<body>
	<div id="wrap">


		<header class="top">
			<img id="headerLogo" src="images/headerLogo.png" alt="로고">
		</header>

		<nav>
			<ul>
				<li><a href="product/productList.jsp?productType=outer" title="Outer">Outer</a></li>
				<li><a href="product/productList.jsp?productType=top" title="Top">Top</a></li>
				<li><a href="product/productList.jsp?productType=bottom" title="Bottom">Bottom</a></li>
				&nbsp;<li>||</li>&nbsp;
				<li><a href="board/memberBoard/noticelist.jsp" title="Notice">Notice</a></li>
				<li><a href="admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li><a href="board/freeBoard/freeList.jsp" title="freeBoard">FreeBoard</a></li>
				<li><a href="board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
				&nbsp;<li>||</li>&nbsp;
			<%
				if (bean != null) {
					String id = bean.getId();
						if (id != null) {
			%>
				<li><a href="member/passCheck.jsp" title="MyPage">ID : <%= id %></a></li>
				<li><a href="memberPage/basketPage.jsp" title="MyCart">MyCart</a></li>
				<li><a href="member/logout.jsp" title="">Logout</a></li>
			<% 
				} 
			}else {
			%>
			<li><a href="member/login.jsp" title="Login">Login</a></li>
			<%
				}
			%>			
			</ul>
		</nav>

		<div id="tablecontainer">
			<div class="tablerow">

				<div id="adv">
					<p>광고이미지 출력</p>
				</div>
			</div>

			<div class="tablerow">
				<div id="main">
					<table>
						<tr>
							<td colspan="5"><b>New Arrival</b></td>
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
						<table class="galleryImg1">
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
											if (sale==1) out.println("<span style='color: red; font-size: small;'>sale!&nbsp;</span>"); 
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
																out.println("<span style='font-size: 0.5em;'><s>"+price + "</s>→</span>" + "<span style='color:red;'>"+ (int) saledprice + "</span>");
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
						
						<br>
						
						<table>
						<tr>
							<td colspan="5"><b>Sale</b></td>
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
						<table class="galleryImg1">
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
											if (sale==1) out.println("<span style='color: red; font-size: small;'>sale!&nbsp;</span>"); 
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
																out.println("<span style='font-size: 0.5em;'><s>"+price + "</s>→</span>" + "<span style='color:red;'>"+ (int) saledprice + "</span>");
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

		<footer>
			&copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
	</div>
</body>
</html>