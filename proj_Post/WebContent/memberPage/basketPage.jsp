<!-- 장바구니 수정, 장바구니 삭제(자바스크립트 이용 여러개 삭제) 구현만 하면 끝 -->
<!--  관리자 장바구니 목록 열람, 삭제 까지만 확인하면 됨 -->
<!--  구매누르면 계산 합 + 결제 수단 하고 결제 진행하고 buy값 변경하도록만 -->
<!--  구매 목록은 수정 불가능하고 삭제도 우선 막고.. 열람만 가능하게 하자 -->
<!--  관리자는 구매 목록 열람, 배송처리만 하도록 하고 -->
<!--  배송된 것들만 따로 보도록 열람만 하도록 하는 페이지 만들기 -->
<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="pack_Bean.BasketBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
	String id = null;
	if(bean == null)
		response.sendRedirect("../index.jsp");
	else {
		id = bean.getId();
	}
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
	
	Vector<BasketBean> vlist = null;
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage) - numPerPage;
	// 5페이지일 경우 nowPage : 5, numPerPage :  10
	// (nowPage * numPerPage) - numPerPage; => (50) - 10 => 40
	// start 가 40이라는 의미
	end = start + numPerPage;  // end 는 50

	BasketMgr basMgr = new BasketMgr();
	
	totalRecord = basMgr.getTotalCount(id);

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
<title>My page</title>
<link rel="stylesheet" href="../css/myPageStyle.css">
</head>
<body>
	<div id="wrap">
		<header class="top">

			<a href="../index.jsp" title="로고"><img id="headerLogo"
				src="../images/headerLogo.gif" alt="로고"></a><br> <br>
			<h2>
				<b>마이페이지</b>
			</h2>

		</header>

		<div id="main">
		<div id="basketPageMain">
		<table>
					<tr>
						<td colspan="7">
							<%
				  vlist = basMgr.getBasketList(id, start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("장바구니가 비어있습니다.");
				  } else {
			%>
							<table id="inner">
								<tr>
									<th colspan="7"><%=id%>님의 장바구니</th>
								</tr>
								<tr>
									<th colspan="7" style="text-align: right">총 개수 : <%= totalRecord %> 개</th>
								</tr>
								<tr>
									<th>선택</th>
									<th>상품종류</th>
									<th>상품이름</th>
									<th>가격</th>
									<th>수량</th>
									<th>등록날짜</th>
									<th>수정</th>
								</tr>
								<tr>
									<td colspan="7"><hr></td>
								</tr>
								<%
							 for (int i = 0;i<numPerPage; i++) {
									if (i == listSize) break;
									BasketBean basbean = vlist.get(i);
									int basNum = basbean.getBasketNum();
									String proType = basbean.getProductType();
									String proName = basbean.getProductName();
									int proNum = basbean.getProductNum();
									String price = basbean.getPrice();
									int quantity = basbean.getQuantity();
									String buyDate = basbean.getBuydate();
						%>
								<tr>
									<td>
									<input type="checkbox" name="chkBox" id="chk">
									<td><%= proType %></td>
									<td><a
										href="../product/productDetail.jsp?productNum=<%=proNum%>"><%=proName%></a>
									</td>
									<td><%=price%></td>
									<td><%=quantity%></td>
									<td><%=buyDate%></td>
									<td>
									<input type="button" name="basUpdate" value="수정" onclick="location.href='basketUpdate.jsp?id=<%=id %>&basketNum=<%=basNum%>'">
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
					  <span style="color : brown; font-weight:bold">[
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
				
				<td style="text-align: right;">		
				<!-- 각종 이동 버튼 -->
				<!-- 사용자 이동 버튼 출력  -->
				<input type="button" value="목록 처음으로" onclick="baslist()">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="장바구니 삭제" onclick="">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="선택항목 구매" onclick="">
				</td>
				</tr>
				
			</table>

		</div>
	</div>

		<div id="aside">
			<table>

				<tr>
					<td><a href="../member/passCheck.jsp" title="회원정보수정">
							회원정보수정</a></td>
				</tr>
				<tr>
					<td><a href="accessPage.jsp" title="로그인기록확인"> 로그인기록확인</a></td>
				</tr>
				<tr id="selected">
					<td><a href="#" title="장바구니"> 장바구니</a></td>
				</tr>
				<tr>
					<td><a href="purchasePage.jsp" title="구매내역"> 구매내역</a></td>
				</tr>
			</table>
		</div>

		<footer>
			&copy; 2018, 쇼핑몰이름 <br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>

	</div>
	
	<script type="text/javascript">
	
	function flist() {
		location.href = "basketPage.jsp";
	}
	
	function pageing(page) {
		location.href="basketPage.jsp?nowPage=" + page;

	}

	function block(value) {
		nowValue =
<%=pagePerBlock%>
	* (value - 1) + 1;
	location.href="basketPage.jsp?nowPage=" + nowValue;
	}
	</script>
</body>
</html>