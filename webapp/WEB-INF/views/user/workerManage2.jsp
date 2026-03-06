<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>근무 인수인계서</title>
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
		    width: 800px;
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

#table2{
margin-left:50px;
width:1570px;
}

</style>



</head>
<body>
  <main>
     <div class="tab">
	 
	   <div class="button-container">
	   
	   		<button class="navigate-button" onclick="location.href='/chunil/user/workerManage'">
			  작업자 현황 페이지
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
           
            <div id="table2"></div>
        
        </div>
    </main>
    

 



<div id="modalContainer2" class="modal" style="display:none;">
  <div class="modal-content2">
    <span class="close2">&times;</span>
    <h2>인수인계 사항 </h2>
<form id="corrForm2" autocomplete="off">
  <input type="hidden" name="id">

  <label>날짜</label>
  <input type="date" name="date">

  <label>주/야</label>
  <input type="text" name="b_f">

<label>설비고장 내역 및 조치사항</label>
<input type="text" name="ex1" style="height: 80px;">

<label>근무자 이상내역(결근,조퇴,연차) 전달사항</label>
<input type="text" name="ex2" style="height: 80px;">

<label>중요 긴급품 확인</label>
<input type="text" name="ex3" style="height: 80px;">


  <button type="submit" id="saveCorrStatus2">저장</button>
  <button type="button" id="closeModal2">닫기</button>
</form>

  </div>
</div>




<script>
  let table1, table2, selectedRowData;
  let now_page_code = "e02";



 
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
	    url: '/chunil/user/work_handover/insert',  
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





  function loadWorkDailyData() {
	  let s_time = $("#s_time").val();

      console.log("보내는 값:", { s_time });

      $.ajax({
        type: "POST",
        url: "/chunil/user/work_handover/list",
        contentType: "application/json",
        data: JSON.stringify({ s_time }),
        success: function(response) {
//        	console.log(response);
        	console.log(response.table1);
  
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

  
    function initTables() {
    	 

    	table2 = new Tabulator("#table2", {
    		height: "620px",
    	    layout: "fitColumns",
    	    headerHozAlign: "center",        // 헤더 가운데
  		  headerVertAlign: "middle",       // 헤더 세로 가운데
    	    headerSort: false, 
    	    columns: [
    	        { title: "no", formatter: "rownum", hozAlign: "center", headerSort: false, width: 50 },
    	        { title: "날짜", field: "date", hozAlign: "center", headerSort: false, width: 200 },
    	        { title: "no2", field: "id", hozAlign: "center", headerSort: false, visible: false, width: 50 },
    	        { title: "구분", field: "b_f", hozAlign: "center", headerSort: false, width: 120 },
    	        { title: "설비고장 내역 및 조치사항", field: "ex1", hozAlign: "center", headerSort: false, width: 400 },
    	        { title: "근무자 이상내역 (결근,조퇴,연차)</br>전달사항", field: "ex2", hozAlign: "center", headerSort: false, width: 400 },
    	        { title: "중요 긴급품 확인", field: "ex3", hozAlign: "center", headerSort: false, width: 400 }
    	    ],

    	    rowDblClick: function(e, row) {
    	        const data = row.getData();
    	        const $form = $('#corrForm2');

    	        $form[0].reset();

    	        $form.find('input[name="b_f"]').val(data.b_f);
    	        $form.find('input[name="ex1"]').val(data.ex1);
    	        $form.find('input[name="ex2"]').val(data.ex2);
    	        $form.find('input[name="ex3"]').val(data.ex3);
    	        $form.find('input[name="id"]').val(data.id);
    	        $form.find('input[name="date"]').val(data.date);
    	      
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
