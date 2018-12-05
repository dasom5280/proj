<%@page import="java.sql.Connection"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
        <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="">
<title>회원리스트</title>
  <%
    String id = (String)session.getAttribute("id");
    String name;
    int level;
    
    Connection conn = pool.getConnection();
    String  sql = "select * from member where id = ?";
  %>
  
<link type="text/css" rel="stylesheet" href="">

<style> 
  div#wrap {width : 640px; margin : 0 auto;}
</style>

</head>
<body>
   <div id="wrap">
   </div>
</body>
</html>