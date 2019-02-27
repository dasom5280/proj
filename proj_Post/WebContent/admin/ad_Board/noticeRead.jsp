<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="pack_Bean.BoardBean"%>
<jsp:useBean id="bMgr" class="pack_JDBC.BoardMgr" />
<%@page import="pack_Bean.MemberBean"%>

<%
	request.setCharacterEncoding("UTF-8");

	MemberBean memberbean = (MemberBean) session.getAttribute("adminBean");
	// => post 또는 get방식으로 데이터 수신이 있음 
	int num = Integer.parseInt(request.getParameter("num"));

	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");

	bMgr.upCount(num); // 조회수 증가를 위한 소스

	BoardBean bean = bMgr.getBoard(num);
	// 해당 키값(=글 고유번호, 즉 num 값)을 갖는 데이터의 자료 반환 

	String name = bean.getName();
	String subject = bean.getSubject();
	String regdate = bean.getRegdate();
	String content = bean.getContent();
	String ip = bean.getIp();
	int count = bean.getCount();

	// bean으로 반환된 데이터를 세션으로 설정함(ID 및 로그인과 무관함) -> 설정하지 않는 것이 좋을거 같아요
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/boardStyle.css">
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
				<a id="aleft" href="../adminMain.jsp" title="adminMain">관리자 메인</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">공지사항</h1>
			</header>
			</div>
		</div>
		
		<div class="row">
				<div class="col">
				<div id="main" style="text-align:left;">
				<div class="table-responsive" style="background-color: white;">
			<table class="table" >
						<tr>
							<td class="fc">제 목</td>
							<td colspan="3" class="rangeLeft"><%=subject%></td>
							<td class="fc">조회수</td>
							<td><%=count %></td>
						</tr>
						<tr>
							<td class="fc">아이디</td>
							<td><%=name%></td>
							<td class="fc">등록날짜</td>
							<td><%=regdate%></td>				
							<td class="fc">아이피</td>
							<td><%=ip%></td>
						</tr>
						<tr>
							<td colspan="6" id="ct"><pre><%=content%></pre>
							</td>
						</tr>
						<tr>
						
						<td colspan="6" style="text-align: center; padding: 3%;">
						<a class="btn btn-secondary" href="javascript:list()" title="">목록</a>
			<%
				if (memberbean != null) {
				
					int level = memberbean.getLevel();
						if (level==2) {
			%>
				<a class="btn btn-secondary"
				href="noticeUpdate.jsp?nowPage=<%=nowPage%>&num=<%=num%>">수 정</a> 
				<a class="btn btn-secondary"
				href="noticeReply.jsp?nowPage=<%=nowPage%>&num=<%=num%>">답 변</a> 
				<a class="btn btn-secondary"
				href="noticeDelete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭 제</a> 
				
			<% 
				} 
			}
			%>
			</td>
			</tr>	
		</table>
		</div>
		</div>
		</div>
		</div>

		<form name="listFrm" method="post">
			<input type="hidden" name="num" value="<%=num%>"> <input
				type="hidden" name="nowPage" value="<%=nowPage%>">
			<%
				if (!(keyWord == null || keyWord.equals("null"))) {
			%>
			<input type="hidden" name="keyField" value="<%=keyField%>"> <input
				type="hidden" name="keyWord" value="<%=keyWord%>">
			<%
				}
			%>
		</form>
	</div>
	</div>
	<script>
	function list() {
		document.listFrm.action = "noticeList.jsp";
		document.listFrm.submit();
	}

</script>
</body>
</html>