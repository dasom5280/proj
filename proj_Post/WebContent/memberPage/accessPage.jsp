<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="pack_Bean.AccessRecordBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />

<%
	request.setCharacterEncoding("utf-8");

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

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
	
	Vector<AccessRecordBean> vlist = null;
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage) - numPerPage;
	// 5페이지일 경우 nowPage : 5, numPerPage :  10
	// (nowPage * numPerPage) - numPerPage; => (50) - 10 => 40
	// start 가 40이라는 의미
	end = start + numPerPage;  // end 는 50
	
	totalRecord = mMgr.getTotalAccess(id);

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
<title>로그인 기록 정보</title>

<link type="text/css" rel="stylesheet" href="../css/myPageStyle.css">

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
			<div id="accessPageMain">
			<h3>로그인 정보</h3>
				<table>
					<tr>
						<td colspan="2"><%
				  vlist = mMgr.getARecord(id, start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("접속기록이 없습니다.");
				  } else {
			%>
							<table id="inner">
								<tr>
									<th colspan="2" style="text-align: right">총 개수 : <%= totalRecord %> 개</th>
								</tr>
								<tr>
									<td>접속시간</td>
									<td>아이피</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
								<%
							 for (int i = 0;i<numPerPage; i++) {
									if (i == listSize) break;
									AccessRecordBean abean = vlist.get(i);
									Timestamp atime = abean.getLoginTime();
									String aip = abean.getIp();
						%>
								<tr>
									<td><%= df.format(atime) %></td>
									<td><%=aip%></td>
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
					<td colspan="2">
					<hr>
					</td>
					</tr>
					<tr>
					<td style="text-align: right;">
					<input type="button" value="목록 처음으로" onclick="javascript:alist()">
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
				<tr id="selected">
					<td><a href="#" title="로그인기록확인"> 로그인기록확인</a></td>
				</tr>
				<tr>
					<td><a href="basketPage.jsp" title="장바구니"> 장바구니</a></td>
				</tr>
				<tr>
					<td><a href="myPurchasePage.jsp" title="구매내역"> 구매내역</a></td>
				</tr>
			</table>
		</div>

		<footer>
			&copy; 2018, 쇼핑몰이름 <br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>

	</div>
	<script type="text/javascript">
	function alist() {
		location.href = "accessPage.jsp";
	}
	
	function pageing(page) {
		location.href="accessPage.jsp?nowPage=" + page;

	}

	function block(value) {
		nowValue =
<%=pagePerBlock%>
	* (value - 1) + 1;
	location.href="accessPage.jsp?nowPage=" + nowValue;
	}
	
	</script>
</body>
</html>