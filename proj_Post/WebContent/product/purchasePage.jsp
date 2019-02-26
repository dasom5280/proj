<%@page import="pack_Bean.BasketBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_JDBC.BasketMgr"%>
<%@page import="pack_Bean.MemberBean"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	MemberBean mbean = (MemberBean) session.getAttribute("loginBean");
	String mid = null;
	int points = 0;
	
	String nums = null;
	String proNum = null;
	String proName = null;
	int price = 0;
	String proType =  null;
	int quantity = 1;
	
	BasketMgr basMgr = new BasketMgr();
	Vector<BasketBean> basBeans = null;
	
	if (mbean == null)
		response.sendRedirect("../member/login.jsp");

	else {
		mid = mbean.getId();
		points = mbean.getPoints();
		if(mid==null||!mid.equals(request.getParameter("id"))){
			response.sendRedirect("../member/logout.jsp");
		}
		
		if (request.getParameter("nums") != null && !request.getParameter("nums").equals("null")) {
			nums = request.getParameter("nums");
			StringTokenizer st = new StringTokenizer(nums, "/");
			basBeans = new Vector<>();
			while (st.hasMoreTokens()) {
				int basNum = Integer.parseInt(st.nextToken());
				BasketBean basBean = basMgr.getBasket(basNum);
				basBeans.add(basBean);
			}
		} else {
			proNum = request.getParameter("productNum");
			proName = request.getParameter("productName");
			proType = request.getParameter("productType");
			if(request.getParameter("price")!=null && request.getParameter("quantity")!=null){
			price = Integer.parseInt(request.getParameter("price"));
			quantity = Integer.parseInt(request.getParameter("quantity"));
		}
	}
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/mainStyle.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">

<style type="text/css">
table#innerTbl {
	width: 200%;
	text-align: center;
}
.fc {
	text-align: center;
}
</style>
</head>
<body>
	<div id="wrap">
	<div class="container-fluid">
		<div class="row">
			<div class="col" style="text-align: center;">
			<header>
			<h1>SHOP NAME</h1>
			</header>
			</div>
		</div>

		<nav>
				<ul class="nav nav-pills nav-fill flex-column flex-sm-row">
				<li class="nav-item"><a  class="nav-link" href="productList.jsp?productType=outer" title="Outer">OUTER</a></li>
				<li class="nav-item"><a class="nav-link" href="productList.jsp?productType=top" title="Top">TOP</a></li>
				<li class="nav-item"><a class="nav-link" href="productList.jsp?productType=bottom" title="Bottom">BOTTOM</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/memberBoard/noticelist.jsp" title="Notice">NOTICE</a></li>
				<li class="nav-item"><a class="nav-link" href="../admin/ad_Board/noticeFAQ.jsp" title="FAQ">FAQ</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/freeBoard/freeList.jsp" title="freeBoard">FREEBOARD</a></li>
				<li class="nav-item"><a class="nav-link" href="../board/memberBoard/qnAlist.jsp" title="QnA">Q&A</a></li>
			<%
						if (mid != null) {
			%>
				<li class="nav-item"><a class="nav-link" href="../member/passCheck.jsp" title="MyPage">ID : <%= mid %></a></li>
				<li class="nav-item"><a class="nav-link" href="memberPage/basketPage.jsp" title="MyCart">MYCART</a></li>
				<li class="nav-item"><a class="nav-link" href="member/logout.jsp" title="">LOGOUT</a></li>
		<% 
						} else {
			%>
			<li class="nav-item"><a class="nav-link" href="../member/login.jsp" title="Login">LOGIN</a></li>
			<%
				}
			%>			
			</ul>
		</nav>
		
		<div class="row">
			<div class="col">
			<div id="main" >
			
				<h4 style="text-align:center;"><%=mid %>님의 구매상품</h4>
				<form name="purFrm" method="post">
				<div class="table-responsive">
					<table class="table table-borderless table-condensed" style="text-align: left; width: 70%; margin: 0 auto;">
				<tr>
				<td colspan="4">
				<hr>
				<td>
				</tr>
				<tr>
				<td>
				<table id="innerTbl" class="table">
				<tr>
				<td>상품종류</td>
				<td>상품이름</td>
				<td>상품가격</td>
				<td>수량</td>
				</tr>
				
				<% if (basBeans!=null) {
				for(int i= 0; i<basBeans.size(); i++){
					BasketBean basbean = basBeans.get(i);
					int basnum = basbean.getBasketNum();
					String basproname = basbean.getProductName();
					String basprotype = basbean.getProductType();
					int baspronum = basbean.getProductNum();
					String basprice = basbean.getPrice();
					int basquantity = basbean.getQuantity();
					price = price + (Integer.parseInt(basprice) * basquantity);
				%>
				<tr>
				<td><%=basprotype %></td>
				<td><%=basproname %></td>
				<td><%=basprice %></td>
				<td><%=basquantity %>
				</td>
				</tr>
				<% }//for
				} else {%>
				<tr>
				<td><%=proType %></td>
				<td><%=proName %></td>
				<td><%=price %></td>
				<td>
				<%=quantity%>
				<% price = (price * quantity); %>
				<input type="hidden" name="productNum" value="<%=proNum%>">
				<input type="hidden" name="productType" value="<%=proType %>">
				<input type="hidden" name="productName" value="<%=proName%>">
				<input type="hidden" name="quantity" value="<%=quantity %>">
				</td>
				</tr>
				<% }//if %>
				
				</table>
				</td>
				</tr>
				<tr>
				<td colspan="4">
				<hr>
				<td>
				</tr>

				<tr>
					<td class="fc">총 가격</td>
					<td><%=price%></td>
				</tr>
				<tr>
					<td class="fc">적립금 사용</td>
					<td>
					<input type="text" value="0" name="usedPoints" size="7" min="0"
								max="<%=points%>">
					
					&nbsp;&nbsp;<span style="font-size: small;">총 적립금 : <%=points %></span>
					<!-- javascript에서 적립금 계산 처리 -->
				</td>
				</tr>
				<tr>
				<td colspan="4">
				<hr>
				</td>
				</tr>

				<tr>
					<td class="fc" >우편번호</td>
					<td>
					<div class="input-group mb-3">
					<input type="text" name="zipcode" size="10" readonly>
					<div class="input-group-append">
					<input class="btn btn-secondary" id="zipButton" type="button" value="우편번호찾기" onclick="zipCheck()">
					</div>
					</div>
					</td>
				</tr>

				<tr>
					<td class="fc">주소</td>
					<td><input type="text" name="address" size="40" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="fc">지불 수단</td>
					<td>
					<label>
					신용카드 <input type="radio" name="payment"  value="1">
					계좌이체 <input type="radio" name="payment"  value="2">
					휴대폰 결제  <input type="radio" name="payment" value="3">
					</label>
					</td>
				</tr>
				<tr>
				<td colspan="4">
				<hr>
				<td>
				</tr>
				<tr>
				<td colspan="4" style="text-align: center;">
				<input class="btn btn-secondary" type="button" value="이동" onclick="javascript:purProc('<%=points%>')">
				</td>
				</tr>
				
			</table>
			<input type="hidden" name="nums" value="<%=request.getParameter("nums") %>">
			<input type="hidden" name="id" value="<%=mid %>">
			<input type="hidden" name="price" value="<%= price %>">
			<input type="hidden" name="oriprice" value="<%= request.getParameter("price") %>">
		</div>
		</form>
		</div>
	</div>
</div>
		<div class="row">
		<div class="col">
		<footer>
			&copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
		</footer>
		</div>
		</div>
	</div>	
	</div>	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>	
	<script type="text/javascript">
	function zipCheck(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	        	 var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	           			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.purFrm.address.value = extraAddr;
	                
	                } else {
	                    document.purFrm.address.value = '';
	                } 

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.purFrm.zipcode.value = data.zonecode;
	                document.purFrm.address.value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	            }
	    }).open();
	}
	
	function purProc(points){
		frm = document.purFrm;
		
		if(frm.usedPoints.value=="" || frm.usedPoints.value=="null"){
			alert("적립금을 확인해주세요.");
			frm.usedPoints.focus();
			return;
		}
		
		var p = parseInt(frm.usedPoints.value);
		if(p<0){
			alert("적립금을 확인해주세요.");
			frm.usedPoints.focus();
			return;
		}
		if(p>points){
			alert("적립금을 확인해주세요.");
			frm.usedPoints.focus();
			return;
		}
		if(frm.zipcode.value=="" || frm.zipcode.value=="null" ){
			alert("우편 번호를 입력해주세요.");
			return;
		}
		if(frm.address.value=="" || frm.address.value=="null"){
			alert("주소를 입력해주세요.");
			return;
		}

        var chk = document.getElementsByName("payment");
  		cnt = 0;
        for(i=0; i<chk.length; i++){
             if(chk[i].checked==true){
                cnt ++;
             }
        }
		if(cnt ==0 || frm.payment.value==""){
			alert("결제 수단을 선택해주세요.");
			return;
		}
		document.purFrm.action="purchaseConfirm.jsp";
		document.purFrm.submit();
	}
	</script>
</body>
</html>