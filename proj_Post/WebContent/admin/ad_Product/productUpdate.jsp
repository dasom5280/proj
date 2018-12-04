<%@page import="pack_Bean.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page" />
<%
	request.setCharacterEncoding("utf-8");

	int productNum = Integer.parseInt(request.getParameter("productNum"));
	
	ProductBean bean = pMgr.getProduct(productNum);
	
	if(bean != null){
		
		String productName= bean.getProductName();
		String productType = bean.getProductType();
		String explanation = bean.getExplanation();
		String price = bean.getPrice();
		String inventory = bean.getInventory();
	
 %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div id="wrap">

		<h1>
			<a href="productMain.jsp">상품관리로</a>
		</h1>
		<h1>상품추가</h1>
		<form name="updateFrm" method="post" action="productUpdateProc.jsp">
			<table>

				<tr>
					<td>상품이름</td>
					<td><input type="text" name="productName" value="<%= productName%>" size="10">
					</td>
				</tr>

				<tr>
					<td>상품종류</td>
					<td><input type="text" name="productType" value="<%= productType %>" size="10">
					</td>
				</tr>

				<tr>
					<td>설명</td>
					<td><input type="text" name="explanation" value="<%= explanation %>" size="50">
					</td>
				</tr>

				<tr>
					<td>가격</td>
					<td><input type="text" name="price" value="<%= price %>" size="10">
					</td>
				</tr>

				<tr>
					<td>재고</td>
					<td><input type="text" name="inventory" value="<%=inventory %>" size="10">
					</td>
				</tr>

				<tr>
					<td colspan="2"><input type="button" value="수정하기"
						onclick="updateCheck()"></td>
				</tr>
			</table>
			
			<input type="hidden" name="productNum" value="<%=productNum %>">
		</form>
		<%
	} else {
		response.sendRedirect("productMain.jsp");
	}
		%>
	</div>
	<script type="text/javascript">
		function updateCheck() {
			frm = document.updateFrm;

			if (frm.productName.value == "") {
				alert("상품이름을 입력해주세요");
				frm.productName.focus();
				return;
			}
			if (frm.productType.value == "") {
				alert("상품종류를 입력해주세요");
				frm.productType.focus();
				return;
			}
			if (frm.explanation.value == "") {
				alert("설명을 입력해주세요");
				frm.productName.focus();
				return;
			}
			if (frm.price.value == "") {
				alert("상품가격을 입력해주세요");
				frm.productName.focus();
				return;
			}
			if (frm.inventory.value == "") {
				alert("상품재고를 입력해주세요");
				frm.productName.focus();
				return;
			}

			frm.submit();
		}
	</script>
</body>
</html>