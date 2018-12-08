<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="pack_JDBC.freeBoardMgr" scope="page" />
<jsp:useBean id="reBean" class="pack_Bean.freeBoardBean" scope="page"/>
<jsp:setProperty property="*" name="reBean"/>
<%
	bMgr.replyUpfreeBoard(reBean.getRef(), reBean.getPos());
	bMgr.replyfreeBoard(reBean);
	String nowPage = request.getParameter("nowPage");
	response.sendRedirect("freeList.jsp?nowPage="+nowPage);
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