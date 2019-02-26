<%@page import="pack_Bean.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_JDBC.ProductMgr"%>
<%@page import="pack_Bean.Ad_QnABean"%>
<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qMgr" class="pack_JDBC.Ad_QnaMgr" scope="page"/> 
<%
request.setCharacterEncoding("UTF-8");

MemberBean lobean = (MemberBean) session.getAttribute("loginBean");
if(lobean == null){
	response.sendRedirect("../../member/login.jsp");
}

int num = Integer.parseInt(request.getParameter("num"));

String  nowPage = request.getParameter("nowPage");

Ad_QnABean bean = qMgr.getQnA(num);

String subject = bean.getSubject();
String id = bean.getId();
String productName = bean.getProductName();
String content = bean.getContent();
String oripass = bean.getPass();
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
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
			<a id="left" href="../../index.jsp" title="main">MAIN</a>
			</div>
			<h1 style="text-align:center; font-weight: bold; color: #2d2d2d;">Q&A</h1>
			</header>
			</div>
		</div>
		
			<div class="row">
				<div class="col">
				<div id="main" style="text-align:left;">
				<div class="table-responsive" style="background-color: white;">
		<form name="updateFrm" id="updateFrm">
			<table class="table table-condensed">
			<tr>
					<td class="fc">아이디</td>
					<td>
						<input type="text" name="id" readonly="readonly" value="<%=id%>">
					</td>
				</tr>
				<tr>
					<td class="fc">제목</td>
					<td><input size="98%" type="text" name="subject" value="<%=subject%>"></td>
				</tr>
				<tr>
					<td class="fc">상품이름</td>
					<td>
						<%
						ProductMgr pMgr = new ProductMgr();
						Vector<ProductBean> vlist = pMgr.getProductList();
						if(vlist!=null) {%>
						
						<select name="productName">
						<% for(int i=0; i<vlist.size(); i++){
						ProductBean pbean = vlist.get(i);
						String proName = pbean.getProductName();
						%>
						<option value="<%=proName%>" <% if(productName.equals(proName)){ %> selected="selected" <%}%>><%=proName %></option>
						<%} 
						}%>
						</select>			
					</td>
				</tr>
				<tr>
					<td class="fc">내용</td>
					<td>
						<textarea name="content" rows="12%" cols="100%" ><%=content%></textarea>
					</td>
				</tr>
				<tr>
					<td class="fc">비밀 번호</td>
					<td style="line-height : 1.6em">
					<input type="password" name="pass" maxlength="15" size="20%">
					<br>
					<span style="color : gray">
					글을 작성했을 때의 비밀번호를 입력해주세요
					</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input class="btn btn-secondary" type="button" value="수정완료" onclick="check()"> 
						<input class="btn btn-secondary" type="reset" value="다시쓰기"> 
						<input class="btn btn-secondary" type="button" value="돌아가기" onclick="history.back()">
					</td>
				</tr>
			</table>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="oripass" value="<%=oripass%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="num" value="<%=num%>">
		</form>
		</div>
		</div>
		</div>
		</div>
	</div>
	</div>
<script>
function check() {
	frm = document.updateFrm;
	if (frm.pass.vlaue == "") {
		alert("수정을 위해 패스워드를 입력해주세요");
		frm.pass.focus();
		return false;
	} else {
		frm.method="post";
		frm.action = "qnAUpdateProc.jsp";
		frm.submit();
	}
	
}
</script>
</body>
</html>