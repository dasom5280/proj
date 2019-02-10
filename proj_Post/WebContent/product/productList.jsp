<!-- 나중에 페이징 처리도 추가하자 -->
<%@page import="pack_Bean.MemberBean"%>
<%@page import="pack_Bean.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_JDBC.ProductMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
		request.setCharacterEncoding("utf-8");
		String mainProtype = request.getParameter("productType");
		MemberBean bean = (MemberBean) session.getAttribute("loginBean");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="../css/mainStyle.css">
<style type="text/css">
table.galleryImg1 tr td.galleryImg2 {
	width: 120px; /*   48px에서 수정됨*/
	height: 150px;
}

table.galleryImg1 {
	margin: 10px;
	border: 1px solid gray;
}
</style>
</head>
<body>
<div id="wrap">

<header class="top">
	<img id="headerLogo" src="../images/headerLogo.png" alt="로고">
</header>

<nav>
			<ul>
				<li <%if(mainProtype.equals("outer")) {%> id="selected" <%} %>><a href="productList.jsp?productType=outer" title="Outer">Outer</a></li>
				<li <%if(mainProtype.equals("top")) {%> id="selected" <%} %>><a href="productList.jsp?productType=top" title="Top">Top</a></li>
				<li <%if(mainProtype.equals("bottom")) {%> id="selected" <%} %>><a href="productList.jsp?productType=bottom" title="Bottom">Bottom</a></li>
				&nbsp;<li>||</li>&nbsp;
				<li><a href="../board/memberBoard/noticelist.jsp" title="Notice">Notice</a></li>
				<li><a href="../admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li><a href="../board/freeBoard/freeList.jsp" title="freeBoard">FreeBoard</a></li>
				<li><a href="../board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
				&nbsp;<li>||</li>&nbsp;
			<%
				if (bean != null) {
					String id = bean.getId();
						if (id != null) {
			%>
				<li><a href="#" title="Id">ID : <%= id %></a></li>
				<li><a href="../memberPage/myPage.jsp" title="Mypage">Mypage</a></li>
				<li><a href="../member/logout.jsp" title="">Logout</a></li>
			<% 
				} 
			}else {
			%>
			<li><a href="../member/login.jsp" title="Login">Login</a></li>
			<%
				}
			%>			
			</ul>
		</nav>

		<div id="tablecontainer">

			<div class="tablerow">
				<div id="main">
					<form name="listFrm" method="post">
						<table>

							<tr>
								<!-- 수정 -->
								<%
									ProductMgr pMgr = new ProductMgr();
									Vector<ProductBean> vlist = pMgr.getProductList();
									int cnt = 0;
									for (int i = 0; i < vlist.size(); i++) {

										ProductBean pbean = vlist.get(i);
										int proNum = pbean.getProductNum();
										String proName = pbean.getProductName();
										String proType = pbean.getProductType();
										if (mainProtype.equals(proType)) {
											cnt++;
											String filename = pbean.getFilename();
								%>

								<td>

									<table class="galleryImg1">
										<tr>
											<td class="galleryImg2"><img
												src="../admin/img_Product/<%=filename%>.jpg" width="48"
												height="100" alt=""></td>
										</tr>
										<tr>
											<td style="text-align: center;">
											<a href="javascript:detailProc('<%=proNum%>')"><%=proName %></a></td>
										</tr>
									</table>

								</td>

								<%
									if (cnt % 5 == 0) {
												out.print("</tr>");
											}
										}
									} //for
								%>
							
						</table>
						<input type="hidden" name="productNum" value="">
					</form>
				</div>
			</div>
		</div>
		<footer>
			&copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
</div>
<script type="text/javascript">
function detailProc(num){
	document.listFrm.productNum.value= num;
	document.listFrm.action="productDetail.jsp";
	document.listFrm.submit();
}
</script>
</body>

</html>