<%@ page language="java" contentType="application; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="bMgr" class="pack_JDBC.BoardMgr" scope="page"/>
<%
	  bMgr.downLoad(request, response,out,pageContext);
%>
    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>Board download</title>
<style>
	div#wrap {  width : 640px;  margin : 0 auto; }	
</style>
</head>
<body>
	<div id="wrap">
		

	</div>
</body>
</html>