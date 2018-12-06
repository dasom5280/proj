<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.Ad_QnABean"%>
<%@page import="pack_Bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" />

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

	MemberBean adminbean = (MemberBean)session.getAttribute("adminBean");

	if(adminbean==null){
		response.sendRedirect("../adminLogin.jsp");
	} else {
		String adminid = adminbean.getId();
		int level = adminbean.getLevel();
		
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>JSP Board</title>

<link rel="stylesheet" href="../../css/style.css">

<style>
table{
border-collapse: collapse;
}

td {
padding: 10px;
border: 1px solid gray;
}
</style>
</head>
<body>
	<div class="wrap" id="readWrap">
		<table class="readTable">
			<tr>
				<td colspan="4">글읽기</td>
			</tr>
				<tr>
			<td>상품이름</td>
			<td colspan="3"><%=productName%></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><% if(id.equals("admin")){out.println("관리자");} else {out.println(id);}%></td>
				<td>등록날짜</td>
				<td><%=regdate%></td>
			</tr>
			<tr>
			<td>아이피</td>
			<td colspan="3"><%=ip%></td>
			</tr>

			<tr>
				<td>제 목</td>
				<td colspan="3"><%=subject%></td>
			</tr>

			<tr>
				<td colspan="4"><pre><%=content%></pre></td>
			</tr>
			<tr>
				<td colspan="4"><a href="javascript:list()" title="">상품문의 메인</a>&nbsp;&nbsp;|&nbsp;&nbsp;

				<!-- 관리자는 답변 뜨고 사용자는 수정, 삭제 뜨도록 -->
				<a href="javascript:replyProcess()">답 변</a>
				</td>
			</tr>
		</table>

		<form name="qnaFrm" method="post">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="nowPage" value="<%=nowPage %>">
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
		<%
	}
		%>
	</div>
	<script>
		function list() {
			document.listFrm.action = "qnAlist.jsp";
			document.listFrm.submit();
		}

		function replyProcess() {
			document.qnaFrm.action="qnAreply.jsp";
			document.qnaFrm.submit();
			
		}
	</script>
</body>
</html>