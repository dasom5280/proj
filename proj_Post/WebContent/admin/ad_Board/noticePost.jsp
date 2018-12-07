<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>Board post</title>
<link rel="stylesheet" href="../../css/ad_Board.css">
</head>
<body>
	<div id="wrap">

		<table>
			<tr>
				<td>글쓰기</td>
			</tr>
		</table>

		<form name="postFrm" method="post" action="noticePostProc.jsp"
			enctype="multipart/form-data">
			<table>
				<tr>
					<td>
						<table>
							<tr>
								<td>성 명</td>
								<td><input type="text" name="name" size="10" maxlength="8">
								</td>
							</tr>
							<tr>
								<td>제 목</td>
								<td><input type="text" name="subject" size="50"
									maxlength="30"></td>
							</tr>
							<tr>
								<td>내 용</td>
								<td><textarea name="content" rows="10" cols="50"></textarea></td>
							</tr>
							<tr>
								<td>비밀 번호</td>
								<td><input type="password" name="pass" size="15"
									maxlength="15"></td>
							<tr>
								<td colspan="2"><hr /></td>
							</tr>
							<tr>
								<td colspan="2"><input type="submit" value="등록"> <input
									type="reset" value="다시쓰기"> <input type="button"
									value="리스트" onClick="javascript:location.href='noticeList.jsp'">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
		</form>
	</div>

	</div>
</body>
</html>