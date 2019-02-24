<!-- 나중에 페이징 처리도 추가하자 -->
<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_JDBC.ProductMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
		request.setCharacterEncoding("utf-8");
		String mainProtype = request.getParameter("productType");
		MemberBean bean = (MemberBean) session.getAttribute("loginBean");

		int totalRecord = 0; //전체레코드수
		int numPerPage = 20; // 페이지당 레코드 수 
		int pagePerBlock = 10; //블럭당 페이지수 
		
		int totalPage = 0; //전체 페이지 수
		int totalBlock = 0; //전체 블럭수 

		int nowPage = 1; // 현재페이지
		int nowBlock = 1; //현재블럭

		int start = 0; //디비의 select 시작번호
		int end = 20; //시작번호로 부터 가져올 select 갯수

		int listSize = 0; //현재 읽어온 게시물의 수
		
		Vector<ProductBean> vlist = null;
		
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		start = (nowPage * numPerPage) - numPerPage;
		// 5페이지일 경우 nowPage : 5, numPerPage :  10
		// (nowPage * numPerPage) - numPerPage; => (50) - 10 => 40
		// start 가 40이라는 의미
		end = start + numPerPage;  // end 는 50

		ProductMgr pMgr = new ProductMgr();
		
		totalRecord = pMgr.getTotalCount(mainProtype);//매개변수 수정필요. 없어도 됨

		totalPage = (int) Math.ceil((double)totalRecord / numPerPage);
							//전체페이지수
		nowBlock = (int) Math.ceil((double)nowPage / pagePerBlock);
							//현재블럭 계산
		totalBlock = (int) Math.ceil((double)totalPage / pagePerBlock);
							//전체블럭계산
		
		
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
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
				<li class="nav-item"<%if(mainProtype.equals("outer")) {%> id="selected" <%} %>><a class="nav-link" href="productList.jsp?productType=outer" title="Outer">OUTER</a></li>
				<li class="nav-item"<%if(mainProtype.equals("top")) {%> id="selected" <%} %>><a class="nav-link" href="productList.jsp?productType=top" title="Top">TOP</a></li>
				<li class="nav-item"<%if(mainProtype.equals("bottom")) {%> id="selected" <%} %>><a class="nav-link" href="productList.jsp?productType=bottom" title="Bottom">BOTTOM</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/memberBoard/noticelist.jsp" title="Notice">NOTICE</a></li>
				<li class="nav-item"><a class="nav-link" href="../admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/freeBoard/freeList.jsp" title="freeBoard">FREEBOARD</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
			<%
				if (bean != null) {
					String id = bean.getId();
						if (id != null) {
			%>
				<li class="nav-item"><a class="nav-link" href="../member/passCheck.jsp" title="MyPage">ID : <%= id %></a></li>
				<li class="nav-item"><a class="nav-link" href="../memberPage/basketPage.jsp" title="MyCart">MYCART</a></li>
				<li class="nav-item"><a class="nav-link" href="../member/logout.jsp" title="">LOGOUT</a></li>
			<% 
				} 
			}else {
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
					<form name="listFrm" method="post">
						<table class="table table-borderless">

							<tr>
								<!-- 수정 -->
								<%
									
								vlist = pMgr.getProductList(mainProtype, start, end);
								
								if(vlist.isEmpty()){
									out.println("<td>입고된 상품이 없습니다.</td></tr>");
								} else {
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
											<td class="galleryImg2"><img
												src="../admin/img_Product/<%=filename%>" width="120"
												height="150" alt=""></td>
										</tr>

										<tr>
											<td>
											<a href="javascript:detailProc('<%=proNum%>')">
											<% 
											if(proNum> pMgr.getTotalCount() - 10)//신상품 상위 10개만 도출 -전체상품에서 상위 10개
												out.println("<span class='badge badge-warning'>new</span>");
											if (sale==1) out.println("<span class='badge badge-danger'>sale!</span>&nbsp;"); 
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
							
							<tr style="text-align: center;">
								<td colspan="5">
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
				</td>
				<% } %>
				</tr>
						</table>
						<input type="hidden" name="productNum" value="">
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
<script type="text/javascript">
function detailProc(num){
	document.listFrm.productNum.value= num;
	document.listFrm.action="productDetail.jsp";
	document.listFrm.submit();
}

function pageing(page) {
	location.href="productList.jsp?productType=<%=mainProtype%>&nowPage=" + page;
}

function block(value) {
	nowValue =
		<%=pagePerBlock%>
			* (value - 1) + 1;
			location.href="productList.jsp?productType=<%=mainProtype%>&nowPage=" + nowValue;
}
</script>
</body>

</html>