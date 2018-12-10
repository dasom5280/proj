<%@page import="pack_Bean.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page"/>

<%
request.setCharacterEncoding("utf-8");


 String adminId = "admin";

 Vector<MemberBean> vlist = mMgr.getMemberList();
%>

<html lang="ko">
<head>
<meta charset="">
<title>Member Information</title>
<style> 

  table {
  border-collapse: collapse;
  }
  td {
  border: 1px solid gray;
  padding: 10px;
  }
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
     <td colspan="8">회원정보</td>
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
  <td>탈퇴처리</td>
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
     <td>
     <% if(!mid.equals(adminId)){ %>
     <input type="button" value="탈퇴" onclick="deleteProcess('<%=mid%>', '<%=mname%>')">
     <%} %>
     </td>
     <th colspan="8"></th>
    </tr>

   <%
        }
      }
  
   %>
      </table>
      <form name="delFrm" method="post">
      <input type="hidden" name="id" value="">
      </form>
    </div>
   
   </div>
   
   <script type="text/javascript">
	function deleteProcess(mid, mname){
		url = "member_check.jsp?mid="+mid+"&mname="+mname;
		window.open(url, "DelProcess",
				"width=500, height=300, scrollbars=yes top=200 left=600");
	
	}
   </script>
</body>
</html>