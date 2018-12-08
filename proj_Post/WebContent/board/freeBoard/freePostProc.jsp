<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="pack_JDBC.freeBoardMgr" scope="page" />
<%
	request.setCharacterEncoding("UTF-8");

	bMgr.insertfreeBoard(request);
	
	response.sendRedirect("freeList.jsp");
	
%>