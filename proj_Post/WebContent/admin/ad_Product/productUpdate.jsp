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
		String filename = bean.getFilename();
		int sale = bean.getSale();
		int percent = bean.getSalePercent();
	
 %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/prolistStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<style type="text/css">
table {
text-align: left;
}
.fc{
background: #f7f7f7;
text-align: center;
}
</style>
</head>
<body>
	<div id="wrap">
	
		<div class="container-fluid">
		
		<div class="row">
			<div class="col">
			<header>
			<div style="text-align:left;">
				<a id="aleft" href="productList.jsp" title="proMain">상품 관리</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">상품 수정</h1>
			<br><br>
			</header>
			</div>
			</div>

	<div class="row">
		<div class="col">
		<div id="main" style="text-align:left;">
		<div class="table-responsive" style="background-color: white;">
		<form name="updateFrm" method="post" action="productUpdateProc.jsp" >
		<table class="table table-condensed">
				<tr>
					<td class="fc" >상품이름</td>
					<td><input type="text" name="productName" value="<%= productName%>" size="10%">
					</td>
				</tr>

				<tr>
					<td class="fc" >상품종류</td>
					<td>
					<select name="productType">
						<option value="outer" <%if(productType.equals("outer")){ %> selected="selected"<%} %>>outer</option>
						<option value="top" <% if(productType.equals("top")){ %> selected="selected"<%} %>>top</option>
						<option value="bottom" <% if(productType.equals("bottom")){ %> selected="selected"<%} %>>bottom</option>
						</select>
					</td>
				</tr>
		
				<tr>
					<td class="fc" >설명</td>
					<td><input type="text" name="explanation" value="<%= explanation %>" size="80%">
					</td>
				</tr>
				
				<!-- 사진 수정하는 법 나중에 공부해서 추가하기 -->

				<tr>
					<td class="fc">가격</td>
					<td><input type="text" name="price" value="<%= price %>" size="10%">
					</td>
				</tr>

				<tr>
					<td class="fc">재고</td>
					<td><input type="text" name="inventory" value="<%=inventory %>" size="10%">
					</td>
				</tr>

			<tr>
			<td class="fc">세일</td>
			<td>
			세일진행
			<input id="sale" type="checkbox" name="sale" value="1" <%if (sale==1) {%> checked="checked" <%} %>>
			&nbsp;&nbsp;
			<% if (sale==1) {%>
			<span id='percent'>퍼센트 <input type='text' name='salePercent' value='<%=percent%>' size='5%'> %</span>
			<% } else { %>
			<input id="percent" type="hidden" name="salePercent" value="<%=percent%>">
			<%} %>
			</td>
			</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
					<input class="btn btn-secondary" type="button" value="수정하기"
						onclick="updateCheck()"></td>
				</tr>
			</table>
			<input type="hidden" name="productNum" value="<%=request.getParameter("productNum") %>">
		</form>
		</div>
		</div>
		</div>
		</div>
</div>
</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
	<!-- 세일 진행 누르면 퍼센트가 나타나는 제이쿼리 구문 추가 -->
	<script>
      $(function() { 
            $( "#sale" ).click(function( event ) { 
            	if($('input:checkbox[name="sale"]').is(":checked")){
            	$("#percent").replaceWith("<span id='percent'>퍼센트 <input type='text' name='salePercent' value='<%=percent%>' size='5%'> %</span>");
            	} else { 
            		$("#percent").replaceWith("<input id='percent' type='hidden' name='salePercent' value=''>");
            	}            
            }); 
        });
    </script>
    <%
	} else {
		response.sendRedirect("productList.jsp");
	}
		%>
</body>
</html>