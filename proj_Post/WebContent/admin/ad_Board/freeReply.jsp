<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.freeBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="pack_JDBC.freeBoardMgr" scope="page"/>
<%
	request.setCharacterEncoding("utf-8");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	freeBoardBean bean = bMgr.getfreeBoard(num);
	if(bean == null){
		response.sendRedirect("../adminMain.jsp");
	}
	String name = bean.getName();
	String subject = bean.getSubject();
	String content = bean.getContent();
	String id = null;
	MemberBean abean = null;
	abean = (MemberBean) session.getAttribute("adminBean");
	if(abean == null) {
		response.sendRedirect("../../index.jsp");
	} else {
		id 	= abean.getId();
	}
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
					<a id="left" href="../adminMain.jsp" title="adminmain">관리자 메인</a>
					</div>
					<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">자유게시판</h1>
					</header>
					</div>
				</div>
		
			<div class="row">
				<div class="col">
				<div id="main" style="text-align:left;">
				<div class="table-responsive" style="background-color: white;">
		<form id="replyFrm" name="post" method="post" action="freeReplyProc.jsp">
			<table class="table table-condensed">
					<tr>
					<td class="fc">아이디</td>
					<td>관리자</td>
				</tr>
				<tr>
					<td class="fc">제 목</td>
					<td>
						<input type="text" name="subject" size="83%"
	 					 maxlength="50">
					</td>
				</tr>
				<tr>
					<td class="fc">내 용</td>
					<td> 
					[원본글내용입니다]<br><br>
					<%=content%><br><br>
					<textarea 	name="content" cols="85%" rows="10%"></textarea>
					</td>
				</tr>
				<tr>
					<td class="fc">비밀 번호</td>
					<td>
						<input type="password" name="pass" size="20%" maxlength="15">
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input class="btn btn-secondary" type="submit" value="답변등록"> 
						<input class="btn btn-secondary" type="reset" value="다시쓰기"> 
						<input class="btn btn-secondary" type="button" value="뒤로" onclick="history.back()">
					</td>
				</tr>
			</table>
			<input type="hidden" name="name" value="관리자">
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="ref" value="<%=bean.getRef()%>"> 
			<input type="hidden" name="pos" value="<%=bean.getPos()%>"> 
			<input type="hidden" name="depth" value="<%=bean.getDepth()%>">
		</form>
		</div>
		</div>
		</div>
		</div>
	</div>
	</div>
</body>
</html>