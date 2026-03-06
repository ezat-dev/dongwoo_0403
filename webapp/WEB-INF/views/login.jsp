<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/chunil/css/login/basic_v7.css">
    <link rel="stylesheet" href="/chunil/css/login/login.css">

<style>
    .login_box {
        display: flex;
        align-items: center;
    }
    
    .notice{

    }
    
    .login{
 margin-left: auto !important;
    }
    
    .tit{
    font-size: 30px !important;
    }
    
    
.logo img {
/*     position: relative;
    top: 100;
    margin-top: 230px;
    margin-left: 556px;
    left: 0; */
    width: 250px;
    height: 150px;
}

.login_gw7 .login_container .header .logo img {
    vertical-align: top;
    height: 149px;
}
.login_container .header .logo img {
    vertical-align: top;
    position: relative;
}
.logo img {
    margin-left: -22px;
    width: 250px;
    height: 150px;
}
.login_gw7 .login_container {
    position: absolute;
    top: 45%;
    left: 50%;
    width: 820px;
    margin: -360px 0 0 -410px;
}
</style>

</head>
	
	<body id="login_body" class="layout_ex " onload="">
    
<div id="wrap_login" class="login_gw7">

	<div class="login_container">
		<div class="header">
	
		
			<div class="logo"><img id="login_img_logo" src="/chunil/css/login/logo2.png" alt=""></div>
		
		
		</div>
		<hr class="hide">
		<div class="content" id="login_layout_content">
			<div id="login_imgbox" class="visual_box">
				<img id="login_img_loginBanner" src="/chunil/css/login/vt2.jpg" alt="">
			</div>
			<div class="login_box">
				<div class="notice">
					<div class="tit_bar">
				<!--		<h3 class="tit">프로그램 수정중입니다</h3>
				 		<h3 class="tit">페이지 소제목 변경</h3> -->
					</div>
					<ul id="login_noticeCont_ul" class="bu_lst">
					</ul>
				</div>
				<div class="login">
				    <form id="userForm" class="omb_loginForm" role="form" 
    				action="login_ok.jsp" method="post" onsubmit="return false">
						<div class="login_frm">
							
							<div id="login_loginBox">
								<ul id="loginIdType1" class="ip_box">
									<li class="info id">
								    <label class="input_txt">
								        <input id="userId" name="user_id" class="input_id" type="text" autocomplete="off" placeholder="ID ">
								        <i class="ico ico_login-id"></i>
								    </label>
								</li>
								<li class="info pw">
								    <label class="input_txt">
								        <input id="password" name="user_pw" type="password" autocomplete="new-password" class="input_pw" placeholder="PW ">
								        <i class="ico ico_login-pw"></i>
								    </label>
								</li>

								</ul>
							</div>
							<div class="btn_login">
								<button id="btnLogin" data-text="Login" >
									<span>L</span><span>o</span><span>g</span><span>i</span><span>n</span>
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$("#userForm").on("submit", function (e) {
    e.preventDefault();
    login();
});

function login() {
    var userData = new FormData($("#userForm")[0]);

    $.ajax({
        url: "/chunil/user/login/check",
        type: "post",
        contentType: false,
        processData: false,
        dataType: "json",
        data: userData,
        success: function(result) {

            if (result.data && result.data.user_code) {

                // ✅ 로그인 성공 이력 남기기
                saveLoginLog(result.data.user_code);

                // 메인 이동
                location.href = "/chunil/main";

            } else {
                alert("로그인 실패! 사용자 정보가 잘못되었습니다.");
            }
        },
        error: function() {
            alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
}

function saveLoginLog(userCode) {
    $.ajax({
        url: "/chunil/user/login/log",
        type: "post",
        data: {
            user_code: userCode,
            memo: "로그인 성공"
        }
    });
}
</script>

</body>
</html>