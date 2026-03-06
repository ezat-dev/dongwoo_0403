<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작업자 근무현황</title>
<%@include file="../include/pluginpage.jsp" %>   
<jsp:include page="../include/tabBar.jsp"/> 

    
<style>


	.tab {
	    width: 99%;
	    margin-bottom: 37px;
	    margin-top: 5px;
	    height: 55px;
	    display: flex;
	    align-items: center;
	
	   
	    justify-content: flex-end;
	    gap: 20px;
	    padding-right: 20px;
	}


    .tab-header {
        display: flex;
        align-items: center;
        font-size: 20px;
        font-weight: bold;
    }



	.tab label {
	    margin-right: 5px;
	    font-weight: 500;
	   	font-size: 20px;
	   	margin-top: 2px;
	}
	
.tab input.daySet {
    
    padding: 6px 12px;
    font-size: 19px;
    border: 1px solid #ccc;
    border-radius: 4px;
    width: 150px;
    text-align: center;
    height: 25px;
}



    .button-image {
        width: 16px;
        height: 16px;
        margin-right: 5px;
    }

    #m_code {
        display: none;
    }
    h2 {
    margin-left: 20px;
	}
   .modal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
        
            transition: opacity 0.3s ease-in-out;
        }
	    .modal-content {
	        background: white;
	        width: 24%;
	        max-width: 500px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
        .modal.show {
            display: block;
            opacity: 1;
        }
        .modal.show .modal-content {
            transform: scale(1);
            opacity: 1;
        }
        .modal.show .modal-content2 { opacity:1; transform: scale(1); }
        
        .close {
            background-color:white;
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }
        .modal-content form {
            display: flex;
            flex-direction: column;
        }
        .modal-content label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        .modal-content input, .modal-content textarea {
            width: 97%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
       .modal-content2 form {
            display: flex;
            flex-direction: column;
        }
        .modal-content2 label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        .modal-content2 input, .modal-content2 textarea {
            width: 97%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
          .modal-content2 button {
       
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
          
        }
        .modal-content button {
       
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
          
        }
        .modal-content button:hover {
  
        }
        .button-container {
    		display: flex;
		    gap: 10px;
		    margin-left: auto;
		    margin-right: 10px;
		    margin-top: 40px;
		}
		.box1 {
		    display: flex;
		    justify-content: right;
		    align-items: center;
		    width: 1000px;
		    margin-right: 20px;
		    margin-top:4px;
		}
        .dayselect {
            width: 20%;
            text-align: center;
            font-size: 15px;
        }
        .daySet {
        	width: 30%;
      		text-align: center;
            height: 21px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 17px;
        }
        .daylabel {
            margin-right: 10px;
            margin-bottom: 13px;
            font-size: 18px;
            margin-left: 20px;
        }
        button-container.button{
        height: 16px;
        }
         .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;
	
	    height: 42px;
	    margin-left: 9px;
        }
        .row_select {
	    background-color: #ffeeba !important;
	    }
.modal-content2 {
    background: white;
    width: 24%;
    max-width: 500px;
    height: 80vh; 
    overflow-y: auto; 
    margin: 6% auto 0;
    padding: 20px;
    border-radius: 10px;
    position: relative;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
    transform: scale(0.8);
    transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
    opacity: 0;
}

.modal.show {
    display: block;
    opacity: 1;
}

.modal.show .modal-content2 {
    transform: scale(1);
    opacity: 1;
}

.close2 {
    background-color: white;
    position: absolute;
    right: 15px;
    top: 10px;
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
}
.navigate-button {
  background-color: #e0e0e0;
  color: #333;
  border: none;
  border-radius: 5px;
  padding: 5px 20px;
  font-size: 14px;
  height: 30px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.navigate-button:hover {
  background-color: #cfcfcf;
}
</style>



</head>
<body>
  <main>
     <div class="tab">

	   <div class="button-container">
	        
			<button class="navigate-button" onclick="location.href='/chunil/user/workerManage2'">
			  인수인계 페이지
			</button>
			 
	        <label for="s_time">검색일자 :</label>
	        <input type="text" autocomplete="off" class="daySet" id="s_time" placeholder="시작 날짜 선택">
	        <button class="select-button" onclick="loadWorkDailyData()">
	            <img src="/chunil/css/tabBar/search-icon.png" alt="select" class="button-image">조회
	        </button>
	          <button class="insert-button">
                    <img src="/chunil/css/tabBar/add-outline.png" alt="insert" class="button-image">추가
                </button>
                      <button class="delete-button">
				    <img src="/chunil/css/tabBar/xDel3.png" alt="delete" class="button-image"> 삭제
				</button>
                
	    </div>
	    <div id="m_code">G03-GG03</div>
	</div>

        <div class="view">
            <div id="table1"></div>
            <div id="table2"></div>
            <div id="table3"></div>
        </div>
    </main>
    

  <div id="modalContainer" class="modal" style="display:none;">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>작업자 근무현황</h2>
    <form id="corrForm" autocomplete="off">
      <label>NO</label>
      <input type="text" name="id">

      <label>날짜</label>
      <input type="text" name="date">

      <label>업무 조/상시주간</label>

      <input type="text" name="column" id="teamField">

      <label>업무</label>
      <input type="text" name="sub_task">

      <label>작업자</label>
   
      <input type="text" id="workerField">

      <button type="submit" id="saveCorrStatus">저장</button>
      <button type="button" id="closeModal">닫기</button>
    </form>
  </div>
</div>




<div id="modalContainer2" class="modal" style="display:none;">
  <div class="modal-content2">
    <span class="close2">&times;</span>
    <h2>상세 근무현황 수정</h2>
    <form id="corrForm2" autocomplete="off">
      <input type="hidden" name="id">

      <label>날짜</label>
      <input type="date" name="date">

      <label>주/야</label>
      <input type="text" name="shift_type">

      <label>라인장</label>
      <input type="text" name="line_leader">

      <label>세척</label>
      <input type="text" name="degreasing">

      <label>쇼트</label>
      <input type="text" name="shot">

      <label>G-800</label>
      <input type="text" name="g800">

      <label>G-600</label>
      <input type="text" name="g600">

      <label>공용설비(후처리)</label>
      <input type="text" name="common">

      <label>K-BLACK</label>
      <input type="text" name="k_black">

      <label>액관리</label>
      <input type="text" name="liquid_mgmt">

      <label>e-coating</label>
      <input type="text" name="e_coating">

      <label>그룹장</label>
      <input type="text" name="group_leader">

      <label>방청</label>
      <input type="text" name="rust">

      <label>실험</label>
      <input type="text" name="lab">

      <button type="submit" id="saveCorrStatus2">저장</button>
      <button type="button" id="closeModal2">닫기</button>
    </form>
  </div>
</div>




<script>
  let table1, table2, selectedRowData;
  let now_page_code = "e02";



  $('.close, #closeModal').click(function() {
      $('#modalContainer').removeClass('show').hide();
    });
  
  $('#saveCorrStatus').click(function(event) {
	  event.preventDefault();

	  const id = $('input[name="id"]').val();


	  const selectedTeam = $('#teamField').val();
	  let column = '';

	  switch (selectedTeam) {
	    case 'A조':
	      column = 'team_a';
	      break;
	    case 'B조':
	      column = 'team_b';
	      break;
	    case 'C조':
	      column = 'team_c';
	      break;
	    case '상시주간':
	      column = 'always_day_shift';
	      break;
	    default:
	      column = selectedTeam; 
	  }

	  const value = $('#workerField').val();

	  const formData = new FormData();
	  formData.append('id', id);
	  formData.append('column', column);
	  formData.append('value', value);

	  console.log("보내는 데이터:");
	  for (let [key, val] of formData.entries()) {
	    console.log(`${key}: ${val}`);
	  }

	  $.ajax({
	    url: "/chunil/user/workerManage/insert",
	    method: "POST",
	    data: formData,
	    processData: false,
	    contentType: false,
	    success: () => {
	      alert('저장되었습니다.');
	      $('#modalContainer').removeClass('show').hide(); // 모달 닫기
	      loadWorkDailyData(); // 테이블 새로고침
	    },
	    error: () => {
	      alert('저장 중 오류가 발생했습니다.');
	    }
	  });
	});

  $('#saveCorrStatus2').on('click', function(e){
	  e.preventDefault();

	  const $form = $('#corrForm2');
	  const formData = {};

	  // form 안의 input[name] 값들을 모두 읽어서 객체에 저장
	  $form.find('input[name]').each(function(){
	    const name = $(this).attr('name');
	    const val  = $(this).val();
	    formData[name] = val;
	  });

	  console.log('보내는 데이터 (table2 수정):', formData);

	  $.ajax({
	    url: '/chunil/user/workerManage/insertSchedule',  // 실제 수정용 엔드포인트로 변경
	    method: 'POST',
	    contentType: 'application/json',
	    data: JSON.stringify(formData),
	    success: function(res){
	      alert('수정이 완료되었습니다.');
	      $('#modalContainer2').hide();
	      loadWorkDailyData();    
	    },
	    error: function(xhr){
	      console.error(xhr.responseText);
	      alert('수정 중 오류가 발생했습니다.');
	    }
	  });
	})


  $('.delete-button').click(function() {
	  if (!selectedRowData) {
	    return alert('삭제할 행을 먼저 클릭해 주세요.');
	  }
	  if (!confirm('선택된 항목을 정말 삭제하시겠습니까?')) return;

	  const deleteData = { idx: selectedRowData.idx };
	  console.log("삭제 요청 데이터:", deleteData);

	  $.ajax({
	    url: "/chunil/user/workerManage/delete",
	    method: "POST",
	    contentType: "application/json",
	    data: JSON.stringify(deleteData),
	    success: () => loadWorkDailyData(),
	    error:   () => alert('삭제 중 오류가 발생했습니다.')
	  });
	});




  function loadWorkDailyData() {
	  let s_time = $("#s_time").val();

      console.log("보내는 값:", { s_time });

      $.ajax({
        type: "POST",
        url: "/chunil/user/workerManage/list",
        contentType: "application/json",
        data: JSON.stringify({ s_time }),
        success: function(response) {
//        	console.log(response);
        	console.log(response.table1);
          table1.setData(response.table1);
          table2.setData(response.table2);

        },
        error: function(xhr, status, error) {
          console.error("에러 응답:", xhr.responseText);
          alert("조회에 실패했습니다.");
        }
      });
    }

    $(function() {
        const today = new Date().toISOString().split('T')[0];
        $('#s_time').val(today);
        initTables();
        loadWorkDailyData();
    });

    const ALLOWED = ['team_a','team_b','team_c','always_day_shift'];
    function initTables() {
    	 
    	table1 = new Tabulator("#table1", {
    		  height: "365px",
    		  layout: "fitColumns",
    		  headerHozAlign: "center",        // 헤더 가운데
    		  headerVertAlign: "middle",       // 헤더 세로 가운데
    		  columnDefaults: {
    		    hozAlign: "center",            // 셀 가운데
    		    vertAlign: "middle",           // 셀 세로 가운데
    		    headerTooltip: false
    		  },
    	    columns:[
    	        {title:"NO", field:"id", headerSort:false,hozAlign: "center"},
    	        { title: "날짜", field: "date", headerSort: false, hozAlign: "center", visible: false },

    	        {title:"업무", field:"task", headerSort:false,hozAlign: "center"},
    	        {title:"A조", field:"team_a", headerSort:false,hozAlign: "center"},
    	        {title:"B조", field:"team_b", headerSort:false,hozAlign: "center"},
    	        {title:"C조", field:"team_c", headerSort:false,hozAlign: "center"},
    	        {title:"업무", field:"sub_task", headerSort:false,hozAlign: "center"},
    	        {title:"상시주간", field:"always_day_shift", headerSort:false,hozAlign: "center"},
    	      ],
    	      cellClick: function(e, cell){
    	    	    if(!ALLOWED.includes(cell.getField())) return false;
    	    	    const row = cell.getRow();
    	    	    table1.getRows().forEach(r=> r.getElement().style.backgroundColor = "");
    	    	    row.getElement().style.backgroundColor = "#d3d3d3";
    	    	  },

    	    	  cellDblClick: function(e, cell){
    	    		  const field = cell.getField();
    	    		  if(!ALLOWED.includes(field)) return;

    	    		  const data = cell.getRow().getData();

    	    		 
    	    		  $('#corrForm')[0].reset();

    	    		  $('#corrForm input[name="id"]').val(data.id);

    	    		  $('#corrForm input[name="date"]').val(data.date);

    	    		  if(field === 'always_day_shift'){

    	    		    $('#corrForm input[name="sub_task"]').val(data.sub_task);
    	    		  } else {
  
    	    		    $('#corrForm input[name="sub_task"]').val(data.task);
    	    		  }

    	    		  const title = cell.getColumn().getDefinition().title;
    	    		  $('#teamField')
    	    		    .attr('name', field)
    	    		    .val(title);

    	    		  $('#workerField')
    	    		    .attr('name', field)
    	    		    .val(cell.getValue());
    	    		  $('#modalContainer').show().addClass('show');
    	    		},

    	    	});

    	    	$('#closeModal, .close').on('click', ()=>{
    	    	  $('#modalContainer').hide().removeClass('show');
    	    	});

    	table2 = new Tabulator("#table2", {
    	    height: "420px",
    	    layout: "fitColumns",
            columnHeaderVertAlign: "middle",
            rowVertAlign: "middle",
    	    headerHozAlign: "center",
    	    columnDefaults: {
    	        hozAlign: "center",
    	        headerTooltip: false
    	    },
    	    columns: [
    	    	{ title: "구분", field: "id", hozAlign: "center", headerSort: false, visible: false },
    	    	{ title: "날짜", field: "date", hozAlign: "center", headerSort: false},
    	    	


    	        { title: "주/야", field: "shift_type", hozAlign: "center",headerSort: false },
    	        { title: "라인장", field: "line_leader", hozAlign: "center",headerSort: false },
    	        { title: "세척", field: "degreasing", hozAlign: "center" ,headerSort: false},
    	        { title: "쇼트", field: "shot", hozAlign: "center",headerSort: false },
    	        { title: "G-800", field: "g800", hozAlign: "center",headerSort: false },
    	        { title: "G-600", field: "g600", hozAlign: "center",headerSort: false },
    	        { title: "공용설비(후처리)", field: "common", hozAlign: "center" ,headerSort: false},
    	        { title: "K-BLACK", field: "k_black", hozAlign: "center" ,headerSort: false},
    	        { title: "액관리", field: "liquid_mgmt", hozAlign: "center" ,headerSort: false},
    	        { title: "e-coating", field: "e_coating", hozAlign: "center" ,headerSort: false},
    	        { title: "그룹장", field: "group_leader", hozAlign: "center" ,headerSort: false},
    	        { title: "방청", field: "rust", hozAlign: "center" ,headerSort: false},
    	        { title: "실험", field: "lab", hozAlign: "center" ,headerSort: false}
    	        
    	    ],
    	    rowDblClick: function(e, row) {
    	        const data = row.getData();
    	        const $form = $('#corrForm2');

    	        // 1) 폼 초기화
    	        $form[0].reset();

    	        // 2) 각 필드별로 값 채우기
    	        $form.find('input[name="id"]').val(data.id);
    	        $form.find('input[name="date"]').val(data.date);
    	        $form.find('input[name="shift_type"]').val(data.shift_type);
    	        $form.find('input[name="line_leader"]').val(data.line_leader);
    	        $form.find('input[name="degreasing"]').val(data.degreasing);
    	        $form.find('input[name="shot"]').val(data.shot);
    	        $form.find('input[name="g800"]').val(data.g800);
    	        $form.find('input[name="g600"]').val(data.g600);
    	        $form.find('input[name="common"]').val(data.common);
    	        $form.find('input[name="k_black"]').val(data.k_black);
    	        $form.find('input[name="liquid_mgmt"]').val(data.liquid_mgmt);
    	        $form.find('input[name="e_coating"]').val(data.e_coating);
    	        $form.find('input[name="group_leader"]').val(data.group_leader);
    	        $form.find('input[name="rust"]').val(data.rust);
    	        $form.find('input[name="lab"]').val(data.lab);
    	        $form.find('input[name="memo"]').val(data.memo);

    	      
    	        $('#modalContainer2')
    	          .show()
    	          .addClass('show');
    	      }
    	    });

    
    	    $('#closeModal2, .close2').on('click', () => {
    	      $('#modalContainer2').hide();
    	    });
    	  }
  $(function() {
    $('#s_time').val(new Date().toISOString().split('T')[0]);
    initTables();
    loadWorkDailyData();
  });
</script>

</body>
</html>
