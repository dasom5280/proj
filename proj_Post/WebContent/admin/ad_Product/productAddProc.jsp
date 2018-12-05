<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="pMgr" class="pack_JDBC.ProductMgr" scope="page" />
<jsp:useBean id="bean" class="pack_Bean.ProductBean" scope="page" />
<jsp:setProperty name="bean" property="*" />

<%
	boolean chk = pMgr.insertProduct(bean);
	String msg = "실패";
	String url = "productAdd.jsp";
	if (chk) {
		msg = "성공";
		url = "productMain.jsp";
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<script type="text/javascript">
alert("<%=msg%>");
location.href="<%=url%>";
</script>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>