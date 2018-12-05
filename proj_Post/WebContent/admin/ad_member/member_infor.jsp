<%@page import="pack_Bean.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page"/>
<jsp:useBean id="bean" class="pack_Bean.MemberBean" scope="page"/>

<%
 request.setCharacterEncoding("utf-8");


 String id=(String)session.getAttribute("id");
 String pass=(String)session.getAttribute("pass");
 
 if(id != null){
	 Vector<MemberBean> vlist = bean.getMember(id,pass);
%>

<html lang="ko">
<head>
<meta charset="">
<title>회원정보</title>
<style> 
  div#wrap {width : 640px; margin : 0 auto;}
</style>

<link type="text/css" rel="stylesheet" href="">

</head>

<body>
   <div id="wrap">
      <header>
      <h2>회원정보관리</h2>
   
      </header>
  
  <div id="main">
   <table>
    <tr>
     <td colspan="2">회원정보</td>
    </tr>
    
   <%
    if(vlist.isEmpty()){
   %>

   <tr>
    <td>회원정보가 없습니다.</td>
   </tr>

   <%
    }else{
   %>
  
  <tr>
  <td>이름</td>
  <td>아이디</td>
  <td>비밀번호</td>
  <td>이메일</td>
  <td>생일</td>
  <td>주소</td>
  <td>핸드폰 번호</td>
 </tr>

<%
 for(int i=0; i<vlist.size(); i++){
	 MemberBean mbean = vlist.get(i);
	 String id = mbean.getId();
%>

    <tr>
     <td><%=name %></td>
     <td><%=id %></td>
     <td><%=pass %></td>
     <td><%=email %></td>
     <td><%=birthday %></td>
     <td><%=zipcode %></td>
     <td><%=phoneNum %></td>
     <th colspan="7"></th>
    </tr>

   <%
        }
      }
  }
   %>
      </table>
    </div>
   
   </div>
</body>
</html>