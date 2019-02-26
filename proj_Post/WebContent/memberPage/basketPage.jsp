<!--  소비자 배송 목록, 구매 목록은 수정 불가능하고 삭제도 우선 막고.. 열람만 가능하게 하자 -->
<!--  관리자 장바구니 목록 열람, 삭제 까지만 확인하면 됨 -->
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
<title>SHOPNAME</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/myPageStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
</head>
<body>
	<div id="wrap">
		<div class="container-fluid">
		
		<div class="row">
		<div class="col">
		<header>
			<div style="text-align:left;">
			<a id="left" style="color: black; font-weight: 100; font-size: 1.1em;" href="../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">MyPage</h1>
			</header>
		</div>
		</div>

		
		<div class="row">
		<div class="col"> 	
		<div id="main">
		<div id="basketPageMain">	
			<div class="table-responsive">
			<h4 ><%=id%>님의 장바구니</h4>
			<table class="table table-borderless">
					<tr>
						<td colspan="6">
							<%
				  vlist = basMgr.getBasketList(id, start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("장바구니가 비어있습니다.");
				  } else {
			%>
							<table class="table" id="inner" style="font-size: 0.8em; text-align:center;">
								<tr>
									<th colspan="6" style="text-align: right">총 개수 : <%= totalRecord %> 개</th>
								</tr>
								<tr >
									<td>선택</td>
									<td>종류</td>
									<td>이름</td>
									<td>가격</td>
									<td>수량</td>
									<td>날짜</td>
								</tr>
								<tr>
									<td colspan="6"><hr></td>
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
									<!--  삭제처리 체크박스 -->
									<td>
											<input type="checkbox" name="chks" value="<%= basNum %>">
											<input type="hidden" name="basNums" value="">
									</td>
									<td><%= proType %></td>
									<td><a
										href="../product/productDetail.jsp?productNum=<%=proNum%>"><%=proName%></a>
									</td>
									<td><%=price%></td>
									<td><%=quantity%></td>
									<td><%=buyDate%></td>
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
					<td colspan="6">
					<hr>
					</td>
					</tr>
					<tr>
					<td colspan="5" style="text-align: left;">		
					<!-- 각종 이동 버튼 -->
					<!-- 사용자 이동 버튼 출력  -->
					<input class="btn btn-secondary btn-sm" type="button" value="목록 처음으로" onclick="javascript:baslist()">
					<input  class="btn btn-secondary btn-sm" type="button" value="장바구니 삭제" onclick="javascript:deleteProc()">
					<input  class="btn btn-secondary btn-sm"type="button" value="선택항목 구매" onclick="javascript:purchaseProc()">
					</td>
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
				</td>
				</tr>
				
			</table>
			<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true"> 
			<input type="hidden" name="nowPage" value="1">
		</form>
		</div>
		</div>
	</div>

		<div id="aside">
				<div class="table-responsive">
				<table class="table table-borderless">
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
					<td><a href="myPurchasePage.jsp" title="구매내역"> 구매내역</a></td>
				</tr>
			</table>
		</div>
		</div>

		<footer>
			&copy; 2018, 쇼핑몰이름 <br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
		</div>
		</div>
	</div>
	</div>
	
	<script type="text/javascript">
	
	function baslist() {
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
	
	function deleteProc(){
		
		conf = confirm("선택항목을 정말로 삭제하시겠습니까?");
		
		if(conf){
		var chk = document.getElementsByName("chks"); // 체크박스객체를 담는다
		var len = chk.length;    //체크박스의 전체 개수
		var checkRow = '';      //체크된 체크박스의 value를 담기위한 변수
		var checkCnt = 0;        //체크된 체크박스의 개수
		var checkLast = '';      //체크된 체크박스 중 마지막 체크박스의 인덱스를 담기위한 변수
		var rowNum = '';             //체크된 체크박스의 모든 value 값을 담는다
		var cnt = 0;                 

		for(var i=0; i<len; i++){
		if(chk[i].checked == true){
		checkCnt++;        //체크된 체크박스의 개수
		checkLast = i;     //체크된 체크박스의 인덱스
		}
		} 

		for(var i=0; i<len; i++){
		if(chk[i].checked == true){  //체크가 되어있는 값 구분
		checkRow = chk[i].value;
		            	
		if(checkCnt == 1){                            //체크된 체크박스의 개수가 한 개 일때,
		rowNum += checkRow;        //'value'의 형태 (뒤에 ,(콤마)가 붙지않게)
		}else{                                            //체크된 체크박스의 개수가 여러 개 일때,
		if(i == checkLast){                     //체크된 체크박스 중 마지막 체크박스일 때,
		rowNum += checkRow;  //'value'의 형태 (뒤에 ,(콤마)가 붙지않게)
		}else{
		rowNum += checkRow+"/";	 //'value',의 형태 (뒤에 ,(콤마)가 붙게)         			
		}
							
		}
		cnt++;
		checkRow = '';    //checkRow초기화.
		}
		}
		location.href="basDeleteProc.jsp?nums=" + rowNum;
		}
}

	function purchaseProc(){
		
		conf = confirm("선택항목을 구매하시겠습니까?");
		
		if(conf){
		var chk = document.getElementsByName("chks"); // 체크박스객체를 담는다
		var len = chk.length;    //체크박스의 전체 개수
		var checkRow = '';      //체크된 체크박스의 value를 담기위한 변수
		var checkCnt = 0;        //체크된 체크박스의 개수
		var checkLast = '';      //체크된 체크박스 중 마지막 체크박스의 인덱스를 담기위한 변수
		var rowNum = '';             //체크된 체크박스의 모든 value 값을 담는다
		var cnt = 0;                 

		for(var i=0; i<len; i++){
		if(chk[i].checked == true){
		checkCnt++;        //체크된 체크박스의 개수
		checkLast = i;     //체크된 체크박스의 인덱스
		}
		} 

		for(var i=0; i<len; i++){
		if(chk[i].checked == true){  //체크가 되어있는 값 구분
		checkRow = chk[i].value;
		            	
		if(checkCnt == 1){                            //체크된 체크박스의 개수가 한 개 일때,
		rowNum += checkRow;        //'value'의 형태 (뒤에 ,(콤마)가 붙지않게)
		}else{                                            //체크된 체크박스의 개수가 여러 개 일때,
		if(i == checkLast){                     //체크된 체크박스 중 마지막 체크박스일 때,
		rowNum += checkRow;  //'value'의 형태 (뒤에 ,(콤마)가 붙지않게)
		}else{
		rowNum += checkRow+"/";	 //'value',의 형태 (뒤에 ,(콤마)가 붙게)         			
		}
							
		}
		cnt++;
		checkRow = '';    //checkRow초기화.
		}
		}
		location.href="../product/purchasePage.jsp?id=<%=id%>&nums=" + rowNum;
		}
}

	</script>
</body>
</html>