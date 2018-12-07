<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page" />
<%
	  qMgr.insertQnA(request);
	  response.sendRedirect("qnAlist.jsp");
%>