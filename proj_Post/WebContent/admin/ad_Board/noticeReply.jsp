<%@page import="pack_Bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="pack_JDBC.BoardMgr" scope="page"/>
<%
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardBean bean = bMgr.getBoard(num);
	if(bean == null){
		response.sendRedirect("../adminMain.jsp");
	}
	String subject = bean.getSubject();
	String content = bean.getContent();
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
		<form id="replyFrm" name="post" method="post" action="noticeReplyProc.jsp">
			<table class="table table-condensed">
				<tr>
						<td class="fc">제 목</td>
						<td>
							<input type="text" name="subject" size="98%"
		 					 maxlength="50">
						</td>
				</tr>
				<tr>
					<td class="fc">아이디</td>
					<td><input type="text" name="name" size="25%" maxlength="20" readonly="readonly" value="관리자">
					</td>
				</tr>
				<tr>
					<td class="fc">내 용</td>
					<td> 
					[원본글내용입니다]<br><br>
					<%=content%><br><br>
					<textarea 	name="content" cols="100%" rows="15%"></textarea>
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
						<input  class="btn btn-secondary"  type="submit" value="답변등록"> 
						<input  class="btn btn-secondary"  type="reset" value="다시쓰기"> 
						<input  class="btn btn-secondary"  type="button" value="뒤로" onclick="history.back()">
					</td>
				</tr>
			</table>
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