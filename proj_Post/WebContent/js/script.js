
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

function zipCheck() {
	url = "zipCheck.jsp?check=y";
	leftPos = (screen.width - 500) / 2;
	topPos = (screen.height - 400) / 2;
	window.open(url, "ZipCodeSearch",
			"width=500 height=400 resizable=no scrollbars=yes left=" + leftPos
					+ " top=" + topPos);
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

