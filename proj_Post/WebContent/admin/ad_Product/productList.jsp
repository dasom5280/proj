<%@page import="pack_Bean.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page" />

<%
	request.setCharacterEncoding("UTF-8");
	MemberBean abean = (MemberBean)session.getAttribute("adminBean");
	if(abean == null){
		response.sendRedirect("../adminLogin.jsp");
	} else {
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

	String keyWord = "";
	String keyField = "";
	Vector<ProductBean> vlist = null;
	
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}

	if (request.getParameter("reload") != null) {
		if (request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}

	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage) - numPerPage;
	// 5페이지일 경우 nowPage : 5, numPerPage :  10
	// (nowPage * numPerPage) - numPerPage; => (50) - 10 => 40
	// start 가 40이라는 의미
	end = start + numPerPage;  // end 는 50

	totalRecord = pMgr.getTotalCount(keyField, keyWord);
	
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
<title>상품관리</title>
<link rel="stylesheet" href="../../css/ad_Board.css">
</head>
<body>
	<div id="wrap">
		<!-- 관리자 메인 링크 수정 필요 -->
		<h1><a href="../adminMain.jsp">관리자 메인으로</a></h1>
		<h1>상품관리</h1>
		<table class="listTbl">
			<tr>
				<td>전체 글 : <%=totalRecord%> 개(<span style="color : brown">
						<%=nowPage%>/<%=totalPage%>Pages</span> )
				</td>
			</tr>
		</table>
		<table class="listTbl">
			<tr>
				<td colspan="2">
					<%
				  vlist = pMgr.getProductList(keyField, keyWord, start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("등록된 상품이 없습니다.");
				  } else {
			%>
			<table id="listInnerTbl">
			<tr>
				<th>상품번호</th>
				<th>상품이름</th>
				<th>상품종류</th>
				<th style="width: 15%;">설명</th>
				<th>가격</th>
				<th>재고</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<tr>
				<td colspan="7"><hr></td>
			</tr>
						
						<%
							 for (int i = 0;i<numPerPage; i++) {
									if (i == listSize) break;
									ProductBean bean = vlist.get(i);
									int num = bean.getProductNum();
									String productName = bean.getProductName();
									String productType = bean.getProductType();
									String explanation = bean.getExplanation();
									String price = bean.getPrice();
									String inventory = bean.getInventory();
									
						%>
			<tr>
				<td><%=bean.getProductNum()%></td>
				<td><%=bean.getProductName()%></td>
				<td><%=bean.getProductType()%></td>
				<td><%=bean.getExplanation()%></td>
				<td><%=bean.getPrice()%></td>
				<td><%=bean.getInventory()%></td>
				<td>
				<input type="button" value="상품 수정" onclick="location.href='productUpdate.jsp?productNum=<%=bean.getProductNum()%>'">
				</td>
				<td>
				<input type="button" value="상품 삭제" onclick="location.href='productDelete.jsp?productNum=<%=bean.getProductNum()%>'">
				</td>
			</tr>
						<% }   //for%>
					</table> 
					<% }//if %>
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
					<%}%> <!-- 페이징 및 블럭 처리 End-->
				</td>
				<td>
				<form>
				<input type="button" value="상품 추가" onclick="location.href='productAdd.jsp'">
				</form>
				</td>
					</tr>
		</table>
		<hr>
		<form name="searchFrm" method="post" action="productList.jsp">
			<table>
				<tr>
					<td> <!--
					 	keyWord = "";
						keyField = ""; -->
					<select name="keyField" size="1">	
									
							<option value="productName" 
							<% if(keyField.equals("productName")){%>selected="selected"<%}%> >상품이름</option>						
							<option value="productType" 
							<% if(keyField.equals("productType")){%>selected="selected"<%}%>>상품종류</option>
							<option value="explanation" 
							<% if(keyField.equals("explanation")){%>selected="selected"<%}%>>설 명</option>
	
					</select> 
					<input type="text" size="16" name="keyWord" value="<%=keyWord%>"> 
					<input type="button" value="찾기" onClick="javascript:check()"> 
					<input type="hidden" name="nowPage" value="1">
					</td>
				</tr>
			</table>
		</form>
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true"> 
			<input type="hidden" name="nowPage" value="1">
		</form>
		<form name="readFrm" method="get">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField%>"> 			
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
	</div>

	<!-- 자바스크립트 구문 -->
	<script type="text/javascript">
	
	function flist() {
		document.listFrm.action = "productList.jsp";
		document.listFrm.submit();
	}
	

	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}

	function block(value) {
		document.readFrm.nowPage.value =
<%=pagePerBlock%>
	* (value - 1) + 1;
		document.readFrm.submit();
	}

	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
</script>

	<%
	}
	%>
</body>
</html>
	
	</div>
</body>
</html>