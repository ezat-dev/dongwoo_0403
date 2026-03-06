<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="/chunil/css/login/style.css">

	<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>  
	<link rel="stylesheet" href="/chunil/css/sideBar/styles.css">
	<link rel="stylesheet" href="/chunil/css/login/style2.css">
	<link rel="stylesheet" href="/chunil/css/headerBar/headerBar.css">
<%@include file="../include/pluginpage.jsp" %>
  
<title>천일정밀</title>
</head>

<style>
	
	* {
	    font-weight: 600;
	    font-family: 'Pretendard', sans-serif;
	    box-sizing: border-box;
	}
	
	body {
	    background-color: #f4f6f9;
	}
	
	
	.row_select {
	    background-color: #9ABCEA !important;
	}
	
	
	.menuDiv {
	    display: flex;
	    align-items: center;
	    width: 92.7%;
	    height: 42px;
	    
	    margin-left: 131px;
	    padding: 8px 14px;
	    border-radius: 14px;
	    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.12);
	    overflow-x: auto;
	    white-space: nowrap;
	    gap: 8px;  /* 탭 간격 좁히기 */
	    scrollbar-width: none;
	    -ms-overflow-style: none;
	}
	
	.menuDiv::-webkit-scrollbar {
	    display: none;
	}
	
	
	.menuDivTab {
	    text-align: center;
	    cursor: pointer;
	    background: #dfe6ed;
	    border-radius: 10px;
	    padding: 12px 18px;
	    font-size: 14px;
	    font-weight: 700;
	    color: #333;
	    border: 1px solid #ddd;
	    transition: all 0.3s ease-in-out;
	    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
	    user-select: none;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    gap: 6px;
	    min-width: 100px;  
	    height: 43px;
	}
	
	.menuDivTab:hover {
	    background: #f0f2f5;
	    transform: translateY(-2px);
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
	}
	.tkLogo {
    width: 180px;
    height: 50px;
}
	.menuDivTab.active {
		background: white; /* 연한 회색 배경 */
	    color: #333; /* 글자색은 기본 유지 */
	    border: 1px solid #ccc;
	    box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
	    transform: translateY(-2px);
	}
	
	
	.menuDivTab i {
	    font-size: 16px;
	    color: inherit;
	}
	
	
	.menuDivTab .close-btn {
	    font-size: 19px; 
	    background: none;
	    border: none;
	    color: #888; 
	    cursor: pointer;
	    padding: 0;
	    margin-left: 10px;
	    display: flex;
	    align-items: center; 
	    justify-content: center;
	    transition: color 0.2s ease-in-out;
	}

	
	.menuDivTab .close-btn:hover {
	    color: #ff3b30; 
	}
	
	
	.frameDiv {
	    display: flex;
	    width: 92.7%;
	    height: 90%;
	    background: white;
	    margin-left: 131px;
	    border-radius: 14px;
	    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
	    overflow: hidden;
	}
	
	.frameDiv #pageFrame {
	    width: 100%;
	    height: 100%;
	    border: none;
	}
</style>

<body>

    <header class="header">
	    <p class="headerP" style="font-size:20px; margin-left:40px; color : white; font-weight:800;"></p>
	    <!-- 로그인정보 표현, 로그아웃 버튼 -->
	    <p class="loginName" style="font-size:20px; margin-left:960px; color : white; font-weight:800;"></p>
        <button class="logout-button">
            <img src="/chunil/css/headerBar/exit-outline.svg" alt="select" class="button-image">로그아웃	           
        </button>
    </header>

    <div class="hhhh"></div>
    <div class="l-navbar" id="navbar" style="overflow-y: auto;">
        <nav class="nav">
            <div>
			<div class="nav__brand">
			    <a href="#" class="nav__logo" onclick="openWorkMonitoring(); return false;">
			        <img class="tkLogo" src="/chunil/css/login/123.png">
			    </a>
			</div>
			<div class="nav__list">
<!--  a1 ~ a7 -->
			<div class="nav__link collapse">
				<ion-icon name="folder-outline" class="nav__icon"></ion-icon>
				<span class="nav_name">기준정보</span>
				<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
				<ul class="collapse__menu" id="aMenu"></ul>
			</div>
<!--  b1 ~ b7 -->
			<div class="nav__link collapse">
				<ion-icon name="folder-outline" class="nav__icon"></ion-icon>
				<span class="nav_name">모니터링</span>
				<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
				<ul class="collapse__menu" id="bMenu"></ul>
			</div>
<!--  c1 ~ c7 -->
			<div class="nav__link collapse">
				<ion-icon name="folder-outline" class="nav__icon"></ion-icon>
				<span class="nav_name">생산관리</span>
				<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
				<ul class="collapse__menu" id="cMenu"></ul>
			</div>
<!--  d1 ~ d7 -->
			<div class="nav__link collapse">
				<ion-icon name="desktop-outline"></ion-icon>
				<span class="nav_name">조건관리</span>
				<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
				<ul class="collapse__menu" id="dMenu"></ul>
			</div>
<!--  e1 ~ e7 -->
			<div class="nav__link collapse">
				<ion-icon name="folder-outline" class="nav__icon"></ion-icon>
				<span class="nav_name">품질관리</span>
				<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
				<ul class="collapse__menu" id="eMenu"></ul>
			</div>
			<div class="nav__link collapse">
				<ion-icon name="folder-outline" class="nav__icon"></ion-icon>
				<span class="nav_name">설비관리</span>
				<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
				<ul class="collapse__menu" id="fMenu"></ul>
			</div>

		
		</div>
	</div>
</nav>
    </div>
    
    <div class="menuDiv"></div>
    <div class="frameDiv">
		 <iframe id="pageFrame" src="/chunil/monitoring/workMonitoring" frameborder="0" width="100%" height="100%"></iframe>
    </div>
   <script>
     //로드
     
     
      
      $(document).on('click', '.menuDivTab', function () {
        // 기존 active 클래스 제거
        $('.menuDivTab').removeClass('active');

        // 현재 클릭된 탭에 active 클래스 추가
        $(this).addClass('active');
    });
     $(function(){
 		var loginInfo = "${loginUser.user_name}";


		$(".loginName").text(loginInfo+"님 로그인");
		loginUserMenuSetting();
		menuList();
		
     });
     
    //이벤트
   	$(".logout-button").on("click",function(){
   		$.ajax({
   			url:"/chunil/user/logout",
   			type:"get",
   			dataTypa:"json",
   			success:function(result){
   				location.href = "/chunil";
   			}
   		});
   	});    
     
     
    //함수
	function loginUserMenuSetting(){
		$.ajax({
			url:"/chunil/user/login/menuSetting",
			type:"post",
			dataType:"json",
			success:function(result){

				var data = result.data;
				var idx = 0;
				var user_code = 0;
				for(let key in data){
//					console.log(key);
					if(key == "user_code"){
						user_code = data[key];
					}
					
					

					if(key != "perm_code" && key != "user_code"){
						if(data[key] != null && data[key] != "N"){
							//console.log(data[key]);
							//console.log(pageObject(key));
							var _link = pageObject(key)[0];
							var _name = pageObject(key)[1];
							
							var _group = "";
							var _groupID = "";

							if(key.indexOf("a") != -1){
								_group = "기준정보";
								_groupID = "aMenu";
							}else if(key.indexOf("b") != -1){
								_group = "모니터링";
								_groupID = "bMenu";
							}else if(key.indexOf("c") != -1){
								_group = "생산관리";
								_groupID = "cMenu";
							}else if(key.indexOf("d") != -1){
								_group = "조건관리";
								_groupID = "dMenu";
							}else if(key.indexOf("e") != -1){
								_group = "품질관리";
								_groupID = "eMenu";
							}else if(key.indexOf("f") != -1){
								_group = "설비관리";
								_groupID = "fMenu";
							}/*else if(key.indexOf("g") != -1){
								_group = "취출 운전관리";
								_groupID = "gMenu";
							}else if(key.indexOf("h") != -1){
								_group = "설비관리";
								_groupID = "hMenu";
							}else if(key.indexOf("i") != -1){
								_group = "문서관리";
								_groupID = "iMenu";
							}else if(key.indexOf("j") != -1){
								_group = "AGV관리";
								_groupID = "jMenu";
							}else if(key.indexOf("k") != -1){
								_group = "세척관리";
								_groupID = "kMenu";
							} */
							
							if(key == "e03"){
								
							}
							
							_group_t = _group.replace(/\s/gi,"&nbsp;");
							_name_t = _name.replace(/\s/gi,"&nbsp;");
//							console.log(_group_t, _name_t);
							var _menu = "<li>";
							_menu += "<a class='collapse__sublink' onClick=updateHeaderAndNavigate(event,'"+_link+"','"+_name_t+"','"+_group_t+"');>"+_name+"</a>"
							_menu += "</li>";
							
							$("#"+_groupID).append(_menu);
							if(idx == 0){
//								iframeSrc(_link,(_group+"-"+_name));
							}
							idx++;
						}
					}
				}				
			}
		});
    }
    	function openWorkMonitoring() {
	    document.getElementById("pageFrame").src = "/chunil/monitoring/workMonitoring";
	}

   	function iframeSrc(url, menuGroupName){
   		$("#pageFrame").attr("src",url);
   		$(".headerP").text(menuGroupName);
   	}
    
        // 메뉴 클릭 시 헤더 업데이트
	function updateHeader(menuGroupName) {
//		document.getElementById('header-title').innerText = menuName;
	}


    // 메뉴 닫기 x
	function updateHeaderAndNavigate(event, url, menuGroupName) {
		  event.preventDefault(); 
		  event.stopPropagation();  // 이벤트 전파 차단 (부모로 클릭 이벤트 안 전달)
		  
		  iframeSrc(url, menuGroupName);
		  var loginCode = "${loginUser.user_code}";
		  var menuUrl = url;
		  var menuName = menuGroupName;

		  menuSave(loginCode, menuUrl, menuName);
		}
        
	function menuSave(loginCode, menuUrl, menuName){
		$.ajax({
			url:"/chunil/user/login/menuSave",
			type:"post",
			dataType:"json",
			data:{
				"user_code":loginCode,
				"menu_url":menuUrl,
				"menu_name":menuName
			},
			success:function(result){     			
				menuList();
			}
		});
	}
	
	function menuList(){
	    var loginCode = "${loginUser.user_code}";
	    
	    $.ajax({
	        url:"/chunil/user/login/menuList",
	        type:"post",
	        dataType:"json",
	        data:{
	            "user_code":loginCode
	        },
	        success:function(result){
	            var data = result.data;
	            var _div = "";
	            $(".menuDiv").empty();
	            
	            for(let key in data){
	                var menuName = data[key].menu_name;
	                var menuNameIndex = (data[key].menu_name).indexOf("-")+1;
	                
	                menuName = menuName.substring(menuNameIndex,menuName.length);                
	                menuName = menuName.replace("/\s/g","&nbsp;");

	                _div = "<div class='menuDivTab' onClick=iframeSrc('"+data[key].menu_url+"','"+menuName+"')>";
					_div += "<label class='menuName' onClick=iframeSrc('"+data[key].menu_url+"','"+menuName+"')>" + menuName + "</label>";
	                _div += "<button class='close-btn' onClick=removeMenu('"+data[key].menu_url+"')>×</button>";
	                _div += "</div>";

	                $(".menuDiv").append(_div);
	            }
	        }
	    });
	}



	
    // DOMContentLoaded 이벤트로 DOM이 준비된 후 스크립트 실행
  document.addEventListener('DOMContentLoaded', function () {
  const collapseItems = document.querySelectorAll('.nav__link.collapse');

  collapseItems.forEach(item => {
    item.addEventListener('click', function () {
      const collapseMenu = this.querySelector('.collapse__menu');
      const icon = this.querySelector('.collapse__link');

      // 펼침 상태 토글
      collapseMenu.classList.toggle('showCollapse');

      // 아이콘 회전
      icon.classList.toggle('rotate');
    });
  });
});




    
/*
    //상단 메뉴 삭제
function removeMenu2(button) {
    var loginCode = "${loginUser.user_code}";


    var label = $(button).siblings('.menuName');
    var onclickAttr = label.attr('onclick');
    var match = onclickAttr.match(/iframeSrc\('([^']+)'/);
    var menuUrl = match ? match[1] : null;

    console.log("user_code:", loginCode);
    console.log("menu_url:", menuUrl);

    if (!menuUrl) {
        console.error("삭제할 메뉴의 URL이 없습니다.");
        return;
    }

    $.ajax({
        url: "/geomet/user/login/menuRemove",
        type: "post",
        dataType: "json",
        data: {
            "user_code": loginCode,
            "menu_url": menuUrl
        },
        success: function(result) {
            menuList();
        }
    });

    var menuName = label.text().trim(); 
    console.log(menuName + " 메뉴 엑스.");

    $(button).parent().remove();
    }
*/



function removeMenu(url) {
	var loginCode = "${loginUser.user_code}";		   

	   
   $.ajax({
	  url:"/chunil/user/login/menuRemove",
	  type:"post",
	  dataType:"json",
	  data:{
		  "user_code":loginCode,
		  "menu_url":url},
	  success:function(result){
		  menuList();
	  }
   });
/*
   console.log(button);
   
   var menuName = $(button).siblings('.menuName').text(); 
   console.log(menuName + " 메뉴 엑스 .");

   $(button).parent().remove();
*/
}	



    
/*
    //상단 메뉴 삭제
function removeMenu2(button) {
    var loginCode = "${loginUser.user_code}";


    var label = $(button).siblings('.menuName');
    var onclickAttr = label.attr('onclick');
    var match = onclickAttr.match(/iframeSrc\('([^']+)'/);
    var menuUrl = match ? match[1] : null;

    console.log("user_code:", loginCode);
    console.log("menu_url:", menuUrl);

    if (!menuUrl) {
        console.error("삭제할 메뉴의 URL이 없습니다.");
        return;
    }

    $.ajax({
        url: "/chunil/user/login/menuRemove",
        type: "post",
        dataType: "json",
        data: {
            "user_code": loginCode,
            "menu_url": menuUrl
        },
        success: function(result) {
            menuList();
        }
    });

    var menuName = label.text().trim(); 
    console.log(menuName + " 메뉴 엑스.");

    $(button).parent().remove();
    }
*/



function removeMenu(url) {
	var loginCode = "${loginUser.user_code}";		   

	   
   $.ajax({
	  url:"/chunil/user/login/menuRemove",
	  type:"post",
	  dataType:"json",
	  data:{
		  "user_code":loginCode,
		  "menu_url":url},
	  success:function(result){
		  menuList();
	  }
   });
/*
   console.log(button);
   
   var menuName = $(button).siblings('.menuName').text(); 
   console.log(menuName + " 메뉴 엑스 .");

   $(button).parent().remove();
*/
}	

        
    </script>
    
    
</body>
</html>