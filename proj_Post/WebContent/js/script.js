//admin Board start////

function list() {
	document.listFrm.action = "list.jsp";
	document.listFrm.submit();
}


function post(){
	document.postFrm.action = "post.jsp";
	documnet.postFrm.submit();
}

//admin Board end////

// //////////로그인 처리 시작 ////////////
function loginCheck() {

	frm = document.loginFrm;

	if (frm.id.value == "") {
		alert("아이디를 입력해 주세요.");
		frm.id.focus();
		return;
	} else if (frm.pass.value == "") {
		alert("비밀번호를 입력해 주세요.");
		frm.pass.focus();
		return;
	} else {
		frm.method = "post";
		frm.action = "loginProc.jsp";
		// alert("문제없이 전송됨!!");
		frm.submit();
	}

}
// //////////로그인 처리 끝 ////////////

// //////////회원가입 처리 시작 ////////////
function focusCheck() {
	// 회원가입페이지 시작할 때
	// id입력란에 포커스 위치함
	frm = document.regFrm;
	frm.id.focus();
}

function idCheck(id) {
	frm = document.regFrm;
	if (id.trim() == "") {
		alert("아이디를 입력해주세요");
		frm.id.focus();
		return;
	}
	url = "idCheck.jsp?id=" + id;
	leftPos = (screen.width - 300) / 2;
	topPos = (screen.height - 150) / 2;
	window.open(url, "IDCheck", "width=300 height=150 resizable=no left="
			+ leftPos + " top=" + topPos);
}

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
                    document.regFrm.address.value = extraAddr;
                
                } else {
                    document.regFrm.address.value = '';
                } 

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.regFrm.zipcode.value = data.zonecode;
                document.regFrm.address.value = addr;
                // 커서를 상세주소 필드로 이동한다.
            }
    }).open();
}

function inputCheck() {
	frm = document.regFrm;
	if (frm.id.value == "") {
		alert("아이디를 입력해주세요");
		frm.id.focus();
	} else if (frm.pass.value == "") {
		alert("비밀번호를 입력해주세요");
		frm.pass.focus();
	} else if (frm.repass.value == "") {
		alert("비밀번호를 확인해주세요");
		frm.pass.focus();
	}else if (frm.pass.value != frm.repass.value) {
		alert("비밀번호가 일치하지 않습니다");
		frm.repass.value = "";
		frm.pass.focus();
	} else if (frm.name.value == "") {
		alert("이름을 입력해주세요");
		frm.name.focus();
	} else if (frm.birthday.value == "") {
		alert("생년월일을 입력해주세요");
		frm.birthday.focus();
	} else if (frm.email.value == "") {
		alert("이메일을 입력해주세요");
		frm.email.focus();
	} else if (frm.zipcode.value == "") {
		alert("우편번호를 입력해주세요");
		frm.zipcode.focus();
	} else if (frm.address.value == "") {
		alert("주소를 입력해주세요");
		frm.address.focus();
	} else if (frm.phone1.value == "") {
		alert("전화번호를 입력해주세요");
		frm.address.focus();
	} else if (frm.phone2.value == "") {
		alert("전화번호를 입력해주세요");
		frm.address.focus();
	} else if (frm.phone3.value == "" ) {
		alert("전화번호를 입력해주세요");
		frm.address.focus();
	} else if (frm.idChkValue.value == "0") {
		alert("아이디 중복확인을 해주세요.");
		frm.idChkBtn.focus();
	} else {
		frm.method = "post";
		frm.action = "memberProc.jsp";
		frm.submit();
	}
}
// //////////회원가입 처리 끝 ////////////

