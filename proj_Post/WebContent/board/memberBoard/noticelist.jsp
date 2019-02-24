<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="pack_JDBC.BoardMgr" />
<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.BoardBean"%>
<jsp:setProperty name="bean" property="*" />
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean bean = (MemberBean) session.getAttribute("adminBean");
	

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

	String keyWord = "", keyField = "";
	Vector<BoardBean> vlist = null;
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

	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int) Math.ceil((double)totalRecord / numPerPage);
						//전체페이지수
	nowBlock = (int) Math.ceil((double)nowPage / pagePerBlock);
						//현재블럭 계산
	totalBlock = (int) Math.ceil((double)totalPage / pagePerBlock);
						//전체블럭계산
%>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
<style type="text/css">
#main {
color : #606060;
}
</style>
<link rel="stylesheet" href="../../css/boardStyle.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">


<script src=../../js/script.js></script>
<script>
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

	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "read.jsp";
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
</head>
<body>
	<div id="wrap">
		
		<div class="container-fluid">
		
		<div class="row">
			<div class="col">
			<header>
			<div style="text-align:left;">
			<a id="left" style="color: black; font-weight: 100; font-size: 1.1em;"href="../../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">공지사항</h1>
			</header>
			</div>
		</div>
			<div class="row">
				<div class="col">
				<div id="main">
				<div class="table-responsive">
				<table class="table table-borderless">
				<tr>
				<td>
				<table class="table table-borderd">
				<tr>
				<td colspan="5" style="text-align: right; color: #606060;">전체 글 : <%=totalRecord%> 개(
						<%=nowPage%>/<%=totalPage%>Pages)</td>
				</tr>
			<tr id="title">
					<%
				  vlist = bMgr.getBoardList(keyField, keyWord, start, end);
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("<td colspan='5'>등록된 게시물이 없습니다.</td></tr>");
				  } else {
			%>
							<th>번 호</th>
							<th>제 목</th>
							<th>이 름</th>
							<th>날 짜</th>
							<th>조회수</th>
						</tr>
						<tr>
							<td colspan="5"><hr></td>
						</tr>
						<%
							 for (int i = 0;i<numPerPage; i++) {
									if (i == listSize) break;
									BoardBean boardbean = vlist.get(i);
									int num = boardbean.getNum();
									String name = boardbean.getName();
									String subject = boardbean.getSubject();
									String regdate = boardbean.getRegdate();
									int depth = boardbean.getDepth();
									int count = boardbean.getCount();
						%>
						<tr>
							<td><!-- 글번호의미함 num 아님-->
							
							<%
							if(depth == 0) {
								out.print(num);
								//out.print(totalRecord-((nowPage-1)*numPerPage)-i);
							}							
							%>
							
							
							</td>
							<td class="rangeLeft">
								<%
								if(depth>0){									
									for(int j=0;j<depth;j++){
											out.println("&nbsp;&nbsp;");
									}
								%>	
									<img src="../../images/replyImg.png" alt="replyImg">
								<%								
								}
								%>
								<!--
								num는 글의 고유번호,  
								list=>read 로 링크할 때 해당 글번호임을 알려주는
								열쇠가 된다.(키값)
								 -->
								 <a id="subtitle" href="javascript:read('<%=num%>')" title="">
								 <%=subject%>
								 </a>
							</td>
							<td><%=name%></td>
							<td><%=regdate%></td>
							<td><%=count%></td>
						</tr>
						<% }   //for
							 }//if %>
					</table> 
				</td>
			</tr>
			<tr>
			<td>
			<hr>
			</td>
			</tr>
			<tr>
				<td colspan="5" style="text-align: center;">
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
					   <% }%>&nbsp;
					<% }%> <!-- 페이징 및 블럭 처리 End-->
				</td>
				<td>
				 
				</td>
			</tr>
		</table>
	</div>
	</div>
	</div>
	</div>
		
		<div class="row">
		<div class="col" align="center">
		<form name="searchFrm" method="post" action="list.jsp">
			<table class="table-borderless">
				<tr>
					<td> <!--
					 	keyWord = "";
						keyField = ""; -->
					<div class="input-group input-group-sm mb-3">
					<select class="custom-select" name="keyField" size="1">	
									
							<option value="-">검색항목선택</option> 						
							<option value="name" 
							<% if(keyField.equals("name")){%>selected<%}%>>이 름</option>
							<option value="subject" 
							<% if(keyField.equals("subject")){%>selected<%}%>>제 목</option>
							<option value="content" 
							<% if(keyField.equals("content")){%>selected<%}%>>내 용</option>
					</select> 
					<input type="text" class="form-control" size="16" name="keyWord" value="<%=keyWord%>"> 
					<div class="input-group-append">
					<input class="btn btn-outline-secondary" id="button-addon2" type="button" value="찾기" onClick="javascript:check()"> 
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
			<input type="hidden" name="num">   
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField%>"> 			
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
		</div>
		</div>
	</div>
	</div>
</body>
</html>