<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="basketMgr" class="pack_JDBC.BasketMgr" scope="page"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<%
	request.setCharacterEncoding("utf-8");
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	boolean flag = false;
	flag = basketMgr.insertBasket(request);

	if (flag) {
%>
<script type="text/javascript">
	bchk = confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?");
	if(bchk){
		location.href="../memberPage/basketPage.jsp";
	} else {
		history.back();
	}
</script>

<% } else {%>
<script type="text/javascript">
alert("오류가 발생하였습니다.\n다시 시도해주세요.");
history.back();
</script>
<% } %>
</head>
<body>
	<div id="wrap">
	
	</div>
</body>
</html>