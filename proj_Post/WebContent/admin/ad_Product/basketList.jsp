<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="pack_JDBC.ProductMgr"%>
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

		Vector<BasketBean> vlist = null;

		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}

		start = (nowPage * numPerPage) - numPerPage;
		// 5페이지일 경우 nowPage : 5, numPerPage :  10
		// (nowPage * numPerPage) - numPerPage; => (50) - 10 => 40
		// start 가 40이라는 의미
		end = start + numPerPage; // end 는 50

		totalRecord = basMgr.getTotalCount(aid);

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
<title>Basket</title>
</head>
<body>
	<div id="wrap">
		<div align="left">
			<a href="../adminMain.jsp" title="adminMain">관리자 메인</a>
		</div>
		
		<header>
      <h2>장바구니 관리</h2>
      </header>
      <div id="main">
      	
   		<table>
				<tr>
					<td colspan="8">
					<%
				  vlist = basMgr.getBasketList(aid, start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("등록된 장바구니가 없습니다.");
				  } else {
					%>
					<table id="inner">
							<tr>	
								<td style="text-align: left"><a href="productList.jsp" title="">상품관리</a></td>
								<th colspan="7" style="text-align: right">총 개수 : <%= totalRecord %> 개</th>
								</tr>
							<tr>
								<td>선택</td>
								<td>번호</td>
								<td>아이디</td>
								<td>상품종류</td>
								<td>상품이름</td>
								<td>가격</td><!-- 원가격으로 -->
								<td>수량</td>
								<td>담은날짜</td>
							</tr>
							<tr>
								<td colspan="8"><hr></td>
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
										String price = new ProductMgr().getProduct(pronum).getPrice();
										int quantity = basbean.getQuantity();
										String date = basbean.getBuydate();
							%>

							<tr>
									<!--  삭제처리 체크박스 -->
								<td>
									<input type="checkbox" name="chks" value="<%= basnum %>">
									<input type="hidden" name="basNums" value="">
								</td>
								<td><%=basnum%></td>
								<td><%=basid%></td>
								<td><%=protype%></td>
								<td><%=proname%></td>
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
		<td colspan="8">
		<hr>
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
				<input type="button" value="목록 처음으로" onclick="javascript:list()">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="장바구니 삭제" onclick="javascript:deleteProc()">
				</td>
				</tr>
				
			</table>
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
		location.href="basketDeleteProc.jsp?nums=" + rowNum;
		}
}


	</script>

</body>
	<% }
	%>
</html>