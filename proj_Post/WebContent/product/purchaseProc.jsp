<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 request.setCharacterEncoding("utf-8");
 MemberBean mbean = (MemberBean) session.getAttribute("loginBean");
 	String mid = null;
	String nums = null;
	int numSize = 1;
	boolean flag = false;
	String msg = "실패";
	BasketMgr basMgr = new BasketMgr();
	
	if (mbean == null)
		response.sendRedirect("../member/login.jsp");

	else {
		mid = mbean.getId();
		
		if(mid==null||!mid.equals(request.getParameter("id"))){
			response.sendRedirect("../member/logout.jsp");
		}
		
		if (request.getParameter("nums") != null && !request.getParameter("nums").equals("null")) {
			nums = request.getParameter("nums");
			StringTokenizer st = new StringTokenizer(nums, "/");
			
			while (st.hasMoreTokens()) {
				int basNum = Integer.parseInt(st.nextToken());
				flag = basMgr.purchaseBasket(request, basNum);
			}
		} else {
			flag = basMgr.directPurchase(request);
		}
		
		if(flag)
			msg = "성공";
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Purchase</title>
<script type="text/javascript">
alert("<%=msg %>");
location.href="../memberPage/myPage.jsp";
</script>
</head>
<body>
	<div id="wrap">
	
	</div>
</body>
</html>