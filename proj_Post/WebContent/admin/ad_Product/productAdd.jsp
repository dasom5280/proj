<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div id="wrap">

		<h1><a href="productMain.jsp">상품관리로</a></h1>
		<h1>상품추가</h1>
		<form name="addFrm" method="post" action="productAddProc.jsp">
		<table>
		
		<tr>
		<td>상품이름</td>
		<td>
		<input type="text" name="productName" value="" size="10">
		</td>
		</tr>
		
		<tr>
		<td>상품종류</td>
		<td>
		<input type="text" name="productType" value="" size="10">
		</td>
		</tr>
		
		<tr>
		<td>설명</td>
		<td>
		<input type="text" name="explanation" value="" size="50">
		</td>
		</tr>
		
		<tr>
		<td>가격</td>
		<td>
		<input type="text" name="price" value="" size="10">
		</td>
		</tr>
		
		<tr>
		<td>재고</td>
		<td>
		<input type="text" name="inventory" value="" size="10">
		</td>
		</tr>
		
		<tr>
		<td colspan="2">
		<input type="button" value="상품추가하기" onclick="addCheck()">
		</td>
		</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
	function addCheck(){
		frm = document.addFrm;
		
		if(frm.productName.value==""){
			alert("상품이름을 입력해주세요");
			frm.productName.focus();
			return;
		}
		if(frm.productType.value==""){
			alert("상품종류를 입력해주세요");
			frm.productType.focus();
			return;
		}
		if(frm.explanation.value==""){
			alert("설명을 입력해주세요");
			frm.productName.focus();
			return;
		}
		if(frm.price.value==""){
			alert("상품가격을 입력해주세요");
			frm.productName.focus();
			return;
		}
		if(frm.inventory.value==""){
			alert("상품재고를 입력해주세요");
			frm.productName.focus();
			return;
		}
		
		frm.submit();
	}
	</script>
</body>
</html>