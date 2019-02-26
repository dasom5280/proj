<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<jsp:useBean id="bMgr" class="pack_JDBC.BoardMgr" scope="page"/>
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
String  nowPage = request.getParameter("nowPage");

MemberBean abean = (MemberBean) session.getAttribute("adminBean");

if(abean==null){
	response.sendRedirect("../adminMain.jsp");
}

BoardBean bean = bMgr.getBoard(num);

String subject = bean.getSubject();
String name = bean.getName();
String content = bean.getContent();
String oripass = bean.getPass();
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/boardStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
</head>
<body>
	<div id="wrap">
	<div class="container-fluid">
		
		<div class="row">
			<div class="col">
			<header>
			<div style="text-align:left;">
				<a id="aleft" href="../adminMain.jsp" title="adminMain">관리자 메인</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">공지사항</h1>
			</header>
			</div>
		</div>
		
		<div class="row">
				<div class="col">
				<div id="main" style="text-align:left;">
				<div class="table-responsive" style="background-color: white;">
		<form name="updateFrm" id="updateFrm">
				<table class="table table-condensed">
				<tr>
					<td class="fc">제목</td>
					<td><input size="83%" type="text" name="subject" value="<%=subject%>"></td>
				</tr>
				<tr>
					<td class="fc">아이디</td>
					<td>
						<input type="text" name="name" value="관리자">
					</td>
				</tr>
				
				<tr>
					<td class="fc">내용</td>
					<td>
						<textarea name="content" rows="12%" cols="85%" ><%=content%></textarea>
					</td>
				</tr>
				<tr>
					<td class="fc">비밀 번호</td>
					<td style="line-height : 1.6em">
					<input type="password" name="pass" maxlength="15" size="20%">
					<br>
					<span style="color : gray">
					글을 작성했을 때의 비밀번호를 입력해주세요
					</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="hidden" name="oripass" value="<%= oripass %>">
						<input class="btn btn-secondary" type="button" value="수정완료" onclick="check()"> 
						<input class="btn btn-secondary" type="reset" value="다시쓰기"> 
						<input class="btn btn-secondary" type="button" value="돌아가기" onclick="history.back()">
					</td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="num" value="<%=num%>">
		</form>
		</div>
		</div>
		</div>
	</div>
<script>
function check() {
	frm = document.updateFrm;
	if (frm.pass.vlaue == "") {
		alert("수정을 위해 패스워드를 입력해주세요");
		frm.pass.focus();
		return false;
	} else {
		frm.method="post";
		frm.action = "noticeUpdateProc.jsp";
		frm.submit();
	}
	
}
</script>
</body>
</html>