<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %> 

<jsp:useBean id="bMgr" class="pack_JDBC.PostMgr" scope="page"/>

<%
	  bMgr.downLoad(request, response,out,pageContext);
%>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title></title>
<style>
	div #wrap{
					width : 640;
					margin : 0 auto;
					}
</style>
</head>
<body>
	<div id="wrap">
		
	</div>
</body>
</html>