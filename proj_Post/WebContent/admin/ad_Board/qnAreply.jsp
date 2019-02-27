<%@page import="pack_Bean.Ad_QnABean"%>
<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page"/>
<%
	request.setCharacterEncoding("utf-8");
	
	MemberBean aBean = (MemberBean) session.getAttribute("adminBean");
	
	if(aBean==null){
		response.sendRedirect("../adminLogin.jsp");
	} else {
	
	int level = aBean.getLevel();
	int num = Integer.parseInt(request.getParameter("num"));
	
	Ad_QnABean qBean = qMgr.getQnA(num);
	
	String nowPage = request.getParameter("nowPage");
	
	String id = qBean.getId();
	String subject = qBean.getSubject();
	String content = qBean.getContent();
	int ref = qBean.getRef();
	int pos = qBean.getPos();
	int depth = qBean.getDepth();
	String productName = qBean.getProductName();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/boardStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
</head>
<body>
	<div id="wrap">
	<div class="container-fluid">
		
		<div class="row">
			<div class="col">
			<header>
			<div style="text-align:left;">
				<a id="aleft" href="../adminMain.jsp" title="adminMain">관리자 메인</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">Q&A관리</h1>
			</header>
			</div>
		</div>
		
		<div class="row">
			<div class="col">
			<div id="main" style="text-align:left;">
			<div class="table-responsive" style="background-color: white;">
		<form name="replyFrm" method="post" action="qnAreplyProc.jsp">
			<table class="table table-condensed">
				<tr>
					<td class="fc">제 목</td>
					<td><input type="text" name="subject" size="98%" value="답변 : <%=subject%>" maxlength="50"></td>
				</tr>
				
				<tr>
					<td class="fc" >고객 아이디</td>
					<td><%=id %></td>
				</tr>
				
				<tr>
					<td class="fc">상품 이름</td>
					<td><%=productName %></td>
				</tr>

				<tr>
					<td class="fc">원글 내용</td>
					<td><textarea rows="5%" cols="100%" name="origcontent" readonly="readonly"><%=content %></textarea></td>
				</tr>
				<tr>
					<td class="fc">답글 내용</td>
					<td><textarea rows="10%" cols="100%" autofocus="autofocus"  name="repcontent" rows="12" cols="50"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
					<input class="btn btn-secondary" type="button" value="답변등록" onclick="replyProcess()">
					<input class="btn btn-secondary" type="reset" value="다시쓰기">
					<input class="btn btn-secondary" type="button" value="뒤로" onclick="history.back()">
					</td>
				</tr>

			</table>
					<input type="hidden" name="num" value="<%=num %>">
					<input type="hidden" name="productName" value="<%=productName%>">
					<input type="hidden" name="id" value="<%=aBean.getId() %>">
					<input type="hidden" name="content" value="">
					<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
					<input type="hidden" name="nowPage" value="<%=nowPage%>">
					<input type="hidden" name="ref" value="<%=ref%>">
					<input type="hidden" name="pos" value="<%=pos%>">
					<input type="hidden" name="depth" value="<%=depth%>">
			
		</form>
		
		<%}
	%>
	</div>
	</div>
	</div>
	</div>
</div>
</div>
	
	<script type="text/javascript">
	function replyProcess(){
		var ori = document.replyFrm.origcontent.value;
		var rep = document.replyFrm.repcontent.value;
		var con = "원글 : " + ori + "\n\n답글 : " +rep;
		
		document.replyFrm.content.value = con;
		document.replyFrm.submit();
	}
	
	</script>
</body>
</html>