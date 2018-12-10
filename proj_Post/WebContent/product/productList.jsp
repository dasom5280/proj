<%@page import="pack_Bean.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_JDBC.ProductMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<style type="text/css">
	table.galleryImg1 tr td.galleryImg2 {
		width : 120px;     /*   48px에서 수정됨*/
		height : 150px;
		text-align : center;	
	}
	table.galleryImg1 {
		margin : 10px;
		border : 1px solid gray;
	}
</style>
</head>
<body>

	<form name="listFrm" method="post">
	<table>

		<tr>  <!-- 수정 -->
		<%
			request.setCharacterEncoding("utf-8");
			String mainProtype = request.getParameter("productType");
			ProductMgr pMgr = new ProductMgr();
			Vector<ProductBean>  vlist = pMgr.getProductList();
			int cnt = 0;
			for (int i = 0; i < vlist.size(); i++) {
				
				ProductBean pbean = vlist.get(i);
				int proNum = pbean.getProductNum();
				String proName = pbean.getProductName();
				String proType = pbean.getProductType();
				if(mainProtype.equals(proType)){
				cnt ++;
				String imgPath = pbean.getImgPath();
		%>

			<td>

				<table class="galleryImg1">
					<tr>
						<td class="galleryImg2"><img src="../images/<%=imgPath%>.jpg" width="48" height="100" alt="" onclick="javascript:detailProc('<%=proNum%>')"></td>
					</tr>
					<tr>
						<td><%=proName %></td>
					</tr>
				</table>

			</td>

		<%
		if(cnt%5 ==0){
			out.print("</tr>");
		}
				}
		} //for
		%>
		
	</table>
	<input type="hidden" name="productNum" value="">
	</form>

<script type="text/javascript">
function detailProc(num){
	document.listFrm.productNum.value= num;
	document.listFrm.action="productDetail.jsp";
	document.listFrm.submit();
}
</script>
</body>

</html>