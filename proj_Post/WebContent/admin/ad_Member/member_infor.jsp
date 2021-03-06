<%@page import="pack_JDBC.MemberMgr"%>
<%@page import="pack_Bean.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page"/>
<%
	request.setCharacterEncoding("utf-8");
	MemberBean bean = (MemberBean) session.getAttribute("adminBean");
	String id = null;
	
	if(bean != null){
		id = bean.getId();
		if(id ==null || !id.equals("admin")){
			response.sendRedirect("../../index.jsp");
		}
	}else {
		response.sendRedirect("../../index.jsp");
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
	
	Vector<MemberBean> vlist = null;
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage * numPerPage) - numPerPage;
	// 5페이지일 경우 nowPage : 5, numPerPage :  10
	// (nowPage * numPerPage) - numPerPage; => (50) - 10 => 40
	// start 가 40이라는 의미
	end = start + numPerPage;  // end 는 50
	
	totalRecord = mMgr.getTotalMember() - 1; //관리자 아이디 갯수만큼 빼줘야함

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
<meta charset="">
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

table {
text-align: center;
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
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">회원정보 관리</h1>
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
				<td colspan="7" style="text-align: right; color: #606060;">총 회원 : <%=totalRecord%> 명
				</td>
				</tr>
				<tr id="title">
						<%
				  vlist = mMgr.getMemberList(start, end);
					
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
				  if (vlist.isEmpty()) {
					out.println("<td>가입 회원이 없습니다.</td></tr>");
				  } else {
			%>
								<td>아이디</td>
								<td>이름</td>
								<td>이메일</td>
								<td>생일</td>
								<td>주소</td>
								<td>핸드폰 번호</td>
								<td>탈퇴처리</td>
							</tr>
							<tr>
								<td colspan="7"><hr></td>
							</tr>
							<%
								for (int i = 0;i<numPerPage; i++) {
									if (i == listSize) break;
										MemberBean mbean = vlist.get(i);
										String mid = mbean.getId();
										String mname = mbean.getName();
										String memail = mbean.getEmail();
										String mbirthday = mbean.getBirthday();
										String mzipcode = mbean.getZipcode();
										String mphoneNum = mbean.getPhone1() + "-" + mbean.getPhone2() + "-" + mbean.getPhone3();
							%>

    <tr>
     <td><%=mid %></td>
     <td><%=mname %></td>
     <td><%=memail %></td>
     <td><%=mbirthday %></td>
     <td><%=mzipcode %></td>
     <td><%=mphoneNum %></td>
     <td>
     <% if(!mid.equals("admin")){ %>
     <input class="btn btn-light btn-block" type="button" value="탈퇴" onclick="javascript:deleteProcess('<%=mid%>', '<%=mname%>')">
     <%} %>
     </td>
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
		<td colspan="7">
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
					<input class="btn btn-secondary" type="button" value="목록처음으로" onclick="javascript:mlist()">
				</td>
				</tr>				
			</table>
			</div>
			</div>
			</div>
			</div>
			
      <form name="delFrm" method="post">
      <input type="hidden" name="id" value="">
      </form>
    </div>
   
   </div>
   
   <script type="text/javascript">
	function deleteProcess(mid, mname){
		
		chk = confirm("ID : " + mid + ", NAME : " + mname + "을 탈퇴시키겠습니까?");
		if (chk){
			document.delFrm.id.value = mid;
			document.delFrm.action="member_delete.jsp";
			document.delFrm.submit();
		} 

	}
	
	function mlist() {
		location.href = "member_infor.jsp";
	}
	
	function pageing(page) {
		location.href="member_infor.jsp?nowPage=" + page;

	}

	function block(value) {
		nowValue =
<%=pagePerBlock%>
	* (value - 1) + 1;
	location.href="member_infor.jsp?nowPage=" + nowValue;
	}
   </script>
</body>
</html>