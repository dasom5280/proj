<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Purchase</title>

<%
request.setCharacterEncoding("utf-8");

MemberBean mbean = (MemberBean) session.getAttribute("adminBean");

if(mbean == null)
	response.sendRedirect("../../index.jsp");

else {
	String nums = request.getParameter("nums");
	StringTokenizer st = new StringTokenizer(nums, "/");
	BasketMgr basMgr = new BasketMgr();
	while(st.hasMoreTokens()){
		int basNum = Integer.parseInt(st.nextToken());
		basMgr.deliveryPurchase(basNum);
	}
}
%>

<script type="text/javascript">
	chk = confirm("배송처리 완료.\n배송페이지로 이동하겠습니까?");
	if(chk){
		location.href = "deliveryList.jsp";
	}
</script>
</head>
<body>
	<div id="wrap">
	
	</div>
</body>
</html>