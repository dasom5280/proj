<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="pack_JDBC.PostMgr" scope="page" />
<%
	  bMgr.insertPost(request);
	  response.sendRedirect("list.jsp");
%>