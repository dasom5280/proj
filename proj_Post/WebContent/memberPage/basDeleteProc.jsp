<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<%
request.setCharacterEncoding("utf-8");

MemberBean mbean = (MemberBean) session.getAttribute("loginBean");

if(mbean == null)
	response.sendRedirect("../member/login.jsp");

else {
	String nums = request.getParameter("nums");
	StringTokenizer st = new StringTokenizer(nums, "/");
	BasketMgr basMgr = new BasketMgr();
	while(st.hasMoreTokens()){
		int basNum = Integer.parseInt(st.nextToken());
		basMgr.deleteBasket(basNum);
	}
}
%>

<script type="text/javascript">
	alert("삭제 완료");
	location.href = "basketPage.jsp";
</script>

</head>
<body>
	<div id="wrap">
	
	</div>
</body>
</html>