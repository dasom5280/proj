<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="pack_Bean.Ad_BoardBean"%>
<jsp:useBean id="mMgr" class="pack_JDBC.Ad_BoardMgr" />
<%
	request.setCharacterEncoding("UTF-8"); 	
	// => post 또는 get방식으로 데이터 수신이 있음 
	int num = Integer.parseInt(request.getParameter("num"));
	
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	mMgr.upCount(num);   // 조회수 증가를 위한 소스
	
	Ad_BoardBean bean = mMgr.getBoard(num); 
	// 해당 키값(=글 고유번호, 즉 num 값)을 갖는 데이터의 자료 반환 
	
	String name = bean.getName();
	String subject = bean.getSubject();
	String regdate = bean.getRegdate();
	String content = bean.getContent();
	String ip = bean.getIp();
	int count = bean.getCount();
	
	session.setAttribute("bean", bean);
	// bean으로 반환된 데이터를 세션으로 설정함(ID 및 로그인과 무관함)
%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>JSPBoard</title>
<link rel="stylesheet" href="css/style.css">
<script>
	function list() {
		document.listFrm.action = "ad_Notice.jsp";
		document.listFrm.submit();
	}


</script>
</head>
<body>
	<div id="wrap">
	
		<h1>글읽기</h1>

		<table class="readTbl">
			<tr>
				<td colspan="2">
					<table id="readInnerTbl">
						<tr>
							<td class="itemSet">이 름</td>
							<td><%=name%></td>
							<td class="itemSet">등록날짜</td>
							<td><%=regdate%></td>
						</tr>
						<tr>
							<td class="itemSet">제 목</td>
							<td colspan="3" class="rangeLeft">
								<%=subject%>
							</td>
						</tr>
						
						<tr>
							<td colspan="4" class="rangeLeft rangeTop">
							<pre><%=content%></pre>
							</td>
						</tr>
						<tr>
							<td colspan="4">IP : <%=ip%> / 조회수 <%=count%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="2">
					<hr>
						[ 
						<a href="ad_Notice.jsp" title="">리스트</a> | 
					   <a href="ad_update.jsp?nowPage=<%=nowPage%>&num=<%=num%>">수 정</a> | 
					   <a href="ad_delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭 제</a>  |
					   <a href="ad_post.jsp">글쓰기</a> 
					   ]
					   <br>
				</td>
			</tr>
		</table>

		<form name="listFrm" method="post">
			<input type="hidden" name="num" value="<%=num%>"> 
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<%
				if (!(keyWord == null || keyWord.equals("null"))) {
			%>
			<input type="hidden" name="keyField" value="<%=keyField%>"> 
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%
				}
			%>
		</form>

	</div>
</body>
</html>