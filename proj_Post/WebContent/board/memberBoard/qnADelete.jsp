<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.Ad_QnABean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>Board Delete</title>
<link rel="stylesheet" href="../../css/ad_Board.css">

<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page"/>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	if (request.getParameter("inPass") != null) {
		
		String inPass = request.getParameter("inPass");
		Ad_QnABean bean = qMgr.getQnA(num);
		String oriPass = bean.getPass();

		MemberBean lobean = (MemberBean) session.getAttribute("loginBean");
		int level = lobean.getLevel();
		
		if (inPass.equals(oriPass)) {
			qMgr.deleteQnA(num, level);
			String url = "qnAlist.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
		} else {
%>
	<script>
		alert("입력하신 비밀번호가 아닙니다.");
		history.back();
	</script>
<%
		}
		
	} 
%>

</head>
<body>
	<div id="wrap">
	</div>
</body>
</html>