<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	MemberBean bean = (MemberBean) session.getAttribute("loginBean");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet" type="text/css" href="../css/mainStyle.css">

</head>
<body>
	<div id="wrap">


		<header class="top">
			<img id="headerLogo" src="../images/headerLogo.png" alt="로고">
		</header>

		<nav>
			<ul>
				<li><a href="#" title="Outer">Outer</a></li>
				<li><a href="#" title="Top">Top</a></li>
				<li><a href="#" title="Bottom">Bottom</a></li>
				<li><a href="#" title="Sale">Sale</a></li>
				&nbsp;<li>||</li>&nbsp;
				<li><a href="../board/memberBoard/noticelist.jsp" title="Notice">Notice</a></li>
				<li><a href="../admin/ad_Board/faq.jsp" title="FAQ">FAQ</a></li>
				&nbsp;<li>||</li>&nbsp;
			<%
				if (bean != null) {
					String id = bean.getId();
						if (id != null) {
			%>
				<li><a href="#" title="Id">ID : <%= id %></a></li>
				<li><a href="../memberPage/myPage.jsp" title="Mypage">Mypage</a></li>
				<li><a href="../member/logout.jsp" title="Login">Logout</a></li>
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

				<div id="adv">
					<p>광고이미지 출력</p>
				</div>
			</div>

			<div class="tablerow">
				<div id="main">
					<table>
						<tr>
							<td colspan="5"><b>New Arrival</b></td>
						</tr>
						<tr>
							<td><img src="#" alt="이미지1"></td>
							<td><img src="#" alt="이미지2"></td>
							<td><img src="#" alt="이미지3"></td>
							<td><img src="#" alt="이미지4"></td>
							<td><img src="#" alt="이미지5"></td>
						</tr>
						<tr>
							<td><img src="#" alt="이미지6"></td>
							<td><img src="#" alt="이미지7"></td>
							<td><img src="#" alt="이미지8"></td>
							<td><img src="#" alt="이미지9"></td>
							<td><img src="#" alt="이미지10"></td>
						</tr>
						<tr>
							<td><br></td>
						</tr>

						<tr>
							<td colspan="5"><b>Sale</b></td>
						</tr>
						<tr>
							<td><img src="#" alt="이미지1"></td>
							<td><img src="#" alt="이미지2"></td>
							<td><img src="#" alt="이미지3"></td>
							<td><img src="#" alt="이미지4"></td>
							<td><img src="#" alt="이미지5"></td>
						</tr>
						<tr>
							<td><img src="#" alt="이미지6"></td>
							<td><img src="#" alt="이미지7"></td>
							<td><img src="#" alt="이미지8"></td>
							<td><img src="#" alt="이미지9"></td>
							<td><img src="#" alt="이미지10"></td>
						</tr>
						<tr>
							<td><br></td>
						</tr>

						<tr>
							<td colspan="5"><b>Etc</b></td>
						</tr>
						<tr>
							<td><img src="#" alt="이미지1"></td>
							<td><img src="#" alt="이미지2"></td>
							<td><img src="#" alt="이미지3"></td>
							<td><img src="#" alt="이미지4"></td>
							<td><img src="#" alt="이미지5"></td>
						</tr>
						<tr>
							<td><img src="#" alt="이미지6"></td>
							<td><img src="#" alt="이미지7"></td>
							<td><img src="#" alt="이미지8"></td>
							<td><img src="#" alt="이미지9"></td>
							<td><img src="#" alt="이미지10"></td>
						</tr>
						<tr>
							<td><br></td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<footer>
			&copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
	</div>
</body>
</html>