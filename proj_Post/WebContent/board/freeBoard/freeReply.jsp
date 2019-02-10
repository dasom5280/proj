<%@page import="pack_Bean.freeBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="bMgr" class="pack_JDBC.freeBoardMgr" scope="page"/>


<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>Board  Reply</title>
<link rel="stylesheet" href="../css/ad_Board.css">
<%
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	freeBoardBean bean = bMgr.getfreeBoard(num);
	if(bean == null){
		%>
		<script>
		history.back();
		</script>
	<%
	}
	String name = bean.getName();
	String subject = bean.getSubject();
	String content = bean.getContent();
%>
</head>
<body>
	<div id="wrap">

		<h1>답변하기</h1>
		<form id="replyFrm" name="post" method="post" action="freeReplyProc.jsp">
			<table id="replyInnerTbl">
				<tr>
					<td>성 명</td>
					<td><input type="text" name="name" size="30" maxlength="20" readonly="readonly" value="<%=name%>">
					</td>
				</tr>
				<tr>
					<td>제 목</td>
					<td>
						<input type="text" name="subject" size="50"
	 					 maxlength="50">
					</td>
				</tr>
				<tr>
					<td>내 용</td>
					<td> 
					[원본글내용입니다]<br>
					<%=content%><br>
					<textarea 	name="content"></textarea>
					</td>
				</tr>
				<tr>
					<td>비밀 번호</td>
					<td>
						<input type="password" name="pass" size="20" maxlength="15">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="rangeCenter">
						<input type="submit" value="답변등록"> 
						<input type="reset" value="다시쓰기"> 
						<input type="button" value="뒤로" onclick="history.back()">
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
</body>
</html>