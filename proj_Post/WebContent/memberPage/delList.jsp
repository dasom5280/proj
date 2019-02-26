<%@page import="pack_Bean.BasketBean"%>
<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
	String id = null;
	Vector<BasketBean> vlist = null;
	BasketMgr basMgr = null;
	int totalRecord = 0;
	int start = 0;
	
	if(bean!=null){
		id = bean.getId();
		basMgr = new BasketMgr();
		totalRecord = basMgr.getTotalDelivery(id);
			
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<style type="text/css">
body {
	background-color: #f7f7f7; 	
}
table {
	font-size : 0.8em;
	text-align: center;
	font-size: 0.8em;
}
a {
color: black;
}
a:hover {
	text-decoration: none;
	color: #ff919e;
}
</style>
</head>
<body>
	<div id="wrap">
	<div id="purchaseList">
	<div class="table-responsive">
			<table class="table table-condensed">	
				<tr>
					
						<%
				  vlist = basMgr.getDeliverytList(id, start, totalRecord);
					
				  int listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("<td colspan='5'>배송 중인 상품이 없습니다.");
				  } else {
			%>
									<td>종류</td>
									<td>이름</td>
									<td>수량</td>
									<td>날짜</td>
									<td>상태</td>
								</tr>
								<%
							 for (int i = 0;i<listSize; i++) {
									if (i == listSize) break;
									BasketBean basbean = vlist.get(i);
									String proType = basbean.getProductType();
									String proName = basbean.getProductName();
									int proNum = basbean.getProductNum();
									String price = basbean.getPrice();
									int quantity = basbean.getQuantity();
									String buyDate = basbean.getBuydate();
						%>
								<tr>
									<td><%= proType %></td>
									<td><a
										href="../product/productDetail.jsp?productNum=<%=proNum%>"><%=proName%></a>
									</td>
									<td><%=quantity%></td>
									<td><%=buyDate%></td>
									<td>배송중</td>
								</tr>
								<%
									} // for
 							} // if
							 %>
					</td>
					</tr>
			</table>
			<%
				} else {
				out.println("<p>페이지를 표시할 수 없습니다.</p>"); 
				}%>
		</div>
	</div>
	</div>
</body>
</html>