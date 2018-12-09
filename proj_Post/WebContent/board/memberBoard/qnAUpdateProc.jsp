<%@page import="pack_Bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page" />
<jsp:useBean id="upBean" class="pack_Bean.Ad_QnABean" scope="page" />
<jsp:setProperty property="*" name="upBean" /> 


<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>JSP 게시글 수정</title>


<%
String nowPage = request.getParameter("nowPage");
String num = request.getParameter("num");

String upPass = upBean.getPass();
String oriPass = request.getParameter("oripass");
%>
<script type="text/javascript">
alert("<%out.print(upBean.getProductName());%>");
</script>
<%
if (upPass.equals(oriPass)) {
	qMgr.updateQnA(upBean);
	String url = "qnAread.jsp?nowPage=" + nowPage + 
						"&num=" + num;
	response.sendRedirect(url);
} else {
%> 

<script>
	alert("비밀번호가 일치하지 않습니다.");
	history.back();
</script>

<% } %>

</head>
<body>
	<div id="wrap">
		

	</div>
</body>
</html>