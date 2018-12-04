<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page" />
<%
	request.setCharacterEncoding("utf-8");

	int productNum = Integer.parseInt(request.getParameter("productNum"));
	
	boolean chk = pMgr.deleteProduct(productNum);
	
	if(chk){
		
		
	}
	
 %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	location.href = "productMain.jsp";
</script>
</head>
<body>
	<div id="wrap">
	
	</div>
</body>
</html>