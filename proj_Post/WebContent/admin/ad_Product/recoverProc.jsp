<%@page import="java.util.StringTokenizer"%>
<%@page import="pack_Bean.Ad_QnABean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page" />

<%
	request.setCharacterEncoding("utf-8");

	String nums = request.getParameter("recNums");

	StringTokenizer st = new StringTokenizer(nums, "a");
	while (st.hasMoreTokens()) {
		int num = Integer.parseInt(st.nextToken());
		qMgr.recoverQnA(num);
	}

	response.sendRedirect("qnAdeletedList.jsp");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>