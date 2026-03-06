<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/tkheat/css/login/style.css">
  
  <style>
   a,
   button,
   input,
   select,
   h1,
   h2,
   h3,
   h4,
   h5,
   * {
       box-sizing: border-box;
       margin: 0;
       padding: 0;
       border: none;
       text-decoration: none;
       background: none;
   
       -webkit-font-smoothing: antialiased;
   } 
   
   menu, ol, ul {
       list-style-type: none;
       margin: 0;
       padding: 0;
   }
   </style>
  <title>Document</title>
</head>
<body>
  <div class="group-1">
    <div class="main"></div>
    <img class="background-1" src="/tkheat/css/login/background-10.png" />
    <div class="login-box"></div>
    
    <div class="id-input"></div>
    <div class="pw-input"></div>
    <div class="text-1">이 사이트는 태경열처리 임직원 전용입니다.</div>
    <div class="text-2">주소 경남 함안군 군북면 함안산단 3 길 34</div>
    <input type="text" id="n_id" name="n_id" placeholder="아이디를 입력하세요." />
    <input type="password" id="n_pw" name="n_pw" placeholder="비밀번호를 입력하세요." />
    <button class="login_btn" onclick="login();">로그인</button>
    <div class="text-5">아이디</div>
    <div class="text-6">패스워드</div>
    <img class="logo" src="/tkheat/css/login/logo0.svg" />
    <div class="text-4">태경열처리 로그인</div>
    <div class="text-3">
      Copyright 2025. EZAutomation Co. All rights reserved.
    </div>
  </div>
  
  
  <script>

  function login(){
		var id = $("#u_id").val();
		var pw = $("#u_pw").val();

		$.ajax({
			url:"/info/login",
			type:"post",
			data:{u_id:id, u_pw:pw},
			success:function(result){
				if(result == "fail"){
					modal_alert();
				}else if(result == "success"){
					location.href="/info/userRegister";
				}
			}
		});
	}
	



//모달
	function modal_alert(){
		_modal = modal({
			type:"primary",
			title:"로그인 알림창",
			text:"아이디와 비밀번호를 확인해주십시오!",
			size:"small",
			autoclose:false,					//모달창이 생기고 자동으로 닫히지 않게
			closeClick:false,
			background: 'rgba(0,0,0,0.35)',
			buttons: [{
				text: '닫 기', //Button Text
				val: 'ok', //Button Value
				eKey: true, //Enter Keypress
				addClass: 'btn-light-blue btn-square', //Button Classes (btn-large | btn-small | btn-green | btn-light-green | btn-purple | btn-orange | btn-pink | btn-turquoise | btn-blue | btn-light-blue | btn-light-red | btn-red | btn-yellow | btn-white | btn-black | btn-rounded | btn-circle | btn-square | btn-disabled)
				onClick: function(argument) {
//					console.log(argument);
					_modal.close();
//					alert('Look in console!');

				}
			}, ]
		});
	}

  </script>
</body>
</html>