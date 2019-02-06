<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
MemberBean abean = (MemberBean) session.getAttribute("loginBean");

String id = abean.getId();

	if(abean==null){
		response.sendRedirect("freeList.jsp");
	}
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>freeBoard post</title>
<link rel="stylesheet" href="../css/ad_freeBoard.css">
</head>
<body>
	<div id="wrap">

		<table>
			<tr>
				<td>글쓰기</td>
			</tr>
		</table>

		<form name="postFrm" method="post" action="freePostProc.jsp">
			<table>
				<tr>
					<td>
						<table>
							<tr>
								<td>성 명</td>
								<td><input type="text" name="name" size="10" maxlength="8" readonly="readonly" value="<%=id%>">
								</td>
							</tr>
							<tr>
								<td>제 목</td>
								<td><input type="text" name="subject" size="50"
									maxlength="30" value=""></td>
							</tr>
							<tr>
								<td>내 용</td>
								<td><textarea name="content" rows="10" cols="50" ></textarea></td>
							</tr>
							<tr>
								<td>비밀 번호</td>
								<td><input type="password" name="pass" size="15"
									maxlength="15" value=""></td>
							<tr>
								<td colspan="2"><hr /></td>
							</tr>
							<tr>
								
								<td colspan="2">
								
								<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
								<input type="submit" value="등록">
								<input type="reset" value="다시쓰기">
								<input type="button" value="리스트" onClick="javascript:location.href='freeList.jsp'">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>