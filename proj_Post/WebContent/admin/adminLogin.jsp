<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" href="css/style.css">

<script type="text/javascript">
 $("document").ready(function(){
	 $("#btnLogin").click(function(){
		 var adminId = $("#adminId").val();
		 var adminPw = $("#adminPw").val();
		 
		 if(adminId == ""){
			 alert("아이디를 입력하세요.");
			 $("#adminId").focus();
			 return;
		 }
		 
		 if (adminPw == "") {
			alert("비밀번호를 입력하세요.");
			$("#adminPw").focus();
			return;
		}
		 
		 document.form.action="loginProc.jsp"
		 document.form.submit();
	 });
 });
 
</script>

</head>
<body>
	<div id="wrap">
	
	<h2>관리자 로그인</h2>
	<form name="form" method="post">
	 <table>
	   
	   <tr>
	     <td>아이디</td>
	     <td><input name="adminId" id="id"></td>
	   </tr>
	   
	   <tr>
	     <td>비밀번호</td>
	     <td><input type="password" name="adminPw" id="pass"></td> 
	   </tr>
	   
	   <tr>
	     <td colspan="2" align="center">
	       <input type="button" value="로그인" onclick="location.href='loginProc.jsp'">
	       
	     
	     </td>
	   </tr>
	   
	 </table>
	</form>

	</div>
</body>
</html>