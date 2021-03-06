<%@page import="pack_Bean.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberBean abean = (MemberBean) session.getAttribute("adminBean");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHOPNAME</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/faqStyle.css" />
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jquerymobile/1.4.5/jquery.mobile.min.css">
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<style>
</style>
</head>
<body>
	<div id="wrap">
	<div id="notice">
	<div align="left">
		<%
				if (abean != null && session.getAttribute("loginBean")==null) {
					
					int level = abean.getLevel();
						if (level==2) {
			%>
				<a href="../adminMain.jsp" title="adminMain">관리자 메인</a>
			<% 
				} 
			}else {
			%>
			<a href="../../index.jsp" title="main">MAIN</a>
			<%
				}
			%>	
	</div>
	<header>
	<h1>FAQ</h1>
	<br><br>
	</header>
	
		<div id="tabProduct" class="ec-base-tab">
			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">회원문의</li>
				<li class="tab-link" data-tab="tab-2">주문결제문의</li>
				<li class="tab-link" data-tab="tab-3">배송문의</li>
				<li class="tab-link" data-tab="tab-4">반품/교환문의</li>
			</ul>
		</div>

		<div id="tab-1" class="tab-content current">
			<div class="faq">

				<div class="faqlist" id="accordian">
					<dl>

						<dt>회원 가입</dt>
						<dd>메인페이지 로그인에 들어가면 회원가입을 할 수 있습니다.</dd>

						<dt>회원 정보 수정</dt>
						<dd>
							로그인 후 마이페이지에서 정보수정 가능합니다.<br> 수정이 안되면 고객센터로 문의 바랍니다.
						</dd>

						<dt>회원 탈퇴</dt>
						<dd>로그인 후 마이페이지에서 회원 탈퇴 가능합니다.</dd>

					</dl>
				</div>
			</div>
		</div>

		<div id="tab-2" class="tab-content">
			<div class="faq">

				<div class="faqlist" id="accordian">
					<dl>

						<dt>주문 후 취소</dt>
						<dd>
							결제완료 후 취소 처리는 직접 불가하여, 고객만족센터(1588-0000)을 통해 취소 요청 부탁 드립니다. <strong>단,
								출고작업은 오전부터 진행되는 부분으로 이미 배송처리가 된 경우 취소가 불가할 수 있으며,</strong> <br /> 휴일 주문
							취소 요청 건에 대해서는 익영업일 처리됩니다. <br />
						</dd>

						<dt>주문 후 옵션/정보변경</dt>
						<dd>
							주문 후 상품 옵션, 수령지 정보 변경 등과 같은 변경을 원하실 경우 직접 처리는 불가하여, <br />
							고객만족센터(1588-0000)을 통해 취소 요청 부탁 드립니다. <br /> <strong>단,이미
								출고된 상품에 대한 변경은 불가하니 이점 참고 부탁 드립니다.</strong><br />
						</dd>

						<dt>현금영수증/세금계산서</dt>
						<dd>
							결제 시 '무통장입금' 및 '실시간 계좌이체'의 경우 주문 시 현금영수증 신청이 가능합니다. <br /> 단,휴대폰
							소액결제의 경우 해당 통신사에 문의 부탁 드립니다.
						</dd>

						<dt>환불 소요기간</dt>
						<dd>
							각 결제수단 별 환불 기간은 아래와 같습니다. <br /> <br /> ■ 카드 취소<br /> - 영업일 기준
							3~7일 내 매입취소로 진행<br /> - 매입 취소 일자 이후에도 한도복구 및 환불이 되지 않을 경우 카드사로
							문의 필요 <br /> - 카드 부분 취소가 불가할 경우 재결제 혹은 적립금 환불로 처리 가능<br /> <br />
							■ 계좌 환불<br /> - 당일 오후 6시 이후 요청한 계좌로 입금 (단, 계좌오류 시 시일 소요될 수 있음)<br />
							- 주문자 명의의 계좌로만 환불 처리 가능<br /> <br /> ■ 실시간 계좌이체 취소<br /> 영업일
							기준 2~3일 내 출금된 계좌로 자동 입금 <br /> - 단, 에스크로 결제의 경우 부분 취소 불가하여 재결제
							혹은 적립금 환불로 처리 가능<br /> <br /> ■ 휴대폰 소액결제 취소<br /> - 영업일 기준
							1~2일 내 한도복구로 진행<br /> - 결제한 당월에 한해 취소 가능, 익월 취소 요청 시 적립금 환불로 처리
							가능<br /> Ex. 3/1 결제 → 3/31까지 전체 취소만 가능, 4/1 이후 적립금 환불만 가능<br />
							- 부분 취소 불가능
						</dd>
					</dl>
				</div>
			</div>
		</div>


		<div id="tab-3" class="tab-content">
			<div class="faq">

				<div class="faqlist" id="accordian">
					<dl>

						<dt>배송기간 및 조회</dt>
						<dd>
							상품 출고 시 송장번호를 포함한 알림톡 발송되며, 배송일은 출고일 제외 1~3일(영업일 기준) 소요<br /> 단,
							택배사 지역별 물량 사정에 따라 3일 이상 소요될 수 있는 점 양해 부탁 드립니다.
						</dd>

						<dt>배송지 변경</dt>
						<dd>
							주문 후 상품 옵션, 수령지 정보 변경 등과 같은 변경을 원하실 경우 직접 처리는 불가하여, <br />
							고객만족센터(1588-0000)을 통해 취소 요청 부탁 드립니다. <br /> <strong>#
								단, 이미 출고된 상품에 대한 배송지 수정은 불가하니 이점 참고 부탁 드립니다.</strong><br />
						</dd>

						<dt>무료배송 조건</dt>
						<dd>
							저희 쇼핑몰에서는 5만원 이상 주문건에 대해 무료로 배송 해 드리고 있습니다. <br /> - <strong>5만원
								이하의 주문일 경우 결제 시 배송비 2,500 부과</strong><br /> - 배송비가 각각 부과된 주문건에 대해 묶음배송
							요청 시 배송비 환불 가능 (단, 출고 전 고객만족센터 문의 필수)<br />
						</dd>

						<dt>묶음배송</dt>
						<dd>
							서로 다른 주문건에 대해 묶음배송을 원하실 경우 고객만족센터로 문의 부탁 드립니다. <br /> - 배송비가 각각
							부과된 주문건에 대해 묶음배송 요청 시 배송비 환불 가능 <br /> - 요청 전 출고가 진행되었을 경우, 배송비
							환불 및 묶음배송 처리 불가 <br />
						</dd>

						<dt>퀵/방문 수령</dt>
						<dd>
							주문 후 재고가 있는 상품에 한해 퀵 배송 및 방문 수령이 가능합니다.<br /> <br /> ■ 퀵 배송<br />
							- 결제 완료 후 고객만족센터로 출고 가능 여부 확인 필요 (배송비 고객 부담) <br /> - 오후 2시까지
							요청건에 대해서만 당일 출고 가능<br /> - 퀵으로 출고된 상품에 대해 반품 시, 반품배송비는 고객 부담 <br />
							■ 방문 수령<br /> - 결제 완료 후 고객만족센터로 수령 가능 여부 확인 필요 <br /> - 오후 4시까지
							요청건에 대해서만 당일 출고 가능<br />
						</dd>



						<dt>해외배송</dt>
						<dd>
							우체국 EMS서비스 가능 지역일 경우, 해외배송이 가능합니다.<br /> <br /> - 배송비는 지역 및 상품
							무게에 따라 측정되며 주문서 작성 단계에서 확인 가능<br /> - 배송비에 관세 및 세금 미포함으로 상품 수령 시
							추가 지불 필요 <br /> - <strong>해외배송의 경우 교환 및 환불 불가하며, ACC를
								포함한 신발 등은 입고지연으로 해외배송 불가</strong> <br /> - 해당 국가 절차로 세관에서 통과되지 않읗 경우,
							고객님께서 직접 방문하여 수령 필요하며<br /> 자사로 반송 시 배송비는 고객 부담<br /> Tip. 배송비에
							포함된 '해외배송 보험료'란?<br /> 해외배송 시 문제가 발생 했을 경우, 이에 해당하는 우편요금을 배상규정에
							따라 배상해 주는 서비스<br />
						</dd>

					</dl>
				</div>
			</div>


		</div>
		<div id="tab-4" class="tab-content">
			<div class="faq">

				<div class="faqlist" id="accordian">
					<dl>

						<dt>반품/교환 불가 사유</dt>
						<dd>
							- 상품 수령 후 7일이 경과 된 경우 <br /> - 상품이 불량일 경우라도 90일이 경과되었을 경우 <br />
							-<strong> 불량 체크를 하지 않고 외부 착용이나 텍 제거 및 훼손을 한 경우 불량일 경우에도
								반품 및 교환 불가</strong> <br /> - 상품의 가치가 훼손 된 경우 (향수냄새, 담배냄새, 섬유린스, 바디로션,
							탈취제, 얼룩, 착용흔적 등) <br /> - 인위적으로 상품을 손상시킨 경우 (상품의 택 분실 및 훼손, 인위적인
							수선, 세탁, 제품 훼손 등) <br /> -<strong> 상세 페이지 내 안내 된 권장세탁
								방법으로 세탁하지 않아 발생되는 문제</strong> <br /> - 배송 시 발생될 수 있는 상품의 구김이나 대량 생산 특성상
							생길수 있는 미흡한 마감처리 부분 <br /> (실밥, 본드자국, 박음질, 초크자국 등)으로 불량 처리 불가 <br />
							- 단추 마감 미흡의 경우로 불량 처리 불가 <br /> - 사이즈 불만의 사유로는 불량 처리 불가 <br />
							- 패턴 무늬 상품의 비대칭 사유로는 불량 처리 불가 <br /> - 원단 자체 냄새, 공정상 발생되는 냄새로 인한
							불량 처리 불가 <br /> <strong style="color: red"> # 위 반품/교환
								불가 사유에 해당하는 상품에 대해 자사 입고 시 환불 처리 불가 <br /> 및 왕복배송비(5,000원) 지불 후
								상품 재배송 가능 <br />
							</strong>
						</dd>
						
						<dt>반품/교환 방법</dt>
						<dd>
							■ 고객 직접 발송<br /> 성함, 연락처, 교환 or 반품, 상세사유를 기재한 메모를 동봉하여
							훼손없이 상품 포장 후 아래 주소로 발송 부탁 드립니다. <br />서울시 강남구 논현1동 859-45
							문의가 있을시 고객센터로(1588-0000) 문의 바랍니다. </strong>
							<br /> - 상세 사유가 기재되어 있지 않을 경우, 단순변심으로 간주하여 배송비 차감 후 환불
							처리 <br />
							<br />
							<strong style="color: #0070C0">[반품 시 확인사항]</strong><br /> - <strong>반품
								배송비는 환불 시 차감 후 처리가 되오니 별도의 동봉 및 입금은 하지 않습니다.</strong><br /> (동봉한 배송비 분실 시
							자사에서 처리 불가 및 고객 재부담 필요)<br /> - 반품 후 최종 구매 상품이 무료배송 조건에 충족되지 않을
							경우 반품배송비 5,000원 차감, 충족 시 반품배송비 2,500원 차감<br /> - 상품 불량과 같은 자사 과실로
							발생된 반품일 경우 무료 처리 가능하며, 그 외의 사유는 단순변심으로 배송비 발생<br />
							<br />
							<strong style="color: #0070C0">[교환 시 확인사항]</strong><br /> - 동일
							상품의 색상 및 사이즈 교환이 가능합니다. (타상품 교환 불가) <br /> - 교환 상품 입고 시점에 해당 상품
							품절일 경우 교환 불가하며, 배송비는 고객 부담이오니 참고 부탁 드립니다.<br /> (발송 전 고객센터로 재고 여부
							확인 후 발송 부탁 드리며, 입고 시점에서 품절 시 유선 안내 드립니다.)<br /> - 교환 배송비는 최종 구매
							상품과 관계없이 5,000원이며, 홈페이지 하단의 계좌에 본인 성함으로 입금 부탁 드립니다. <br /> (본인
							성함으로 입금 되지 않을 경우 처리가 지연될 수 있으며, 배송비 동봉 후 분실 시 자사에서 처리 불가합니다)<br />
							- 교환과 반품 상품을 합배송하여 보내주실 경우, 배송비는 차감되오니 별도 입금은 하지 않으셔도 됩니다.<br />
						</dd>

						<dt>상품 회수 절차</dt>
						<dd>
							상품 수령한 장소로 영업일 기준 1~3일 내 회수기사가 방문하여 상품 회수 예정이며,<br /> 해당 일자 이내
							회수가 되지 않을 경우 고객만족센터(1588-0000)로 문의 부탁 드립니다. <br />
							- 회수지 변경이 필요할 경우 접수 전 고객만족센터(1588-0000)로 문의 시 변경
							가능<br />
						</dd>

						<dt>상품 입고 후 반품 처리 기간</dt>
						<dd>
							발송해주신 상품은 중앙우체국 소포실을 통해 자사로 입고되며, 도착 안내 문자는 우체국 도착 기준입니다.<br />
							우체국 도착 후 1~2일 내 자사로 입고되며 이후 3일 내 반품/교환 처리 됩니다.
							<br /> # 결제수단 별 환불 소요기간은 FAQ 참고 부탁 드립니다.<br />
						</dd>

					</dl>
				</div>
			</div>
		</div>
		</div>
		
	<footer style="text-align:center;">
			&copy; 2018, 쇼핑몰이름<br>이 사이트의 모든 상표와 등록된 상표는 해당 소유자의 자산입니다.
	</footer>
	</div>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){
	   
	  $('ul.tabs li').click(function(){
	    var tab_id = $(this).attr('data-tab');
	 
	    $('ul.tabs li').removeClass('current');
	    $('.tab-content').removeClass('current');
	 
	    $(this).addClass('current');
	    $("#"+tab_id).addClass('current');
	  })
	 
	})

	$(function(){
		$("#accordian dt").click(function(){
			$("#accordian dl dd").slideUp();
			if(!$(this).next().is(":visible"))
			{
				$(this).next().slideDown();
			}
		})
	})
	</script>

</body>
</html>