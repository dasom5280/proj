<%@page import="pack_Bean.BasketBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="pack_Bean.MemberBean"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	MemberBean mbean = (MemberBean) session.getAttribute("loginBean");
	String mid = null;
	int points = 0;
	int numSize = 0;
	String nums = null;
	String proNum = null;
	String proName = null;
	int price = 0;
	String proType =  null;
	int quantity = 0;
	
	int usedPoints = 0;
	String address = null;
	String zipcode = null;
	String payment = null;
	
	BasketMgr basMgr = new BasketMgr();
	Vector<BasketBean> basBeans = null;
	
	if (mbean == null)
		response.sendRedirect("../member/login.jsp");

	else {
		mid = mbean.getId();
		points = mbean.getPoints();
		usedPoints = Integer.parseInt(request.getParameter("usedPoints"));
		address = request.getParameter("address");
		zipcode = request.getParameter("zipcode");
		payment = request.getParameter("payment");
		price = Integer.parseInt(request.getParameter("price"));
		
		if(mid==null||!mid.equals(request.getParameter("id"))){
			response.sendRedirect("../member/logout.jsp");
		}
		
		if (request.getParameter("nums") != null && !request.getParameter("nums").equals("null")) {
			nums = request.getParameter("nums");
			StringTokenizer st = new StringTokenizer(nums, "/");
			basBeans = new Vector<>();
			while (st.hasMoreTokens()) {
				int basNum = Integer.parseInt(st.nextToken());
				BasketBean basBean = basMgr.getBasket(basNum);
				basBeans.add(basBean);
				numSize ++; //상품 종류를 세는 변수
			}
		} else {
			proNum = request.getParameter("productNum");
			proName = request.getParameter("productName");
			proType = request.getParameter("productType");
			if(request.getParameter("quantity")!=null){
			quantity = Integer.parseInt(request.getParameter("quantity"));
			}
		}
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/mainStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">

<style type="text/css">
table#innerTbl {
	width: 200%;
	text-align: center;
}
.fc {
	text-align: center;
}
</style>
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
				<li class="nav-item"><a  class="nav-link" href="productList.jsp?productType=outer" title="Outer">OUTER</a></li>
				<li class="nav-item"><a class="nav-link" href="productList.jsp?productType=top" title="Top">TOP</a></li>
				<li class="nav-item"><a class="nav-link" href="productList.jsp?productType=bottom" title="Bottom">BOTTOM</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/memberBoard/noticelist.jsp" title="Notice">NOTICE</a></li>
				<li class="nav-item"><a class="nav-link" href="../admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/freeBoard/freeList.jsp" title="freeBoard">FREEBOARD</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
			<%
						if (mid != null) {
			%>
				<li class="nav-item"><a class="nav-link" href="../member/passCheck.jsp" title="MyPage">ID : <%= mid %></a></li>
				<li class="nav-item"><a class="nav-link" href="memberPage/basketPage.jsp" title="MyCart">MYCART</a></li>
				<li class="nav-item"><a class="nav-link" href="member/logout.jsp" title="">LOGOUT</a></li>
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
			<div id="main" >
			
				<h4 style="text-align:center;"><%=mid %>님의 구매상품</h4>
				<form name="purFrm" method="post">
				<div class="table-responsive">
				<table class="table table-borderless table-condensed" style="text-align: left; width: 70%; margin: 0 auto;">
				<tr>
				<td colspan="4">
				<hr>
				<td>
				</tr>
				<tr>
				<td>
				<table id="innerTbl" class="table">
				
				<tr>
				<td>상품종류</td>
				<td>상품이름</td>
				<td>상품가격</td>
				<td>수량</td>
				</tr>
				
				<% if (basBeans!=null) {
				for(int i= 0; i<basBeans.size(); i++){
					BasketBean basbean = basBeans.get(i);
					int basnum = basbean.getBasketNum();
					String basproname = basbean.getProductName();
					String basprotype = basbean.getProductType();
					int baspronum = basbean.getProductNum();
					String basprice = basbean.getPrice();
					int basquantity = basbean.getQuantity();
					quantity +=basquantity;
				%>
				<tr>
				<td><%=basprotype %></td>
				<td><%=basproname %></td>
				<td><%=basprice %></td>
				<td><%=basquantity %></td>
				</tr>
				<% }//for
				} else {%>
				<tr>
				<td><%=proType %></td>
				<td><%=proName %></td>
				<td><% if(request.getParameter("oriprice")!=null)out.println(request.getParameter("oriprice")); 
				else out.println("0");
				%></td>
				<td>
				<%=quantity%>
				<input type="hidden" name="productNum" value="<%=proNum%>">
				<input type="hidden" name="productType" value="<%=proType %>">
				<input type="hidden" name="productName" value="<%=proName%>">
				<input type="hidden" name="quantity" value="<%=quantity %>">
				</td>
				</tr>
				<% }//if %>
				
				</table>
				</td>
				</tr>
				<tr>
				<td colspan="4">
				<hr>
				<td>
				</tr>
				
				<tr>
				<td class="fc">총 가격</td>
				<td><%=price %></td>
				</tr>
				<tr>
				<td class="fc">지불가격</td>
				<% 
				points -= usedPoints;
				price -= usedPoints; %>
				<td><%= price %>
				&nbsp;&nbsp;<span style="font-size: small;">사용 적립금 : <%=usedPoints %>&nbsp;&nbsp;추가 적립금 : <%=(int) (price * 0.01)%></span>
				<% points = (int) (points + (price * 0.01)); // 지불 가격의 1프로를 적립금으로 전환%>
				</td>
				</tr>

				<tr>
				<td colspan="4">
				<hr>
				</td>
				</tr>
				<tr>
					<td class="fc">우편번호</td>
					<td><input type="text" name="zipcode" size="10" readonly="readonly" value="<%=zipcode%>"></td>
				</tr>

				<tr>
					<td class="fc">주소</td>
					<td><input type="text" name="address" size="40" readonly="readonly" value="<%=address %>"></td>
				</tr>
				<tr>
					<td class="fc">지불 수단</td>
					<td>
					<% if(payment.equals("1")) out.println("신용카드"); 
					else if(payment.equals("2")) out.println("계좌이체");
					else if(payment.equals("3")) out.println("휴대폰결제");
					else response.sendRedirect("../index.jsp");
					%>
					</td>
				</tr>
				<tr>
				<td colspan="4" style="text-align: center;">
				<input class="btn btn-secondary" type="button" value="구매" onclick="javascript:purProc()">
				</td>
				</tr>
				
			</table>
			<input type="hidden" name="id" value="<%=mid %>">
			<input type="hidden" name="nums" value="<%=nums %>">
			<input type="hidden" name="quantity" value="<%=quantity %>">
			<input type="hidden" name="price" value="<%= (int) (price / (double) quantity)%>">
			<input type="hidden" name="points" value="<%=points %>">
			<input type="hidden" name="usedPoints" value="<%=usedPoints %>">
			<input type="hidden" name="payment" value="<%=payment %>">
			</div>
		</form>
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
	function purProc(){
		document.purFrm.method="get";
		document.purFrm.action="purchaseProc.jsp";
		document.purFrm.submit();
	}
	</script>
</body>
</html>