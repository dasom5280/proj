<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
MemberBean bean = (MemberBean)session.getAttribute("adminBean");

if(bean!=null){
	response.sendRedirect("adminMain.jsp");
}
%>    
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<style type="text/css">
.fc {
text-align: center;
background: #f8f9fa;
}
</style>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../css/memberStyle.css">
</head>
<body>
	<div id="wrap">
	
	<div class="container-fluid">
	
			<div class="row">
			<div class="col">
			<header>
			<div style="text-align:left;">
			<a id="left" style="color: black; font-weight: 100; font-size: 1.1em;"href="../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">관리자 로그인</h1>
			</header>
			</div>
		</div>
		
	<div class="row">
		<div class="col">
		<div id="main" style="text-align:left;">
		<div class="table-responsive">
	<form name="adminFrm" method="post">
	 <table class="table">
	   
	   <tr>
	     <td class="fc" style="width:30%;">아이디</td>
	     <td><input type="text" name="adminId" id="id" maxlength="15" size="20"></td>
			<td rowspan="2" style="background-color: #f8f9fa; width: 40%; vertical-align: middle;">
			<input class="btn btn-light btn-block btn-lg" type="button" value="로그인" onclick="adminCheck()"></td>
	   </tr>
	   
	   <tr>
	     <td class="fc" style="width:30%;">비밀번호</td>
	     <td><input type="password" name="adminPw" id="pass"
	     maxlength="20" size="20"></td> 
	   </tr>
	   
	 </table>
	 <input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">
	</form>
	</div>
	</div>
	</div>
	</div>
	
	</div>
	</div>
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
</body>
</html>