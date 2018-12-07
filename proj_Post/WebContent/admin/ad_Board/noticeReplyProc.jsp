<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="pack_JDBC.BoardMgr" scope="page" />
<jsp:useBean id="reBean" class="pack_Bean.BoardBean" scope="page"/>
<jsp:setProperty property="*" name="reBean"/>
<%
	bMgr.replyUpBoard(reBean.getRef(), reBean.getPos());
	bMgr.replyBoard(reBean);
	String nowPage = request.getParameter("nowPage");
	response.sendRedirect("list.jsp?nowPage="+nowPage);
%>
    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>JSP 테스트</title>
<style>
	div#wrap {  width : 640px;  margin : 0 auto; }	
</style>
</head>
<body>
	<div id="wrap">
		

	</div>
</body>
</html>