<%@page import="pack_Bean.Ad_QnABean"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page"/>
<%
	request.setCharacterEncoding("utf-8");

	MemberBean aBean = (MemberBean) session.getAttribute("adminBean");
	
	if(aBean==null){
		response.sendRedirect("../adminLogin.jsp");
	} else {
	
	int num = Integer.parseInt(request.getParameter("num"));
	Ad_QnABean qBean = qMgr.getQnA(num);
	String nowPage = request.getParameter("nowPage");
	String id = qBean.getId();
	String subject = qBean.getSubject();
	String content = qBean.getContent();
	int ref = qBean.getRef();
	int pos = qBean.getPos();
	int depth = qBean.getDepth();
	String productName = qBean.getProductName();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>JSP Board</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="wrap" id="replyWrap">
		<form name="post" method="post" action="qnAreplyProc.jsp">
			<table>
				<tr>
					<td colspan="2">답변하기</td>
				</tr>

				<tr>
					<td>고객아이디</td>
					<td><%=id %></td>
				</tr>
				
				<tr>
					<td>상품이름</td>
					<td><%=productName %></td>
				</tr>

				<tr>
					<td>제 목</td>
					<td><input type="text" name="subject" size="45" value="답변 : <%=subject%>" maxlength="50"></td>
				</tr>

				<tr>
					<td>내 용</td>
					<td><textarea name="content" rows="12" cols="50"></textarea></td>
				</tr>

				<tr>
					<td colspan="2"><br></td>
				</tr>

				<tr>
					<td colspan="2"><input type="submit" value="답변등록">
					<input	type="reset" value="다시쓰기">
					<input type="button" value="원글보기" onclick="history.back()"></td>
				</tr>

			</table>
			<input type="hidden" name="num" value=<%=num %>>
			<input type="hidden" name="productName" value="<%=productName%>">
			<input type="hidden" name="id" value=<%=aBean.getId() %>>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input
				type="hidden" name="ref" value="<%=ref%>">
				<input
				type="hidden" name="pos" value="<%=pos%>">
				<input
				type="hidden" name="depth" value="<%=depth%>">
		</form>
		
		<%}
	%>
	</div>
</body>
</html>