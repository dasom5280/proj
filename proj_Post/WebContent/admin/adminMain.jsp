<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- <meta http-equiv="imagetoolbar" content="no">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="author" content="(주)에스아이알소프트">
<meta name="keywords" content="영카트5,그누보드5,GPL,무료쇼핑몰솔루션">
<meta name="description" content="영카트5는 자유롭게 사용할수 있는 GPL 라이센스 독립형 무료 쇼핑몰 솔루션 입니다.">
 -->

<title>관리자메인</title>
<link rel="stylesheet" href="admin.css">


<script>
// 자바스크립트에서 사용하는 전역변수 선언
varurl       = "";
var bbs_url   = "https://demo.sir.kr/gnuboard5/bbs";
var member = "1";
var admin  = "";
var mobile = "";
var table  = "";
var sca       = "";
var editor    = "";
var g5_cookie_domain = "";
var g5_admin_url = "https://demo.sir.kr/gnuboard5/adm";
</script>
<script src="https://demo.sir.kr/gnuboard5/js/jquery-1.8.3.min.js"></script>
<script src="https://demo.sir.kr/gnuboard5/js/jquery.menu.js?ver=171222"></script>
<script src="https://demo.sir.kr/gnuboard5/js/common.js?ver=171222"></script>
<script src="https://demo.sir.kr/gnuboard5/js/wrest.js?ver=171222"></script>
<script src="https://demo.sir.kr/gnuboard5/js/placeholders.min.js"></script>
<link rel="stylesheet" href="https://demo.sir.kr/gnuboard5/js/font-awesome/css/font-awesome.min.css">
</head>


<body>

<div id="hd_login_msg"><a href="adminLogout.jsp">로그아웃</a></div>
<script>
var tempX = 0;
var tempY = 0;

function imageview(id, w, h)
{

    menu(id);

    var el_id = document.getElementById(id);

    //submenu = eval(name+".style");
    submenu = el_id.style;
    submenu.left = tempX - ( w + 11 );
    submenu.top  = tempY - ( h / 2 );

    selectBoxVisible();

    if (el_id.style.display != 'none')
        selectBoxHidden(id);
}
</script>

<header id="hd">
    <h1>쇼핑몰</h1>
    <div id="hd_top">
        <button type="button" id="btn_gnb" class="btn_gnb_close ">메뉴</button>
       <div id="logo"><a href=""><img src="사진" alt="쇼핑몰 관리자"></a></div>

        <div id="tnb">
            <ul>
                <li><a href="">부가서비스</a></li>
                <li><button type="button">관리자<span class="">메뉴열기</span></button>
                    <ul>
                        <li><a href="">관리자정보</a></li>
                        <li><a href="adminLogout.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <nav id="gnb" class="gnb_large ">
        <h2>관리자 주메뉴</h2>
        <ul class="gnb_ul">
        
                        <li>
                <button type="button" class="" title="회원관리">회원관리</button>
                <div>
                    <div>
                        <h3>회원관리</h3>
                        <ul><li><a href="" class="gnb_2da  ">회원관리</a></li>
                        <li><a href="" class="gnb_2da  ">회원정보</a></li>
                        <li><a href="" class="gnb_2da  ">회원리스트</a></li>
                        <li><a href="" class="gnb_2da gnb_grp_style gnb_grp_div">회원접속정보</a></li>
                    </div>
                </div>
            </li>
            
            
                        <li>
                <button type="button" class="" title="게시판관리">게시판관리</button>
                <div>
                    <div>
                        <h3>게시판관리</h3>
                        <ul><li ><a href="" class="gnb_2da  ">게시판관리</a></li>
                        <li><a href="" class="gnb_2da  ">게시판그룹관리</a></li>
                        <li><a href="ad_Board/faq.jsp" class="gnb_2da  gnb_grp_div">FAQ</a></li>
                        <li><a href="" class="gnb_2da  gnb_grp_div">공지게시판</a></li>
                        <li><a href="" class="gnb_2da gnb_grp_style gnb_grp_div">내용관리</a></li></ul>
                   </div>
                </div>
            </li>
            
            
                        <li>
                <button type="button" class="" title="쇼핑몰관리">쇼핑몰관리</button>
                <div>
                    <div>
                        <h3>쇼핑몰관리</h3>
                        <ul><li><a href="" class="">쇼핑몰관리</a></li>
                        <li><a href="" class="">주문내역</a></li>
                        <li><a href="" class="">상품관리</a></li>
                        <li><a href="" class="">상품문의</a></li>
                        </ul>
                    </div>
                </div>
            </li>
            
                    </ul>
    </nav>

</header>


<script>
jQuery(function($){

    var menu_cookie_key = 'g5_admin_btn_gnb';

    $(".tnb_mb_btn").click(function(){
        $(".tnb_mb_area").toggle();
    });

    $("#btn_gnb").click(function(){
        
        var $this = $(this);

        try {
            if( ! $this.hasClass("btn_gnb_open") ){
                set_cookie(menu_cookie_key, 1, 60*60*24*365);
            } else {
                delete_cookie(menu_cookie_key);
            }
        }
        catch(err) {
        }

        $("#container").toggleClass("container-small");
        $("#gnb").toggleClass("gnb_small");
        $this.toggleClass("btn_gnb_open");

    });

    $(".gnb_ul li .btn_op" ).click(function() {
        $(this).parent().addClass("on").siblings().removeClass("on");
    });

});
</script>

        <noscript>
            <p>
                귀하께서 사용하시는 브라우저는 현재 <strong>자바스크립트를 
                사용하지 않음</strong>으로 설정되어 있습니다.<br>
                <strong>자바스크립트를 사용하지 않음</strong>으로 설정하신
                 경우는 수정이나 삭제시 별도의 경고창이 나오지 않으므로 이점
                  주의하시기 바랍니다.
            </p>
        </noscript>

        <footer id="ft">
            <p>
                Copyright &copy; demo.sir.kr. All rights reserved. YoungCart Version 5.3.2.0<br>
               <button type="button" class="scroll_top"><span class="top_img"></span>
               <span class="top_txt">TOP</span></button>
           </p>
        </footer>

<script>
$(".scroll_top").click(function(){
     $("body,html").animate({scrollTop:0},400);
})
</script>

<!-- <p>실행시간 : 0.0082929134368896 -->

<script src="https://demo.sir.kr/gnuboard5/adm/admin.js?ver=171222"></script>
<script src="https://demo.sir.kr/gnuboard5/js/jquery.anchorScroll.js?ver=171222"></script>
<script>
$(function(){

    var admin_head_height = $("#hd_top").height() + $("#container_title").height() + 5;

    $("a[href^='#']").anchorScroll({
        scrollSpeed: 0, // scroll speed
        offsetTop: admin_head_height, // offset for fixed top bars (defaults to 0)
        onScroll: function () { 
          // callback on scroll start
        },
        scrollEnd: function () { 
          // callback on scroll end
        }
    });

    var hide_menu = false;
    var mouse_event = false;
    var oldX = oldY = 0;

    $(document).mousemove(function(e) {
        if(oldX == 0) {
            oldX = e.pageX;
            oldY = e.pageY;
        }

        if(oldX != e.pageX || oldY != e.pageY) {
            mouse_event = true;
        }
    });

    // 주메뉴
    var $gnb = $(".gnb_1dli > a");
    $gnb.mouseover(function() {
        if(mouse_event) {
            $(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2 gnb_1dli_on");
            $(this).parent().addClass("gnb_1dli_over gnb_1dli_on");
            menu_rearrange($(this).parent());
            hide_menu = false;
        }
    });

    $gnb.mouseout(function() {
        hide_menu = true;
    });

    $(".gnb_2dli").mouseover(function() {
        hide_menu = false;
    });

    $(".gnb_2dli").mouseout(function() {
        hide_menu = true;
    });

    $gnb.focusin(function() {
        $(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2 gnb_1dli_on");
        $(this).parent().addClass("gnb_1dli_over gnb_1dli_on");
        menu_rearrange($(this).parent());
        hide_menu = false;
    });

    $gnb.focusout(function() {
        hide_menu = true;
    });

    $(".gnb_2da").focusin(function() {
        $(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2 gnb_1dli_on");
        var $gnb_li = $(this).closest(".gnb_1dli").addClass("gnb_1dli_over gnb_1dli_on");
        menu_rearrange($(this).closest(".gnb_1dli"));
        hide_menu = false;
    });

    $(".gnb_2da").focusout(function() {
        hide_menu = true;
    });

    $('#gnb_1dul>li').bind('mouseleave',function(){
        submenu_hide();
    });

    $(document).bind('click focusin',function(){
        if(hide_menu) {
            submenu_hide();
        }
    });

    // 폰트 리사이즈 쿠키있으면 실행
    var font_resize_act = get_cookie("ck_font_resize_act");
    if(font_resize_act != "") {
        font_resize("container", font_resize_act);
    }
});

function submenu_hide() {
    $(".gnb_1dli").removeClass("gnb_1dli_over gnb_1dli_over2 gnb_1dli_on");
}

function menu_rearrange(el)
{
    var width = $("#gnb_1dul").width();
    var left = w1 = w2 = 0;
    var idx = $(".gnb_1dli").index(el);

    for(i=0; i<=idx; i++) {
        w1 = $(".gnb_1dli:eq("+i+")").outerWidth();
        w2 = $(".gnb_2dli > a:eq("+i+")").outerWidth(true);

        if((left + w2) > width) {
            el.removeClass("gnb_1dli_over").addClass("gnb_1dli_over2");
        }

        left += w1;
    }
}

</script>

</body>

</html>