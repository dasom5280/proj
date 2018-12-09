<%@page import="pack_Bean.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_JDBC.ProductMgr"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
MemberBean lobean = (MemberBean) session.getAttribute("loginBean");
if(lobean == null){
	response.sendRedirect("../../member/login.jsp");
}
%>
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

		<form name="postFrm" method="post" action="qnAPostProc.jsp">
			<table>
				<tr>
					<td>
						<table>
						
							<tr>
								<td>제 목</td>
								<td><input type="text" name="subject" size="48"
									maxlength="30"></td>
							</tr>
							<tr>
								<td>상품이름</td>
								<td>
								<%
								ProductMgr pMgr = new ProductMgr();
								Vector<ProductBean> vlist = pMgr.getProductList();
								%>
								<% if(vlist!=null) {%>
								<select name="productName">
								<% for(int i=0; i<vlist.size(); i++){
									ProductBean pbean = vlist.get(i);
									String proName = pbean.getProductName();
								%>
								<option value="<%=proName%>"><%=proName %></option>
								<%} %>
								</select>
								<% } else { %>
								<input type="text" name="productName" size="48" maxlength="30">
								<%} %>
								</td>
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
								
								<td colspan="2">
								<input type="hidden" name="id" value="<%=lobean.getId()%>">
								<input type="submit" value="등록"> <input
									type="reset" value="다시쓰기"> <input type="button"
									value="상품문의 메인" onClick="javascript:location.href='qnAList.jsp'">
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