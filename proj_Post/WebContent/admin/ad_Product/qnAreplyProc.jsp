<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page" />
<jsp:useBean id="reBean" class="pack_Bean.Ad_QnABean" scope="page" />
<jsp:setProperty property="*" name="reBean" />

<%
	qMgr.replyUpQnA(reBean.getRef(), reBean.getPos());
	int num = Integer.parseInt(request.getParameter("num"));
	qMgr.replyQnA(reBean, num);

	String nowPage = request.getParameter("nowPage");
	response.sendRedirect("qnAlist.jsp?nowPage=" + nowPage);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<style>
div#wrap {
	width: 640px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>