<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
        <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page"/>

<%
 request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");
String pass=(String)session.getAttribute("pass");


Vector<MemberBean> vlist = mMgr.getMemberList();
 %>
 
<html lang="ko">
<head>
<meta charset="">
<title>회원리스트</title>

<link type="text/css" rel="stylesheet" href="">

<style> 
  div#wrap {width : 640px; margin : 0 auto;}
</style>
</head>
<body>
   <div id="wrap">
   
   <table>
     <tr>
       <td colspan="2">회원정보</td>
     </tr>

     <%
         if(vlist.isEmpty()){
     %>

     <tr>
        <td colspan="2">회원정보가 없습니다.</td>
     </tr>

     <%
      }else{
     %>
     
     <tr>
 <!-- <td>이름</td> -->
        <td colspan="1">아이디</td>
        <td colspan="1">비밀번호</td>
        <th colspan="2"></th>
     </tr>

     <%
     for(int i=0; i<vlist.size(); i++){
    	 MemberBean mbean = vlist.get(i);
    	 String mid = mbean.getId();
    	 String mname = mbean.getName();
  
     %>

     <tr>
      <td><%=mname %></td>
      <td><%=mid %></td>
     </tr>

     <%
       }
     }
     %>
  </table>
      
   
   </div>
</body>
</html>