<%@page import="pack_Bean.freeBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<jsp:useBean id="bMgr" class="pack_JDBC.freeBoardMgr" scope="page"/>
<%@page import="pack_Bean.MemberBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean memberbean = (MemberBean) request.getAttribute("adminBean");

	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
		
			bMgr.deletefreeBoard(num);
			String url = "../../board/freeBoard/freeList.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);

%>

<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div id="wrap">
	
	</div>
</body>
</html>