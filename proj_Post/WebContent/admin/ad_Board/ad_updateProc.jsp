<%@page import="pack_Bean.Ad_BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="mMgr" class="pack_JDBC.Ad_BoardMgr" scope="page" />
<jsp:useBean id="upBean" class="pack_Bean.Ad_BoardBean" scope="page" />
<jsp:useBean id="bean" class="pack_Bean.Ad_BoardBean" scope="session" />
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
String inPass = bean.getPass();

if (upPass.equals(inPass)) {
	mMgr.updateBoard(upBean);
	String url = "ad_read.jsp?nowPage=" + nowPage + 
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