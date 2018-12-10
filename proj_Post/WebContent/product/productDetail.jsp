<%@page import="pack_Bean.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page"/>
<% 
request.setCharacterEncoding("utf-8");
int productNum = Integer.parseInt(request.getParameter("productNum")); 
ProductBean pbean = pMgr.getProduct(productNum);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<style>
	div#wrap {width: 640px; margin: 0 auto;}
</style>
</head>
<body>
	<div id="wrap">
	<h1><%=pbean.getProductNum() %></h1>
	<h1><%=pbean.getProductType() %></h1>
	<h1><%=pbean.getProductName() %></h1>
	</div>
</body>
</html>