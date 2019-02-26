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
<title>SHOPNAME</title>
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
			<a id="left" href="../../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">Q&A</h1>
			</header>
			</div>
		</div>
		
		<div class="row">
				<div class="col">
				<div id="main" style="text-align:left;">
				<div class="table-responsive" style="background-color: white;">
		<form name="postFrm" method="post" action="qnAPostProc.jsp">
			<table class="table table-condensed">
							<tr>
								<td class="fc">제 목</td>
								<td><input type="text" name="subject" size="98%"
									maxlength="30"></td>
							</tr>
							<tr>
								<td class="fc">상품이름</td>
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
								<td class="fc">내 용</td>
								<td><textarea name="content" rows="12%" cols="100%"></textarea></td>
							</tr>
							<tr>
								<td class="fc">비밀 번호</td>
								<td><input type="password" name="pass" size="20%"
									maxlength="15"></td>
							</tr>
							<tr>
								
								<td colspan="2" style="text-align: center;">
								<input  class="btn btn-secondary" type="submit" value="등록">
								<input  class="btn btn-secondary" 
									type="reset" value="다시쓰기">
								<input  class="btn btn-secondary"  type="button"
									value="목록" onClick="javascript:location.href='qnAlist.jsp'">
								</td>
							</tr>
						</table>
			<input type="hidden" name="id" value="<%=lobean.getId()%>">
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
		</form>
	</div>
	</div>
	</div>
	</div>

	</div>
	</div>
</body>
</html>