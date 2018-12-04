<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

<!-- id가 외래키로 지정된 테이블 추가시 MemberMgr에 그 테이블 자료도 삭제 처리해야함 -->
<%
	request.setCharacterEncoding("utf-8");
	String insPass = request.getParameter("pass");
	MemberBean bean = (MemberBean) session.getAttribute("loginBean");

	String oriPass = bean.getPass();
	String msg = "비밀번호가 일치하지 않습니다";
	String url = "quitMember.jsp";

	if (insPass.equals(oriPass)) {

		boolean chkDel = mMgr.deleteMember(bean.getId());

		if (chkDel) {
			url = "../main.jsp";
			msg = "탈퇴가 완료되었습니다.";
			session.invalidate();
		} else {
			msg = "탈퇴 실패. 문의 부탁드립니다";
		}
	}
%>
		<script>
		alert("<%=msg%>");
		location.href="<%=url%>";
		</script>
</head>
<body>
	<div id="wrap"></div>
</body>
</html>