<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = (String)session.getAttribute("id");

if(id!=null){
	response.sendRedirect("adminMain.jsp");
}
%>    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="css/style.css">

<script type="text/javascript">

function adminCheck(){
	var adminId = document.adminFrm.adminId.value;
	var adminPw = document.adminFrm.adminPw.value;
	
	 if(adminId == ""){
		 alert("아이디를 입력하세요.");
		 document.adminFrm.adminId.focus();
		 return;
	 }
	 
	 if (adminPw == "") {
		alert("비밀번호를 입력하세요.");
		document.adminFrm.adminPw.focus();
		return;
	} 
	 
	 document.adminFrm.action="loginProc.jsp"
	 document.adminFrm.submit();
}

</script>

</head>
<body>
	<div id="wrap">
	
	<h2>관리자 로그인</h2>
	<form name="adminFrm" method="post">
	 <table>
	   
	   <tr>
	     <td>아이디</td>
	     <td><input type="text" name="adminId" id="id"></td>
	   </tr>
	   
	   <tr>
	     <td>비밀번호</td>
	     <td><input type="password" name="adminPw" id="pass"></td> 
	   </tr>
	   
	   <tr>
	     <td colspan="2" align="center">
	       <input type="button" value="로그인" onclick="adminCheck()">
	      
	     </td>
	   </tr>
	   
	 </table>
	 <input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">
	</form>

	</div>
</body>
</html>