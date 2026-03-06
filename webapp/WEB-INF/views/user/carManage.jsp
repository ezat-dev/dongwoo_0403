<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지게차,청소차 점검일지</title>
   <%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/>
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            margin-left: 1008px;
            margin-top: 200px;
        }

        
		#dataList2 {
		    position: absolute;
		    top: 100px;
		    left: 1%;
		    /* transform: translateX(-50%); */
		    /* width: 80%; */
		    /* text-align: center; */
		    /* display: none; */
		    z-index: 9999;
		}

        .view {
            flex-direction: column; /* 세로 배치 */
		    align-items: center; /* 중앙 정렬 */
		    margin-top: 1%;
        }
        .tab {
            width: 95%;
            margin-bottom: 37px;
            margin-top: 5px;
            height: 45px;
            border-radius: 6px 6px 0px 0px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .modal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: opacity 0.3s ease-in-out;
        }
		.modal-content {
		    background: white;
		    width: 34%;
		    max-width: 500px;
		    height: 82vh;
	
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
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal-content button {
            background-color: #d3d3d3;
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .modal-content button:hover {
            background-color: #a9a9a9;
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
        	width: 20%;
      		text-align: center;
            height: 16px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
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
        
		.status {
		    display: flex;
		    align-items: center;
		    font-size: 18px; 
		    margin-right: 15px;
		    margin-bottom: 13px;
		}
		
		.status span {
		    width: 17px; 
		    height: 17px; 
		    border-radius: 50%;
		    display: inline-block;
		    margin-right: 8px;
		   
		}
		.running {
		    background-color: green;
		}
		
		.changing {
		    background-color: orange;
		}
		
		.stopped {
		    background-color: red;
		}
		
		.unit {
		    margin-left: 10px;
		    font-size: 18px; 
		    color: gray;
		     margin-bottom: 17px;
		}
		.car{
			width: 60%;
		    height: 20%;
		    margin-left: 20%;
		}
		
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }

  table th, table td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
  }

  table th {
    background-color: #f4f4f4;
  }

  #corrForm button {
    margin-top: 20px;
    margin-right: 10px;
    padding: 10px 20px;
  }

  select {
    width: 100px;
    padding: 5px;
  }
    </style>
</head>

<body>

    <main class="main">
        <div class="tab">
        

            <div class="button-container">
            
           <div class="box1">
           

        
           <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
           <label class="daylabel">점검 일자 :</label>
			<input type="text" autocomplete="off"class="daySet" id="s_date" style="font-size: 16px; margin-bottom:10px;" placeholder="시작 날짜 선택">
			
			<span class="mid" style="font-size: 20px; font-weight: bold; margin-botomm:10px;"> ~ </span>

			<input type="text" autocomplete="off"class="daySet" id="e_date" style="font-size: 16px; margin-bottom:10px;" placeholder="종료 날짜 선택">

           <label class="daylabel">설비명 :</label>
            <select class="dayselect">
             
                <option value="1">지게차</option>
                <option value="2">청소차</option>
                
            </select>
			</div>
                <button class="select-button">
                    <img src="/chunil/css/tabBar/search-icon.png" alt="select" class="button-image">조회
                </button>
           <button class="insert-button">
                    <img src="/chunil/css/tabBar/add-outline.png" alt="insert" class="button-image">추가
                </button>
                <button class="excel-button">
                    <img src="/chunil/css/tabBar/excel-icon.png" alt="excel" class="button-image">엑셀
                </button>
<!--                 <button class="printer-button">
                    <img src="/chunil/css/tabBar/printer-icon.png" alt="printer" class="button-image">출력
                </button> -->
            </div>
              
        </div>
 		<img src="/chunil/css/tabBar/car.png"  class="car">
        <div class="view">
            <div id="dataList"></div>
            <div id="dataList2"></div>
        </div>
    </main>
	
<div id="modalContainer" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>지게차 점검일지</h2>
    <form id="corrForm">
       <label>날짜</label>
      <input type="text" class="daySet"autocomplete="off"name="car_date"readonly>
              <input type="text"name="idx"readonly>
      <table>
    
        <thead>
          <tr>
            <th>번호</th>
            <th>점검 항목</th>
            <th>작업 전</th>
            <th>작업 후</th>
          </tr>
        </thead>
        <tbody>
        
          <tr>
            <td>1</td>
            <td>백레스트 설치상태</td>
            <td><select name="a1"><option>O</option><option>X</option><option>-</option></select></td>
            <td><select name="b1"><option>O</option><option>X</option><option>-</option></select></td>
          </tr>
          <tr>
            <td>2</td>
            <td>헤드가드 설치상태</td>
            <td><select name="a2"><option>O</option><option>X</option><option>-</option></select></td>
            <td><select name="b2"><option>O</option><option>X</option><option>-</option></select></td>
          </tr>
          <tr>
            <td>3</td>
            <td>(비상) 브레이크 작동상태</td>
            <td><select name="a3"><option>O</option><option>X</option><option>-</option></select></td>
            <td><select name="b3"><option>O</option><option>X</option><option>-</option></select></td>
          </tr>
          <tr>
            <td>4</td>
            <td>후진 경보장치 작동상태</td>
            <td><select name="a4"><option>O</option><option>X</option><option>-</option></select></td>
            <td><select name="b4"><option>O</option><option>X</option><option>-</option></select></td>
          </tr>
          <tr>
            <td>5</td>
            <td>전조등/후미등 작동상태</td>
            <td><select name="a5"><option>O</option><option>X</option><option>-</option></select></td>
            <td><select name="b5"><option>O</option><option>X</option><option>-</option></select></td>
          </tr>
          <tr>
            <td>6</td>
            <td>안전벨트/경음기(혼) 작동상태</td>
            <td><select name="a6"><option>O</option><option>X</option><option>-</option></select></td>
            <td><select name="b6"><option>O</option><option>X</option><option>-</option></select></td>
          </tr>
          <tr>
            <td>7</td>
            <td>무자격자 운전자 운행금지</td>
            <td><select name="a7"><option>O</option><option>X</option><option>-</option></select></td>
            <td><select name="b7"><option>O</option><option>X</option><option>-</option></select></td>
          </tr>
          <tr>
            <td>8</td>
            <td>블루라이트/빔 상태(좌우전후)</td>
            <td><select name="a8"><option>O</option><option>X</option><option>-</option></select></td>
            <td><select name="b8"><option>O</option><option>X</option><option>-</option></select></td>
          </tr>
        </tbody>
      </table>

      <button type="submit" id="saveCorrStatus">저장</button>
      <button type="button" id="closeModal">닫기</button>
    </form>
  </div>
</div>




<div id="modalContainerClean" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>청소차 점검일지</h2>
    <form id="cleanForm">
      <label>날짜</label>
      <input type="text" class="daySet" autocomplete="off" name="car_date" readonly>
      <input type="text" name="idx" readonly>
      <table>
        <thead>
          <tr>
            <th>번호</th>
            <th>점검 항목</th>
            <th>주간</th>
            <th>야간</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>사이드 브러쉬 청결 상태</td>
            <td>
              <select name="a_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="a_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>2</td>
            <td>배터리 증류수 보충 상태</td>
            <td>
              <select name="b_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="b_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>3</td>
            <td>먼지통 청결 상태</td>
            <td>
              <select name="c_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="c_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>4</td>
            <td>청소차 충전 상태</td>
            <td>
              <select name="d_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="d_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>5</td>
            <td>필터 청결 상태</td>
            <td>
              <select name="e_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="e_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>6</td>
            <td>시동키 제거 상태</td>
            <td>
              <select name="f_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="f_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>7</td>
            <td>타이어 공기압 상태</td>
            <td>
              <select name="g_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="g_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>8</td>
            <td>소모품 소모 상태</td>
            <td>
              <select name="h_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="h_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>9</td>
            <td>먼지 흡입 상태</td>
            <td>
              <select name="i_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="i_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>10</td>
            <td>충전기 가동 상태</td>
            <td>
              <select name="j_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
            <td>
              <select name="j_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
        </tbody>
      </table>
      <button type="submit" id="saveCleanStatus">저장</button>
      <button type="button" id="closeCleanModal">닫기</button>
    </form>
  </div>
</div>


    <script>

    let now_page_code = "e03";

    
        $(function() {
 

            
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth(); // 0부터 시작 (0=1월)

    // 해당 월의 1일
    const firstDay = new Date(year, month, 1);
    // 다음 달 0일 = 이번 달 말일
    const lastDay = new Date(year, month + 1, 0);

    // yyyy-MM-dd 형식으로 변환
    const formatDate = (date) => date.toISOString().split('T')[0];

    $('#s_date').val(formatDate(firstDay));
    $('#e_date').val(formatDate(lastDay));

    getDataList();
    /*  getDataList2(); */



    $(".dayselect").on("change", function(){
        const v = $(this).val();
        console.log("dayselect 변경 →", v);

        if (v === "1") {
          $("#dataList").show();
          $(".car").show();
          $("#dataList2").hide();
          getDataList();
        } else {
          $("#dataList").hide();
          $(".car").hide();
          $("#dataList2").show();
          getDataList2();
        }
      });

      // 3) 초기 실행
      $(".dayselect").trigger("change");
  
        });

        function getDataList2() {
        	 const s_date_val = $('#s_date').val();
     	    const e_date_val = $('#e_date').val();

     	    console.log("getDataList2 보내는 값 → s_date:", s_date_val, "e_date:", e_date_val);
         dataTable = new Tabulator("#dataList2", {
             height: "720px",
             layout: "fitColumns",
             selectableRangeMode: "click",
             columnHeaderVertAlign: "middle",
             rowVertAlign: "middle",
     	    headerHozAlign: "center",
     	    columnDefaults: {
     	        hozAlign: "center",
     	        headerTooltip: false
     	    },
             ajaxConfig: "POST",
             ajaxLoader: false,
             ajaxURL: "/chunil/user/getCleanCar/List",

             ajaxParams: {
                 s_date: s_date_val,
                 e_date: e_date_val
             },
             placeholder: "조회된 데이터가 없습니다.",

             ajaxResponse: function(url, params, response) {
             	console.log("청소차 서버 응답:", response);
                 return response;
             },
                columns: [
                    {title: "id", field: "idx", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                    {title: "점검일자", field: "car_date", sorter: "string", width: 120, hozAlign: "center", headerSort: false},

                    {
                        title: "1.사이드 브러쉬</br>청결 상태",
                        columns: [
                            {title: "주간", field: "a_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "a_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "2.배터리 증류수</br>보충 상태",
                        columns: [
                            {title: "주간", field: "b_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "b_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "3.먼지통</br>청결 상태",
                        columns: [
                            {title: "주간", field: "c_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "c_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "4.청소차</br>충전 상태",
                        columns: [
                            {title: "주간", field: "d_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "d_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "5.필터</br>청결 상태",
                        columns: [
                            {title: "주간", field: "e_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "e_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "6.시동키</br>제거 상태",
                        columns: [
                            {title: "주간", field: "f_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "f_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "7.타이어</br>공기압 상태",
                        columns: [
                            {title: "주간", field: "g_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "g_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "8.소모품</br>소모 상태",
                        columns: [
                            {title: "주간", field: "h_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "h_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "9.먼지</br>흡입 상태",
                        columns: [
                            {title: "주간", field: "i_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "i_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    },
                    {
                        title: "10.충전기</br>가동 상태",
                        columns: [
                            {title: "주간", field: "j_1", sorter: "string", width: 70, hozAlign: "center", headerSort: false},
                            {title: "야간", field: "j_2", sorter: "string", width: 70, hozAlign: "center", headerSort: false}
                        ]
                    }
                ],
                rowFormatter: function(row) {
                    var data = row.getData();
                    row.getElement().style.fontWeight = "700";
                    row.getElement().style.backgroundColor = "#FFFFFF";
                },
                rowDblClick: function (e, row) {
              	  const data = row.getData();

              	  // 날짜 세팅
              	  $('input[name="car_date"]').val(data.car_date);
              	  $('input[name="idx"]').val(data.idx);

              	
              	  $('select[name="a_1"]').val(data['a_1']);
              	  $('select[name="b_1"]').val(data['b_1']);
              	  $('select[name="c_1"]').val(data['c_1']);
              	  $('select[name="d_1"]').val(data['d_1']);
              	  $('select[name="e_1"]').val(data['e_1']);
              	  $('select[name="f_1"]').val(data['f_1']);
              	  $('select[name="g_1"]').val(data['g_1']);
              	  $('select[name="h_1"]').val(data['h_1']);
              	  $('select[name="i_1"]').val(data['i_1']);
              	  $('select[name="j_1"]').val(data['j_1']);

              	  // 작업 후 점검 항목 (야간 a_2 ~ j_2)
              	  $('select[name="a_2"]').val(data['a_2']);
              	  $('select[name="b_2"]').val(data['b_2']);
              	  $('select[name="c_2"]').val(data['c_2']);
              	  $('select[name="d_2"]').val(data['d_2']);
              	  $('select[name="e_2"]').val(data['e_2']);
              	  $('select[name="f_2"]').val(data['f_2']);
              	  $('select[name="g_2"]').val(data['g_2']);
              	  $('select[name="h_2"]').val(data['h_2']);
              	  $('select[name="i_2"]').val(data['i_2']);
              	  $('select[name="j_2"]').val(data['j_2']);

              
              	openModal("#modalContainerClean");
              	},
                });
              }

         



        function openEditForm() {
            $('#editFormModal').show(); 
        }

        function closeEditForm() {
            $('#editFormModal').hide();
        }

        function fillFormData(data) {

            for (const key in data) {
                if (data.hasOwnProperty(key)) {
               
                    const $el = $(`[name="${key}"]`);
                    if ($el.length) {
                        $el.val(data[key]);
                    }
                }
            }
        }

        $(document).ready(function () {
            //청소차 저장
            $("#saveCleanStatus").click(function (event) {
                event.preventDefault();
                
                var cleanCarForm = new FormData($("#cleanForm")[0]);  // 청소차 폼 데이터

                
                cleanCarForm.forEach(function(value, key){
                    console.log(key + ": " + value);
                });

                $.ajax({
                    url: "/chunil/user/getCleanCar/insert",  // 청소차 저장 API 주소
                    type: "POST",
                    data: cleanCarForm,
                    dataType: "json",
                    processData: false,  
                    contentType: false,  
                    success: function (response) {
                        alert("청소차 성공적으로 저장되었습니다!");
                        closeModal("#modalContainerClean");
                        getDataList2();  // 청소차 데이터 다시 불러오기 함수
                    },
                    error: function(xhr, status, error) {
                        alert("저장 중 오류가 발생했습니다: " + error);
                    }
                });
            });
        });











        

        function getDataList() {
        	 const s_date_val = $('#s_date').val();
        	    const e_date_val = $('#e_date').val();

        	    console.log("getDataListㅋㅌㅊㅋㅌㅊ 보내는 값 → s_date:", s_date_val, "e_date:", e_date_val);
            dataTable = new Tabulator("#dataList", {
                height: "520px",
                layout: "fitColumns",
                selectableRangeMode: "click",
                columnHeaderVertAlign: "middle",
                rowVertAlign: "middle",
        	    headerHozAlign: "center",
        	    columnDefaults: {
        	        hozAlign: "center",
        	        headerTooltip: false
        	    },
                ajaxConfig: "POST",
                ajaxLoader: false,
                ajaxURL: "/chunil/user/getForkCar/List",

                ajaxParams: {
                    s_date: s_date_val,
                    e_date: e_date_val
                },
                placeholder: "조회된 데이터가 없습니다.",

                ajaxResponse: function(url, params, response) {
                	console.log("포크 서버 응답:", response);
                    return response;
                },
                columns: [
                    { title: "id", field: "idx", sorter: "string", width: 85, hozAlign: "center", headerSort: false },
                    { title: "정검일자", field: "car_date", sorter: "string", width: 250, hozAlign: "center", headerSort: false },

                    {
                        title: "안전장치 점검항목",
                        columns: [
                            {
                                title: "작업 전",
                                columns: [
                                    { title: "1", field: "a1", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "2", field: "a2", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "3", field: "a3", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "4", field: "a4", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "5", field: "a5", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "6", field: "a6", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "7", field: "a7", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "8", field: "a8", sorter: "string", width: 80, hozAlign: "center", headerSort: false }
                                ]
                            },
                            {
                                title: "작업 후",
                                columns: [
                                    { title: "1", field: "b1", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "2", field: "b2", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "3", field: "b3", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "4", field: "b4", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "5", field: "b5", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "6", field: "b6", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "7", field: "b7", sorter: "string", width: 80, hozAlign: "center", headerSort: false },
                                    { title: "8", field: "b8", sorter: "string", width: 80, hozAlign: "center", headerSort: false }
                                ]
                            }
                        ]
                    }
                ],


                rowFormatter: function(row) {
                    var data = row.getData();
                    row.getElement().style.fontWeight = "700";
                    row.getElement().style.backgroundColor = "#FFFFFF";
                },
             // 행 더블클릭 이벤트 처리
                rowDblClick: function (e, row) {
                	  const data = row.getData();

                	  // 날짜 세팅
                	  $('input[name="car_date"]').val(data.car_date);
                	  $('input[name="idx"]').val(data.idx);

                	
                	  $('select[name="a1"]').val(data.a1);
                	  $('select[name="a2"]').val(data.a2);
                	  $('select[name="a3"]').val(data.a3);
                	  $('select[name="a4"]').val(data.a4);
                	  $('select[name="a5"]').val(data.a5);
                	  $('select[name="a6"]').val(data.a6);
                	  $('select[name="a7"]').val(data.a7);
                	  $('select[name="a8"]').val(data.a8);

                	  $('select[name="b1"]').val(data.b1);
                	  $('select[name="b2"]').val(data.b2);
                	  $('select[name="b3"]').val(data.b3);
                	  $('select[name="b4"]').val(data.b4);
                	  $('select[name="b5"]').val(data.b5);
                	  $('select[name="b6"]').val(data.b6);
                	  $('select[name="b7"]').val(data.b7);
                	  $('select[name="b8"]').val(data.b8);

                	
                	  openModal("#modalContainer");
                	},

            });
        }
        function openModal(selector) {
        	  $(selector).addClass("show");
        	}
        	function closeModal(selector) {
        	  $(selector).removeClass("show");
        	}
        	        

        	// 1) 모달 열기/닫기 통일 함수
        	function openModal(selector) {
        	  $(selector)
        	    .css("z-index", 9999)  // 맨 앞으로
        	    .addClass("show");
        	}
        	function closeModal(selector) {
        	  $(selector).removeClass("show");
        	}

        	// 2) “폼 열기” 버튼들
        	$(".insert-button").on("click", function() {
        	  openModal("#modalContainer");
        	});
        	$(".insert-clean-button").on("click", function() {
        	  openModal("#modalContainerClean");
        	});

        	// 3) “닫기” 버튼들 (id, 클래스, .close 모두)
        	$("#closeModal, .close-modal-btn, .close").on("click", function() {
        	  closeModal("#modalContainer");
        	});
        	$("#closeCleanModal, .close-clean-btn, .close").on("click", function() {
        	  closeModal("#modalContainerClean");
        	});



        $(document).ready(function () {
            //지게차 저장
            $("#saveCorrStatus").click(function (event) {
                event.preventDefault();
                
                var corrForm = new FormData($("#corrForm")[0]);  // 폼 데이터를 FormData 객체로 생성

                // FormData의 값을 콘솔에 출력
                corrForm.forEach(function(value, key){
                    console.log(key + ": " + value);  // key와 value를 콘솔에 출력
                });

                $.ajax({
                    url: "/chunil/user/getForkCar/insert",
                    type: "POST",
                    data: corrForm,
                    dataType: "json",
                    processData: false,  
                    contentType: false,  
                    success: function (response) {
                        alert("지게차 성공적으로 저장되었습니다!");
                        closeModal("#modalContainer"); 
                        getDataList();
                    }
                });
            });

           
        });

   	


        
    </script>

</body>
</html>

