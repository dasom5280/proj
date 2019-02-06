<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Product Add</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<div id="wrap">

		<h1><a href="productList.jsp">상품관리로</a></h1>
		<h1>상품추가</h1>
		<form name="addFrm" method="post" action="productAddProc.jsp" enctype="multipart/form-data">
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
		<select name="productType">
		<option value="outer">outer</option>
		<option value="top">top</option>
		<option value="bottom">bottom</option>
		</select>
		</td>
		</tr>
		
		<tr>
		<td>상품사진</td>
		<td>
		<input type="file" name="filename" size="50" maxlength="50"></td>
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
		<td>세일</td>
		<td>
		세일진행<input id="sale" type="checkbox" name="sale" value="1">
		&nbsp;&nbsp;<input id="percent" type="hidden" name="salePercent" value="">
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
		
		if(frm.filename.value==""){
			alert("상품사진을 넣어주세요");
			frm.filename.focus();
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
<!-- 세일 진행 누르면 퍼센트가 나타나는 제이쿼리 구문 추가 -->
	<script>
      $(function() { 
            $( "#sale" ).click(function( event ) { 
            	if($('input:checkbox[name="sale"]').is(":checked")){
            	$("#percent").replaceWith("<span id='percent'>퍼센트 <input type='text' name='salePercent' value='' size='2'> %</span>");
            	} else { 
            		$("#percent").replaceWith("<input id='percent' type='hidden' name='salePercent' value=''>");
            	}            
            }); 
        });
    </script>
</body>
</html>