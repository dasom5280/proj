<%@page import="pack_Bean.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page" />

<!-- <hr>의 의미 : 줄 -->

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

	totalRecord = pMgr.getTotalCount();
	
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
font-size: 0.9em;
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
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">상품 관리</h1>
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
				  vlist = pMgr.getProductList(keyField, keyWord, start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("<td>등록된 상품이 없습니다.</td></tr></table>");
				  } else {
			%>
				<th>상품번호</th>
				<th>이름</th>
				<th>사진</th>
				<th>종류</th>
				<th>가격</th>
				<th>재고</th>
				<th>세일</th>
				<th>퍼센트</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
						
						<%
							 for (int i = 0;i<numPerPage; i++) {
									if (i == listSize) break;
									ProductBean bean = vlist.get(i);
									int num = bean.getProductNum();
									String productName = bean.getProductName();
									String productType = bean.getProductType();
									String price = bean.getPrice();
									String inventory = bean.getInventory();
									String filename = bean.getFilename();
									int sale = bean.getSale();
									int percent = bean.getSalePercent();
									
						%>
			<tr>
				<td><%=num%></td>
				<td><%=productName%></td>
				<!-- 사진 섬네일로 바꿀만한 방법 생각해보기 -->
				<td><img src="../img_Product/<%=filename %>" width="40" height="40" alt=""></td>
				<td><%=productType%></td>
				<td><%=price%></td>
				<td><%=inventory%></td>
				<td><%if(sale==1) out.println("O"); else out.println("X"); %></td>
				<td><%=percent %> % </td>
				<td>
				<input class="btn btn-light btn-block" type="button" value="수정" onclick="location.href='productUpdate.jsp?productNum=<%=bean.getProductNum()%>'">
				</td>
				<td>
				<input class="btn btn-light btn-block" type="button" value="삭제" onclick="location.href='productDelete.jsp?productNum=<%=bean.getProductNum()%>'">
				</td>
			</tr>
						<% }   //for%>
					</table> 
					<% }//if %>
				</td>
			</tr>
			<tr>
			<td colspan="9">
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
					<%}%> <!-- 페이징 및 블럭 처리 End-->
				</td>
				</tr>
				<tr>
				<td style="text-align: right;">
				<form>
				<input class="btn btn-secondary" type="button" value="상품 추가" onclick="location.href='productAdd.jsp'">
				</form>
				</td>
				</tr>
		</table>
		</div>
		</div>
		</div>
		</div>
		
		<div class="row">
		<div class="col" align="center">
		<form name="searchFrm" method="post" action="productList.jsp">
			<table class="table-borderless">
				<tr>
					<td> <!--
					 	keyWord = "";
						keyField = ""; -->
					<div class="input-group input-group-sm mb-3">
					<select class="custom-select" name="keyField" size="1">	
									
							<option value="productName" 
							<% if(keyField.equals("productName")){%>selected="selected"<%}%> >상품이름</option>						
							<option value="productType" 
							<% if(keyField.equals("productType")){%>selected="selected"<%}%>>상품종류</option>
							<option value="explanation" 
							<% if(keyField.equals("explanation")){%>selected="selected"<%}%>>설 명</option>
	
					</select> 
					<input class="form-control" type="text" size="16" name="keyWord" value="<%=keyWord%>"> 
					<div class="input-group-append">
					<input class="btn btn-outline-secondary" type="button" value="찾기" onClick="javascript:check()"> 
					<input type="hidden" name="nowPage" value="1">
					</div>
					</div>
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
	</div>
</div>
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