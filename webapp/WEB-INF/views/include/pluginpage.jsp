<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<!-- 제이쿼리홈페이지 js -->
<script type="text/javascript" src="/chunil/js/jquery-3.7.1.min.js"></script>

<!-- Tabulator 테이블 -->
<script type="text/javascript" src="/chunil/js/tabulator/tabulator.js"></script>
<link rel="stylesheet" href="/chunil/css/tabulator/tabulator_simple.css">
<!-- XLSX 라이브러리 (엑셀 다운로드용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<!-- moment -->
<script type="text/javascript" src="/chunil/js/moment/moment.min.js"></script>

<!-- 화면캡쳐용 -->
<script type="text/javascript" src="/chunil/js/html2canvas.js"></script>


<!-- 하이차트 -->
<script type="text/javascript" src="/chunil/js/highchart/highcharts.js"></script>
<script type="text/javascript" src="/chunil/js/highchart/exporting.js"></script>
<script type="text/javascript" src="/chunil/js/highchart/export-data.js"></script>
<script type="text/javascript" src="/chunil/js/highchart/data.js"></script>


<!-- Air Datepicker -->
<script type="text/javascript" src="/chunil/js/airdatepicker/datepicker.min.js"></script>
<script type="text/javascript" src="/chunil/js/airdatepicker/datepicker.ko.js"></script>
<link rel="stylesheet" href="/chunil/css/airdatepicker/datepicker.min.css"> 

<!-- fontawsome -->
<link rel="stylesheet" href="/chunil/css/fontawsome/font-awesome.min.css">
<style>

	
	#excelOverlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 9998;
}

#excelLoading {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: white;
    padding: 30px 50px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
    z-index: 9999;
    font-size: 16px;
    text-align: center;
    font-weight: bold;
}

</style>



<div id="excelOverlay"></div>
<div id="excelLoading">엑셀 기능 진행 중 입니다.<br>잠시만 기다려주세요...</div>

<script>

$(function(){

	rpImagePopup();

	//airDatePicker 설정
	//날짜 : 일
	 $(".daySet").datepicker({
    	language: 'ko',
    	autoClose: true,
    }); 


	 $(".datetimeSet").datepicker({
		    language: 'ko',
		    timepicker: true,            // 시분 선택 가능
		    dateFormat: 'yyyy-mm-dd',
		    timeFormat: 'hh:ii',         // 시:분 형식
		    autoClose: true
		});
	    
	//날짜 : 월
   $(".monthSet").datepicker({
	    language: 'ko',           // 한국어 설정
	    view: 'months',           // 월만 표시
	    minView: 'months',        // 월만 선택 가능
	    dateFormat: 'yyyy-mm',    // 연도-월 형식 지정
	    autoClose: true,          // 월 선택 후 자동 닫힘
	});
   

    //날짜 : 년
	 $(".yearSet").datepicker({
	  language: 'ko',
      view: 'years',          // 연도만 표시
      minView: 'years',       // 연도만 표시하여 날짜 선택 비활성화
      dateFormat: 'yyyy',     // 연도 형식 지정
      autoClose: true,        // 연도 선택 후 자동 닫힘
      language: 'ko'          // 한국어 설정
  });

	 $(".monthDaySet").datepicker({
		    language: 'ko',
		    autoClose: true,
		    dateFormat: 'mm-dd',     // 📌 "월-일" 형식만 표시
		    view: 'days',            // 기본 day 뷰 사용
		    minView: 'days',         // day까지만 표시
		    onShow: function(inst, animationCompleted){
		        // 연도, 월 선택 영역 숨김 (디자인적으로)
		        $('.datepicker--nav-title i, .datepicker--nav-title span').hide();
		    }
		});

/*
   // AirDatepicker 초기화
   new AirDatepicker('.datepicker', {
       autoClose: true,
       dateFormat: 'yyyy-MM-dd',
       locale: {
           days: ['일', '월', '화', '수', '목', '금', '토'],
           daysShort: ['일', '월', '화', '수', '목', '금', '토'],
           daysMin: ['일', '월', '화', '수', '목', '금', '토'],
           months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
           monthsShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
           today: '오늘',
           clear: '초기화',
           firstDay: 0
       },
       // 일, 월, 년을 선택할 수 있게 하기 위한 설정
       view: 'days',  // 일, 월, 년 선택을 가능하게 함
       minView: 'days', // 날짜만 선택 가능
   });
*/
		
});







//오늘날짜 년-월-일
function todayDate(){
	var now = new Date();
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 
}


//오늘날짜 년-월-일
function todayMonth(){
	var now = new Date();
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m; 
}



//어제날짜 년-월-일
function yesterDate(){
	var now = new Date();	
	now.setDate(now.getDate() - 1);
	
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 	
}

//현재시간
function nowTime(){
	var now = new Date();
	var h = paddingZero(now.getHours());
	var m = paddingZero(now.getMinutes());
	var s = paddingZero(now.getSeconds());
		
	return h+":"+m+":"+s; 
}

//현재시간 +2
function nowTimeAftertwo(){
	var now = new Date();
	now.setHours(now.getHours()+2);
	var h = paddingZero(now.getHours());
	var m = paddingZero(now.getMinutes());
	var s = paddingZero(now.getSeconds());
		
	return h+":"+m+":"+s; 
}

//트렌드 시작시간
function trendStime(){
	var now = new Date();
	now.setHours(now.getHours() - 8);
	
	var ye = now.getFullYear();
	var mo = paddingZero(now.getMonth()+1);
	var da = paddingZero(now.getDate());
	
	var ho = paddingZero(now.getHours());
	var mi = paddingZero(now.getMinutes());
		
	return ye+"-"+mo+"-"+da+" "+ho+":"+mi; 
}

//트렌드 종료시간
function trendEtime(){
	var now = new Date();
	var ye = now.getFullYear();
	var mo = paddingZero(now.getMonth()+1);
	var da = paddingZero(now.getDate());
	
	var ho = paddingZero(now.getHours());
	var mi = paddingZero(now.getMinutes());
		
	return ye+"-"+mo+"-"+da+" "+ho+":"+mi; 
}

//1년 전
function oneYearBeforeDate(){
	var now = new Date();	
	now.setYear(now.getFullYear() -1);
	
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 	
}

//1년 뒤
function oneYearAfterDate(){
	var now = new Date();	
	now.setYear(now.getFullYear() + 1);
	
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d;
}


//왼쪽 0채우기
function paddingZero(value){
	var rtn = "";

	if(value < 10){
		rtn = "0"+value;
	}else{
		rtn = value;
	}

	return rtn;
}


function rpImagePopup() {
    var img = document.createElement("img");
//    console.log(img);
    
    // $(img).attr("src", "imgs/noimage_01.gif");
    $(img).css("width", "600");
    $(img).css("height", "500");
    
    var div = document.createElement("div");
    $(div).css("position", "absolute");
    $(div).css("display", "none");
    $(div).css("z-index", "24999");
    $(div).append(img);
    $(div).hide();
    $("body").append(div);

    $(document).on("mouseover", ".rp-img-popup > img", function(){
            $(img).attr("src", $(this).attr("src"));
            $(div).show();
            var iHeight = (document.body.clientHeight / 2) - $(img).height() / 2 + document.body.scrollTop;   // 화면중앙
            var iWidth = (document.body.clientWidth / 2) - $(img).width() / 2 + document.body.scrollLeft;
            $(div).css("left", iWidth);
            $(div).css("top", 100);
        })
        .on("mouseout", ".rp-img-popup > img", function(){
            $(div).hide();
        });
    
    $(document).on("mouseover", ".rp-img-popup", function(){
        $(img).attr("src", $(this).attr("src"));
        $(div).show();
        var iHeight = (document.body.clientHeight / 2) - $(img).height() / 2 + document.body.scrollTop;   // 화면중앙
        var iWidth = (document.body.clientWidth / 2) - $(img).width() / 2 + document.body.scrollLeft;
        $(div).css("left", iWidth);
        $(div).css("top", 100);
    })
    .on("mouseout", ".rp-img-popup", function(){
        $(div).hide();
    });
}

/*
function pageObject(paramKey){
	//console.log("받은 키값 : "+paramKey);
	var obj = {
			//모니터링
			"a01":["/chunil/monitoring/integrationMonitoring","통합 모니터링"],
			"a02":["/chunil/monitoring/trend","트랜드"],
			"a03":["/chunil/monitoring/alarm","알람현황"],
			"a04":["/chunil/monitoring/workMonitoring","작업현황"],
			"a05":"",
			"a06":"",
			"a07":"",
			//생산관리
			"b01":["/chunil/productionManagement/integrationProduction","종합 생산현황"],
			"b02":["/chunil/productionManagement/machineEfficiency","설비 효율현황"],
			"b03":["/chunil/productionManagement/alarmRecord","알람이력"],
			"b04":["/chunil/productionManagement/alarmFrequency","알람발생빈도"],
			"b05":["/chunil/machine/spareStatus","SPARE 관리"],
			"b06":["/chunil/productionManagement/heatTreatment","열처리 작업이력"],
			"b07":["/chunil/productionManagement/droppedGoods","낙하품관리"],
			//조건관리
			"c01":["/chunil/condition/standardData","기준정보관리"],
			//열전데 온도조절계 낙하품
			"c02":["/chunil/condition/thermocoupleChange","열전대 교체이력"],
			"c03":["/chunil/condition/tempCorrection","온도조절계 보정현황"],
			"c04":["/chunil/condition/dailyCheck","일상점검일지"],
			"c05":["/chunil/condition/standardDoc","관리계획서 및 작업 표준서"],
			"c06":"",
			"c07":"",
			//품질관리
			"d01":["/chunil/quality/tusTest","온도균일성 조사보고서"],
			"d02":["/chunil/quality/heatTreatingOil","열처리유 성상분석"],
			"d03":["/chunil/quality/fProof","F/PROOF"],
			"d04":["/chunil/quality/cpk","Cpk"],
			"d05":["/chunil/quality/ppk","Ppk"],
			"d06":["/chunil/quality/machineManage","설비 보전관리"],
			"d07":["/chunil/quality/sat","열전대 비교검증"],
			//기준관리
			"e01":["/chunil/standard/nonTime","비가동현황"],
			"e02":["/chunil/user/userInsert","사용자등록"],
			"e03":["/chunil/user/userPermission","사용자 권한"],
			"e04":["/chunil/standard/customer","거래처 관리"],
			"e05":["/chunil/standard/product","제품 관리"],
			"e06":["/chunil/standard/recipe","레시피 관리"],
			"e07":"",

			//======안씀 여분
			"f01":"",
			"f02":"",
			"f03":"",
			"f04":"",
			"f05":"",
			"f06":"",
			"f07":"",
			"g01":"",
			"g02":"",
			"g03":"",
			"g04":"",
			"g05":"",
			"g06":"",
			"g07":"",

			
	};
	

	//console.log(obj);
	//console.log(obj[paramKey][0]);
	
	return obj[paramKey];
}
*/

function pageObject(paramKey){
	//console.log("받은 키값 : "+paramKey);
	var obj = {
			//기준정보
			"a01":["/chunil/user/userInsert","사용자관리"],
			"a02":["/chunil/standard/customer","거래처관리"],
			"a03":["/chunil/standard/product","제품관리"],
			"a04":["/chunil/standard/recipe","패턴관리"],
			"a05":["/chunil/user/userPermission","사용자권한부여"],
			"a06":["/chunil/user/login_log","로그인이력"],
			"a07":"",
			//모니터링
			"b01":["/chunil/monitoring/integrationMonitoring","통합모니터링"],
			"b02":["/chunil/productionManagement/alarmRecord","알람이력"],
			"b03":["/chunil/productionManagement/alarmFrequency","알람랭킹"],
			"b04":["/chunil/monitoring/trend","온도경향감시"],
			
			"b05":["/chunil/monitoring/lot","LOT현황"],
			"b06":["/chunil/monitoring/lotProcessor","LOT트레킹"],
			"b07":"",
			//생산관리
			"c01":["/chunil/productionManagement/heatTreatment","작업지시관리"],
			"c02":["/chunil/monitoring/workMonitoring","종합생산현황"],
			"c03":["/chunil/productionManagement/machineEfficiency","설비효율현황"],
			
			"c04":["/chunil/productionManagement/productWork","제품별작업관리"],
			"c05":["/chunil/productionManagement/repairHistory","수리이력관리"],
			"c06":["/chunil/productionManagement/workReport","작업일보"],
			"c07":["/chunil/productionManagement/lot_report","LOT보고서"],
			//조건관리
			"d01":["/chunil/condition/thermocoupleChange","열전대교체이력"],
			"d02":["/chunil/condition/tempCorrection","온도조절계보정현황"],
			"d03":["/chunil/quality/heatTreatingOil","열처리유성상분석"],

			"d04":["/chunil/condition/dailyCheck","일상점검일지"],
			"d05":["/chunil/condition/standardDoc","관리계획서 및 작업 표준서"],
			"d06":"",
			"d07":"",
			//품질관리
			"e01":["/chunil/quality/cpk","Cpk 분석"],
			"e02":["/chunil/quality/ppk","Ppk 분석"],
			"e03":["/chunil/quality/fProof","E/PROOF"],
			"e04":["/chunil/quality/tusTest","온도균일성조사보고서"],
			"e05":["/chunil/productionManagement/droppedGoods","낙하품 관리"],
			"e06":["/chunil/quality/hardness","경도 관리"],
			"e07":["/chunil/productionManagement/noProduct","부적합품 관리"],
			//설비관리
			"f01":["/chunil/standard/nonTime","설비비가동현황"],
			"f02":["/chunil/machine/spareStatus","SPARE부품관리"],
			"f03":["/chunil/quality/machineManage","설비이력관리"],
			"f04":["/chunil/machine/equipmentRate","설비 가동률 분석"],
			"f05":"",
			"f06":"",
			"f07":"",
			"g01":"",
			"g02":"",
			"g03":"",
			"g04":"",
			"g05":"",
			"g06":"",
			"g07":"",

			
	};

	return obj[paramKey];
}


let userPermissions = {};

function userInfoList(now_page_code) {
    $.ajax({
        url: '/chunil/user/info',
        type: 'POST',
        contentType: 'application/json',
        dataType: 'json',
        success: function(response) {
            const loginUserPage = response.loginUserPage;
            userPermissions = loginUserPage || {};
            controlButtonPermissions(now_page_code);
            // 권한 세팅 후 핸들러 설치 (중복 호출 방지 내부 처리됨)
            installTabulatorReadOnlyHandlers();
        },
        error: function(xhr, status, error) {
            console.error("데이터 가져오기 실패:", error);
            // 그래도 핸들러는 설치해 둡니다(나중에 권한이 세팅되면 동작).
            installTabulatorReadOnlyHandlers();
        }
    });
}
function controlButtonPermissions(now_page_code) {
    const permission = userPermissions?.[now_page_code];
  //  console.log("현재 페이지 권한(permission):", permission);

    window.currentPermission = permission; // "R", "C", "D" 등
    window.canRead = permission === "R" || permission === "C" || permission === "D";
    window.canCreate = permission === "C" || permission === "D";
    window.canDelete = permission === "D";


    if (!window.canRead) {
        $(".select-button").css("pointer-events", "none").css("background-color", "#ced4da");
    }

    if (!window.canCreate) {
        $(".insert-button").css("pointer-events", "none").css("background-color", "#ced4da");
        $("#corrForm").prop("disabled", true);
    }

    if (!window.canDelete) {
        $(".delete-button").css("pointer-events", "none").css("background-color", "#ced4da");
    }

    $(".select-button").off("click.permissionCheck").on("click.permissionCheck", function (e) {
        if (!window.canRead) {
            alert("당신의 권한이 없습니다. (조회)");
            e.preventDefault();
            e.stopImmediatePropagation();
        }
    });

    $(".insert-button").off("click.permissionCheck").on("click.permissionCheck", function (e) {
        if (!window.canCreate) {
            alert("당신의 권한이 없습니다. (추가)");
            e.preventDefault();
            e.stopImmediatePropagation();
        }
    });

    $(".delete-button").off("click.permissionCheck").on("click.permissionCheck", function (e) {
        if (!window.canDelete) {
            alert("당신의 권한이 없습니다. (삭제)");
            e.preventDefault();
            e.stopImmediatePropagation();
        }
    });
}


/* ---------- 편집 차단 로직 (캡처 + Observer + 안전판) ---------- */

//전역 토스트 알림 함수 (다른 곳에서도 사용)
window.showPermissionNotice = function(msg){
 let t = document.getElementById('permission-toast');
 if (!t) {
     t = document.createElement('div');
     t.id = 'permission-toast';
     t.style.position = 'fixed';
     t.style.right = '20px';
     t.style.bottom = '20px';
     t.style.padding = '10px 14px';
     t.style.background = 'rgba(0,0,0,0.75)';
     t.style.color = '#fff';
     t.style.borderRadius = '6px';
     t.style.zIndex = 99999;
     t.style.fontSize = '13px';
     document.body.appendChild(t);
 }
 t.textContent = msg;
 t.style.display = 'block';
 clearTimeout(t._hideTimer);
 t._hideTimer = setTimeout(function(){ t.style.display = 'none'; }, 1200);
};

//설치 함수 (한 번만 설치됨)
function installTabulatorReadOnlyHandlers(){
 if (window.preventTabEditInstalled) return;
 window.preventTabEditInstalled = true;

 // 캡처 단계: 더블클릭 차단
 document.addEventListener('dblclick', function(e){
     const cell = e.target.closest && e.target.closest('.tabulator .tabulator-cell');
     if (cell && window.currentPermission === "R") {
         e.preventDefault();
         e.stopPropagation();
         e.stopImmediatePropagation && e.stopImmediatePropagation();
         window.showPermissionNotice("당신의 권한이 없습니다. (수정)");
         return false;
     }
 }, true);

 // 캡처 단계: 클릭 차단(단일 클릭으로 편집 열리는 경우 대비)
 document.addEventListener('click', function(e){
     const cell = e.target.closest && e.target.closest('.tabulator .tabulator-cell');
     if (cell && window.currentPermission === "R") {

         e.preventDefault();
         e.stopPropagation();
         e.stopImmediatePropagation && e.stopImmediatePropagation();

         return false;
     }
 }, true);

 document.addEventListener('mousedown', function(e){
     const cell = e.target.closest && e.target.closest('.tabulator .tabulator-cell');
     if (cell && window.currentPermission === "R") {
         e.preventDefault();
         e.stopPropagation();
         e.stopImmediatePropagation && e.stopImmediatePropagation();
         window.showPermissionNotice("당신의 권한이 없습니다. (수정)");
         return false;
     }
 }, true);

 // 캡처 단계: 키 (Enter / F2) 차단
 document.addEventListener('keydown', function(e){
     const active = document.activeElement;
     const isCell = active && active.closest && active.closest('.tabulator .tabulator-cell');
     if (isCell && window.currentPermission === "R") {
         if (e.key === "Enter" || e.key === "F2") {
             e.preventDefault();
             e.stopPropagation();
             e.stopImmediatePropagation && e.stopImmediatePropagation();
             window.showPermissionNotice("당신의 권한이 없습니다. (수정)");
             return false;
         }
     }
 }, true);

 // MutationObserver: 생성되는 에디터 DOM을 즉시 제거
 const editorSelectors = [
     '.tabulator-editor',
     '.tabulator-editing',
     '.tabulator-edit',
     'input.tabulator-edit-input',
     'input.tabulator-editor',
     'textarea.tabulator-editor'
 ].join(',');

 const observer = new MutationObserver(function(mutations){
     if (window.currentPermission !== "R") return;

     mutations.forEach(function(m){
         m.addedNodes && m.addedNodes.forEach(function(node){
             if (!(node && node.nodeType === 1)) return;
             try {
                 if (node.matches && node.matches(editorSelectors)) {
                     node.remove();
                     window.showPermissionNotice("당신의 권한이 없습니다. (수정)");
                     return;
                 }
                 const found = node.querySelector && node.querySelector(editorSelectors);
                 if (found) {
                     found.remove();
                     window.showPermissionNotice("당신의 권한이 없습니다. (수정)");
                     return;
                 }
             } catch (err) {
     
             }
         });
     });
 });

 observer.observe(document.body, { childList: true, subtree: true });

 // 전역 레퍼런스로 보관 (원하면 observer.disconnect()로 해제 가능)
 window._tabulatorEditObserver = observer;

 // 안전판: 주기적으로 (느린 주기) 에디터/인풋이 남아있나 확인하여 제거/blur
 window._tabulatorEditCleaner = setInterval(function(){
     if (window.currentPermission !== "R") return;
     try {
         // 탐지 셀렉터: 에디터 래퍼 또는 입력 필드
         const list = document.querySelectorAll('.tabulator .tabulator-editor, .tabulator input, .tabulator textarea, .tabulator .tabulator-editing');
         if (!list || list.length === 0) return;
         list.forEach(function(el){
             try {
                 if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
                     el.blur();
                     el.disabled = true;
                 } else {
                     el.remove();
                 }
             } catch(e){}
         });
         if (list.length) window.showPermissionNotice("당신의 권한이 없습니다. (수정)");
     } catch(e){}
 }, 700); // 700ms 주기: 부담 적음
}

$(document).ready(function() {
 userInfoList(now_page_code);
 console.log("나우페이지코드", now_page_code);

 installTabulatorReadOnlyHandlers();
});


</script>
