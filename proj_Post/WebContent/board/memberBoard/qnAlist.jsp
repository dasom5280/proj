<!-- 사용자가 보는 Q&A 페이지 -->
<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.Ad_QnABean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page" />
<%
	request.setCharacterEncoding("UTF-8");

	MemberBean ubean = (MemberBean)session.getAttribute("loginBean");
	
	String adminId = "admin";
	
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
	Vector<Ad_QnABean> vlist = null;
	
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

	totalRecord = qMgr.getTotalCount(keyField, keyWord);
	
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
<title>Q&A</title>
<style type="text/css">
table tr td, table tr th{
padding: 10px;
}
</style>

</head>
<body>
	<div id="wrap">
		<h1><a href="../../index.jsp">MAIN</a></h1>
		<h1>Q&A</h1>
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
				  vlist = qMgr.getQnAList(keyField, keyWord, start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				  } else {
			%>
					<table id="listInnerTbl">
						<tr>
							<th>번 호</th>
							<th>제목</th>
							<th>아이디</th>
							<th>아이피</th>
							<th>상품이름</th>
							<th>날 짜</th>
						</tr>
						<tr>
							<td colspan="6"><hr></td>
						</tr>
						<%
							 for (int i = 0;i<numPerPage; i++) {
									if (i == listSize) break;
									Ad_QnABean bean = vlist.get(i);
									int num = bean.getNum();
									String id = bean.getId();
									String ip = bean.getIp();
									String productName = bean.getProductName();
									String subject = bean.getSubject();
									String regdate = bean.getRegdate();
									int depth = bean.getDepth();
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
									<img src="../../images/replyImg.png" alt="답변">
								<%								
								}
								%>
								<!--
								num는 글의 고유번호,  
								list=>read 로 링크할 때 해당 글번호임을 알려주는
								열쇠가 된다.(키값)
								 -->
								 <a href="javascript:read('<%=num%>')" title="">
								 <%=subject%>
								 </a>
							</td>
							<td><% if(id.equals(adminId)){out.print("관리자");} else {out.print(id);}%></td>
							<td><%=ip%></td>
							<td><%=productName%></td>
							<td><%=regdate%></td>
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
				<!-- 각종 이동 버튼 -->
				<!-- 사용자 이동 버튼 출력  -->
				<input type="button" value="목록처음으로" onclick="flist()">
				<% if (ubean!=null){ %>
				&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="글쓰기" onclick="location.href='qnAPost.jsp'">
				<%} %>
				</td>
			</tr>
		</table>
		<hr>
		<form name="searchFrm" method="post" action="qnAlist.jsp">
			<table>
				<tr>
					<td> <!--
					 	keyWord = "";
						keyField = ""; -->
					<select name="keyField" size="1">	
									
							<option value="productName" 
							<% if(keyField.equals("productName")){%>selected="selected"<%}%> >상품이름</option>						
							<option value="id" 
							<% if(keyField.equals("id")){%>selected="selected"<%}%>>아이디</option>
							<option value="subject" 
							<% if(keyField.equals("subject")){%>selected="selected"<%}%>>제 목</option>
							<option value="content" 
							<% if(keyField.equals("content")){%>selected="selected"<%}%>>내 용</option>
	
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
			<input type="hidden" name="num">   
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField%>"> 			
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
		</form>
	</div>

	<!-- 자바스크립트 구문 -->
	<script type="text/javascript">
	
	function flist() {
		document.listFrm.action = "qnAlist.jsp";
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

	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "qnAread.jsp";
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

</body>
</html>