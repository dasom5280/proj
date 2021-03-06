<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.Ad_QnABean"%>
<%@page import="pack_Bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page"/>

<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");

	Ad_QnABean bean = qMgr.getQnA(num);
	String id = bean.getId();
	String subject = bean.getSubject();
	String regdate = bean.getRegdate();
	String content = bean.getContent();
	String ip = bean.getIp();
	String ref = String.valueOf(bean.getRef());
	String pos = String.valueOf(bean.getPos());
	String depth = String.valueOf(bean.getDepth());
	String productName = bean.getProductName();

	MemberBean lobean = (MemberBean)session.getAttribute("loginBean");
	
	String adminId = "admin";
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
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
			<a id="left" href="../../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">Q&A</h1>
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
				<td colspan="5"><%=subject%></td>
			</tr>
			
			<tr>
			<td class="fc">상품이름</td>
			<td colspan="5"><%=productName%></td>
			</tr>
			<tr>
				<td class="fc">아이디</td>
				<td><% if(id.equals(adminId)){out.print("관리자");} else {out.print(id);}%></td>
				<td class="fc">등록날짜</td>
				<td><%=regdate%></td>
				<td class="fc">아이피</td>
				<td><%=ip%></td>
			</tr>

			
			
			<tr>
				<td colspan="6" id="ct"><pre><%=content%></pre></td>
			</tr>
			<tr>
				<td colspan="6" style="text-align: center; padding: 3%;">
				<a class="btn btn-secondary" href="javascript:flist()" title="">목록</a>

				<!-- 관리자는 답변 뜨고 로그인한 사용자는 수정, 삭제 뜨도록 -->
				<%if(lobean != null && id.equals(lobean.getId())) {%>
				<a class="btn btn-secondary" href="qnAUpdate.jsp?nowPage=<%=nowPage%>&num=<%=num%>">수정</a>
				<a class="btn btn-secondary" href="javascript:deleteProcess()">삭제</a>
				<%} %>
				</td>
			</tr>
		</table>
		</div>
		</div>
		</div>
		</div>
		
		<form name="delFrm" method="post">
		<input type="hidden" name="num" value="<%=num %>">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		<input type="hidden" name="inPass" value="">
		</form>
		
		<form name="listFrm" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<%
				if (!(keyWord == null || keyWord.equals(""))) {
			%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%
				}
			%>
		</form>
	</div>
	</div>
	<script type="text/javascript">
		function flist() {
			document.listFrm.action = "qnAlist.jsp";
			document.listFrm.submit();
		}
		
		function deleteProcess(){
			url = "qnApassCheck.jsp?num=" + <%=num%> +"&nowPage="+<%=nowPage%>;
			window.open(url, "DelProcess",
					"width=500, height=300, scrollbars=yes top=200 left=600");
		
		}

	
	</script>
</body>
</html>