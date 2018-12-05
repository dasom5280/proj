<%@page import="pack_Bean.Ad_BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));

String  nowPage = request.getParameter("nowPage");

Ad_BoardBean bean = (Ad_BoardBean)session.getAttribute("bean");
String subject = bean.getSubject();
String name = bean.getName();
String content = bean.getContent();
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>JSP Board</title>
<link rel="stylesheet" href="css/style.css">
<script>
function check() {
	frm = document.updateFrm;
	if (frm.pass.vlaue == "") {
		alert("수정을 위해 패스워드를 입력해주세요");
		frm.pass.focus();
		return false;
	} else {
		frm.method="post";
		frm.action = "ad_updateProc.jsp";
		frm.submit();
	}
	
}

</script>
</head>
<body>
	<div id="wrap">
		<h1>게시물 수정</h1>
		<form name="updateFrm" id="updateFrm">
			<table id="updateInnerTbl">
				<tr>
					<td class="itemSet">성명</td>
					<td>
						<input type="text" name="name" value="<%=name%>">
					</td>
				</tr>
				<tr>
					<td class="itemSet">제목</td>
					<td><input size="50" type="text" name="subject" value="<%=subject%>"></td>
				</tr>
				<tr>
					<td class="itemSet">내용</td>
					<td>
						<textarea name="content"><%=content%></textarea>
					</td>
				</tr>
				<tr>
					<td class="itemSet">비밀 번호</td>
					<td style="line-height : 1.6em">
					<input type="password" name="pass" maxlength="15">
					<br>
					<span style="color : gray">
					글을 작성했을 때의 비밀번호를 입력해주세요
					</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="rangeCenter">
						<input type="button" value="수정완료" onclick="check()"> 
						<input type="reset" value="다시쓰기"> 
						<input type="button" value="취소하고 돌아가기" onclick="history.back()">
					</td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="num" value="<%=num%>">
		</form>
		

	</div>
</body>
</html>