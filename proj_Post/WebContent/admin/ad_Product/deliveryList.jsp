<%@page import="pack_Bean.ProductBean"%>
<%@page import="pack_JDBC.ProductMgr"%>
<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="pack_Bean.BasketBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	MemberBean abean = (MemberBean) session.getAttribute("adminBean");
	
	if(abean == null){
		response.sendRedirect("../../index.jsp");
	}  else {
		String aid = abean.getId();
		BasketMgr basMgr = new BasketMgr();
		int totalRecord = 0; //전체레코드수
		int numPerPage = 10; // 페이지당 레코드 수 
		int pagePerBlock = 10; //블럭당 페이지수 

		int totalPage = 0; //전체 페이지 수
		int totalBlock = 0; //전체 블럭수 

		int nowPage = 1; // 현재페이지
		int nowBlock = 1; //현재블럭

		int start = 0; //디비의 select 시작번호
		int end = 10; //시작번호로 부터 가져올 select 갯수

		int listSize = 0; //현재 읽어온 게시물의 수
		int revenue = 0;
		Vector<BasketBean> vlist = null;

		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}

		start = (nowPage * numPerPage) - numPerPage;
		// 5페이지일 경우 nowPage : 5, numPerPage :  10
		// (nowPage * numPerPage) - numPerPage; => (50) - 10 => 40
		// start 가 40이라는 의미
		end = start + numPerPage; // end 는 50

		totalRecord = basMgr.getTotalDelivery(aid);

		totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
		//전체페이지수
		nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
		//현재블럭 계산
		totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
		//전체블럭계산
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<style>
#wrap{
width: 70%;
margin: 0 auto;
padding: 3%;
font-size: 0.8em;
}

a:link, a#aleft:link {
	text-decoration: none;
	color: #2d2d2d;
	font-size: 1.1em;
}

a:hover, a#aleft:hover {
	text-decoration: none;
	color: #2d2d2d;
	font-size: 1.1em;
	font-weight: bold;
}

a:visited, a#aleft:visited {
	text-decoration: none;
	font-size: 1.1em;
	color: #2d2d2d;
}
table{
text-align:center;
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
				<a id="aleft" href="../adminMain.jsp" title="adminMain">관리자 메인</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">배송내역 관리</h1>
			</header>
			</div>
		</div>
		
   			<div class="row">
			<div class="col">
			<div id="main">
			<div class="table-responsive">
			<table class="table table-borderless">
				<tr>
				<td colspan="2">
				<table class="table table-borderd">
				<tr>
				<td colspan="9" style="text-align: right; color: #606060;">총 상품 : <%=totalRecord%> 개
				</td>
				</tr>
				<tr id="title"> 
					<%
				  vlist = basMgr.getDeliverytList(aid, start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("<td>등록된 배송 내역이 없습니다.</td></tr></table>");
				  } else {
					%>
								<td>번호</td>
								<td>아이디</td>
								<td>상품종류</td>
								<td>상품이름</td>
								<td>세일</td>
								<td>원가격</td>
								<td>지불가격</td><!-- 원가격으로 -->
								<td>수량</td>
								<td>담은날짜</td>
							</tr>
							<tr>
								<td colspan="9"><hr></td>
							</tr>
							<%
								for (int i = 0;i<numPerPage; i++) {
									if (i == listSize) break;
										BasketBean basbean = vlist.get(i);
										String basid = basbean.getId();
										int basnum = basbean.getBasketNum();
										String protype = basbean.getProductType();
										String proname = basbean.getProductName();
										int pronum = basbean.getProductNum();
										
										ProductMgr pMgr = new ProductMgr();
										ProductBean pbean = pMgr.getProduct(pronum);
										int sale = pbean.getSale(); 
										String oriprice = pbean.getPrice();
										String price = basbean.getPrice();
										int quantity = basbean.getQuantity();
										String date = basbean.getBuydate();
										revenue += (Integer.parseInt(price) * quantity);
							%>

							<tr>
								<td><%=basnum%></td>
								<td><%=basid%></td>
								<td><%=protype%></td>
								<td><%=proname%></td>
								<td><% if(sale==1) out.println("O"); else out.println("X"); %>
								<td><%=oriprice %></td>
								<td><%=price%></td>
								<td><%=quantity%></td>
								<td><%=date%></td>
							</tr>
		<%
			} // for
		%>
	</table> 
	<%
 	} // if
 	%>
	</td>
	</tr>
	<tr>
		<td>
		<hr>
		</td>
	</tr>
      	<tr>
					<td style="text-align: right;">
					<!-- 페이징 및 블럭 처리 Start-->
			 <%
   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
   				  int pageEnd = ((pageStart + pagePerBlock ) < totalPage) ? 
   						  				(pageStart + pagePerBlock): 
   						  				totalPage+1; 
   				  //하단 페이지 끝 번호
   				  if(totalPage !=0){
    			  	if (nowBlock > 1) {
    			  	%>
    			  	 <a href="javascript:block('<%=nowBlock- 1%>')">prev...</a>
					<%}%>
					&nbsp;
					 <% for ( ; pageStart < pageEnd; pageStart++){ %>
					  <a href="javascript:pageing('<%=pageStart %>')" title=""> 
					  <% if (pageStart==nowPage) { %>
					  <span style="color : #ff919e; font-weight:bold">[
					  <%}%>
                      <%=pageStart %>
					  <% if (pageStart==nowPage) { %>]
					  </span>
					  <%}%>
					   </a>
					  
					   <%} //for%>&nbsp;
					   <%if (totalBlock > nowBlock ) { %> 
					   <a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
					   <%}%>&nbsp;
					<%}%>
					<!-- 페이징 및 블럭 처리 End-->
				&nbsp;		
				<!-- 각종 이동 버튼 -->
				<!-- 사용자 이동 버튼 출력  -->
				<input class="btn btn-secondary" type="button" value="목록 처음으로" onclick="javascript:list()">
				</td>
				</tr>
			</table>
			</div>
			</div>
			</div>
			</div>
	</div>
	</div>
	
<script type="text/javascript">
	
	function list() {
		location.href = "basketList.jsp";
	}
	
	function pageing(page) {
		location.href="basketList.jsp?nowPage=" + page;

	}

	function block(value) {
		nowValue =
<%=pagePerBlock%>
	* (value - 1) + 1;
	location.href="basketList.jsp?nowPage=" + nowValue;
	}
	
	</script>

</body>
	<% }
	%>
</html>