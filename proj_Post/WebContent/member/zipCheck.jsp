<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pack_Bean.*, java.util.*" %>    

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="pack_JDBC.MemberMgr" scope="page" />
<%
String check = request.getParameter("check");
String area3 = null;

Vector<ZipcodeBean> vlist = null;

if (check.equals("n")) {
	area3 = request.getParameter("area3");
	vlist = mMgr.zipcodeRead(area3); 
	// ZipcodeBean에 DB에서 불러온 데이터가 저장됨
	// vlist를 사용하여 참조할 수 있음
}
%>

<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div id="wrapZip">
		
		<form name="zipFrm">
			<input type="hidden" name="check" value="n">
			<table>
				<tr>
					<td class="zipRes">
					동이름 입력 
					<input type="text" name="area3">
					&nbsp;
					<input type="button" value="검색" onclick="dongCheck()">
					</td>
				</tr>
<%
if (check.equals("n")) {
	if (vlist.isEmpty()) {
%>
				<tr>
					<td><span style="font-size:20px;">검색 결과가 없습니다.</span></td>
				</tr>
						
<% }	else { %>

		<tr>
			<td>
				<span style="font-size:20px;">
				검색 후 아래 우편번호를 클릭하면<br>
				자동으로 입력됩니다.
				</span>
			</td>
		</tr>		
<%			
for (int i=0; i<vlist.size(); i++) {
	ZipcodeBean bean = vlist.get(i);
	String rZipcode = bean.getZipcode();
	String rArea1 = bean.getArea1();
	String rArea2 = bean.getArea2();
	String rArea3 = bean.getArea3();
	String rArea4 = bean.getArea4();
%>
				
				<tr>
					<td class="zipRes">
						<a href="#" onclick="javascript:sendAdd(
							'<%=rZipcode%>',
							'<%=rArea1%>',
							'<%=rArea2%>',
							'<%=rArea3%>',
							'<%=rArea4%>'
						)">
						<%=rZipcode%>&nbsp;
						<%=rArea1%>&nbsp;
						<%=rArea2%>&nbsp;
						<%=rArea3%>&nbsp;
						<%=rArea4%>
						</span>
					</td>
				</tr>
<%
		} // for		
	} // if
} // if
%>	
				<tr>
					<td><a href="#" onclick="javascript:self.close()">닫기</a></td>
				</tr>
			</table>
			
		</form>

	</div>
<script>
function dongCheck() {
	frm = document.zipFrm;
	if (frm.area3.value == "") {
		alert("동이름을 입력하세요");
		frm.area3.focus();
		return;
	} else {
		frm.method = "get";
		frm.action = "zipCheck.jsp";
		frm.submit();
	}
	
}

function sendAdd(zipcode, area1, area2, area3, area4) {
	
	addr = area1 + " " +  area2 + " " +
				area3 + " " +  area4;
	opener.document.regFrm.zipcode.value = zipcode;
	opener.document.regFrm.address.value = addr;
	self.close();
	
}
</script>	
</body>
</html>