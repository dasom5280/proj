<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>Board Delete</title>
<link rel="stylesheet" href="../../css/ad_Board.css">

<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page"/>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	
	boolean chk = false;
	
	if(id!=null){
		chk = mMgr.deleteMember(id);
		if(!chk){
%>
	<script>
		alert("탈퇴 실패");
		history.back();
	</script>
<%
		} else {
			response.sendRedirect("member_infor.jsp");
		}
		
	} 
%>

</head>
<body>
	<div id="wrap">
	</div>
</body>
</html>