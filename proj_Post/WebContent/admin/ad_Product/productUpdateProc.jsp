<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page" />
<jsp:useBean id="upBean" class="pack_Bean.ProductBean" scope="page" />
<jsp:setProperty property="*" name="upBean" />

<%
	boolean chk = pMgr.updateProduct(upBean);
	String msg = "실패";
	if (chk) {
		msg = "성공";
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">

	alert("<%=msg%>");
	location.href = "productList.jsp";
</script>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>