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
 

	 Vector<MemberBean> vlist = mMgr.getMemberList();
%>

<html lang="ko">
<head>
<meta charset="">
<title>Member Information</title>
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
	 String mid = mbean.getId();
	 String mname = mbean.getName();
	 String mpass = mbean.getPass();
	 String memail = mbean.getPass();
	 String mbirthday = mbean.getBirthday();
	 String mzipcode = mbean.getZipcode();
	 String mphoneNum = mbean.getPhone1() + "-" + mbean.getPhone2() + "-" +mbean.getPhone3();

%>

    <tr>
     <td><%=mname %></td>
     <td><%=mid %></td>
     <td><%=mpass %></td>
     <td><%=memail %></td>
     <td><%=mbirthday %></td>
     <td><%=mzipcode %></td>
     <td><%=mphoneNum %></td>
     <th colspan="7"></th>
    </tr>

   <%
        }
      }
  
   %>
      </table>
    </div>
   
   </div>
</body>
</html>