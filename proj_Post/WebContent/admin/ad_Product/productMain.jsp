<%@page import="java.util.Vector"%>
<%@page import="pack_Bean.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Product Main</title>
<style type="text/css">
table {
	border-collapse: collapse;
}

table td {
	border: 1px solid gray;
	padding: 10px;
}
</style>
</head>
<body>
	<div id="wrap">
		<!-- 관리자 메인 링크 수정 필요 -->
		<h1><a href="../adminMain.jsp">관리자 메인으로</a></h1>
		<h1>상품관리</h1>
		<table>
			<tr>
				<td colspan="8">상품</td>
			</tr>
			<tr>
				<td>상품번호</td>
				<td>상품이름</td>
				<td>상품종류</td>
				<td style="width: 20%;">설명</td>
				<td>가격</td>
				<td>재고</td>
				<td colspan="2"></td>

				<%
					Vector<ProductBean> vlist = pMgr.getProductList();
					if (vlist != null) {

						for (int i = 0; i<vlist.size(); i++) {
							ProductBean bean = vlist.get(i);
				%>
			
			<tr>
				<td><%=bean.getProductNum()%></td>
				<td><%=bean.getProductName()%></td>
				<td><%=bean.getProductType()%></td>
				<td><%=bean.getExplanation()%></td>
				<td><%=bean.getPrice()%></td>
				<td><%=bean.getInventory()%></td>
				<td>
				<input type="button" value="상품 수정" onclick="location.href='productUpdate.jsp?productNum=<%=bean.getProductNum()%>'">
				</td>
				<td>
				<input type="button" value="상품 삭제" onclick="location.href='productDelete.jsp?productNum=<%=bean.getProductNum()%>'">
				</td>
			</tr>
			<%
				}

				}
			%>
		</table>
		<br><br>
		<form>
			<input type="button" value="상품 추가" onclick="location.href='productAdd.jsp'">
		</form>
	</div>
</body>
</html>