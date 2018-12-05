<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="pack_JDBC.Ad_BoardMgr" scope="page" />
<%
	  mMgr.insertBoard(request);
	  response.sendRedirect("ad_Notice.jsp");
%>