<%@page import="pack_Bean.MemberBean"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="pack_Bean.Ad_QnABean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page" />


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<%
	request.setCharacterEncoding("utf-8");

	MemberBean sbean = (MemberBean) session.getAttribute("adminBean");
	if(sbean == null){
		response.sendRedirect("../adminLogin.jsp");
	} else{
	String nums = request.getParameter("nums");

	StringTokenizer st = new StringTokenizer(nums, "/");
	while (st.hasMoreTokens()) {
		int num = Integer.parseInt(st.nextToken());
		qMgr.deleteQnA(num, sbean.getLevel());
	}

	%>
	<script type="text/javascript">
	alert("삭제 완료");
	</script>
	
	<%
	response.sendRedirect("qnAlist.jsp");
	}
	%>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>