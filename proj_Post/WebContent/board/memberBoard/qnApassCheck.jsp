<%@page import="pack_Bean.Ad_QnABean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호</title>
</head>
<body>
	<div id="wrap">
	<form name="deleteFrm">
	<table>
				<tr>
					<td>
					비밀번호 입력 
					<input type="password" name="inPass" value="">
					</td>
				</tr>
				<tr>
					<td>
					<input type="button" value="완료" onclick="delCheck()">
					&nbsp;&nbsp;
					<input type="button" value="닫기" onclick="self.close()">
					</td>
				</tr>
	</table>
	</form>
	</div>
	<script type="text/javascript">
	function  delCheck(){
		var inPass = document.deleteFrm.inPass.value;

		if(inPass=""){
			alert("비밀번호를 입력해주세요");
			document.deleteFrm.inPass.focus();
			return;
		}
		
		opener.document.delFrm.inPass.value = document.deleteFrm.inPass.value;
		opener.document.delFrm.action="qnADelete.jsp";
		opener.document.delFrm.submit();
		self.close();
	}
	</script>
</body>
</html>