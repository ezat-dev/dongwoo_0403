<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유해화학물질 점검일지</title>
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
    width: 30%;
    max-width: 500px;
    height: 70vh;
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
            margin-top: 20px;
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
			<label class="daylabel">점검 월 :</label>
			<input type="text" autocomplete="off" class="monthSet" id="monthSet" 
			       style="
			         font-size: 16px; 
			         font-weight: 600;      
			         text-align: center;    
			         margin-bottom: 10px; 
			         border: 1px solid #ccc; 
			         border-radius: 5px; 
			         padding: 6px 10px; 
			         height: 36px; 
			         box-sizing: border-box;
			         z-index: 1000;
			       " 
			       placeholder="월 선택">


		
			</div>
                <button class="select-button">
                    <img src="/chunil/css/tabBar/search-icon.png" alt="select" class="button-image">조회
                </button>
      <!--      <button class="insert-button">
                    <img src="/chunil/css/tabBar/add-outline.png" alt="insert" class="button-image">추가
                </button> -->
                <button class="excel-button">
                    <img src="/chunil/css/tabBar/excel-icon.png" alt="excel" class="button-image">엑셀
                </button>
<!--                 <button class="printer-button">
                    <img src="/chunil/css/tabBar/printer-icon.png" alt="printer" class="button-image">출력
                </button> -->
            </div>
              
        </div>
 		
        <div class="view">
           
            <div id="dataList2"></div>
        </div>
    </main>
	


<div id="modalContainer" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>유해화학 물질 취급시설 점검일지</h2>
    <form id="cleanForm">
      <label>날짜</label>
      <input type="text" class="daySet" autocomplete="off" name="ck_date" readonly>
     <input type="text" name="idx" readonly style="display:none;">


      <table>
        <thead>
          <tr>
            <th>번호</th>
            <th>점검 항목</th>
            <th>결과</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>유해화학물질 보관창고 출입문 시건 장치는 적정한가?</td>
            <td>
              <select name="a_1">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>2</td>
            <td>보관 창고 안전휀스 상태는 적정한가?</td>
            <td>
              <select name="a_2">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>3</td>
            <td>보관 창고 내 바닥 상태는 적정한가?</td>
            <td>
              <select name="a_3">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>4</td>
            <td>유해화학물질 유출 흔적이 있는가?</td>
            <td>
              <select name="a_4">
                <option value="O" selected>O</option>
                <option value="X">X</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>5</td>
            <td>안전보호구 보관상태는 적정한가?</td>
            <td>
              <select name="a_5">
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
    let now_page_code = "i03";

    $(function () {
    	 var now    = new Date();
    	    var year   = now.getFullYear();
    	    var month  = String(now.getMonth() + 1).padStart(2, '0');
    	    var yearMonth = year + '-' + month;
    	    $('#monthSet').val(yearMonth).attr('placeholder', yearMonth);
    	    


        getDataList2();

        $(".insert-button").on("click", function () {
            openModal("#modalContainer");
          
        });

        $(".select-button").on("click", function () {
            getDataList2();
        });


        $("#saveCleanStatus").click(function (event) {
            event.preventDefault();

            var cleanCarForm = new FormData($("#cleanForm")[0]);

            cleanCarForm.forEach(function (value, key) {
                console.log(key + ": " + value);
            });

            $.ajax({
                url: "/chunil/user/CheckManage/insert",
                type: "POST",
                data: cleanCarForm,
                dataType: "json",
                processData: false,
                contentType: false,
                success: function (response) {
                    alert("유해화학물질 성공적으로 저장되었습니다!");
                    closeModal("#modalContainer");
                    getDataList2();
                },
                error: function (xhr, status, error) {
                    alert("저장 중 오류가 발생했습니다: " + error);
                }
            });
        });
    });

    function getDataList2() {
        const monthSet_val = $('#monthSet').val();

        console.log("getDataList2 보내는 값 → monthSet:", monthSet_val);
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
            ajaxURL: "/chunil/user/CheckManage/List",
            ajaxParams: {
                ck_date: monthSet_val
            },
            placeholder: "조회된 데이터가 없습니다.",
            ajaxResponse: function (url, params, response) {
                console.log("유해화학 서버 응답:", response);
                return response;
            },
            columns: [
                {
                    title: "No", 
                    formatter: function(cell) {
                        return cell.getRow().getPosition() + 1; 
                    },
                    width: 50,
                    hozAlign: "center",
                    headerSort: false
                },
                {
                    title: "id",
                    field: "idx",
                    sorter: "string",
                    visible: false
                },
                { title: "점검일자", field: "ck_date", width: 120, hozAlign: "center" },
                { 
                    title: "1.유해화학물질 보관창고</br>출입문 시건 장치는 적정한가?", 
                    field: "a_1", 
                    width: 280, 
                    hozAlign: "center",
                    formatter: function(cell) {
                        var val = cell.getValue();
                        return val === "X" ? "<span style='color: red; font-weight: bold;'>" + val + "</span>" : val;
                    }
                },
                { 
                    title: "2.보관창고 안전휀스</br>상태는 적정한가?", 
                    field: "a_2", 
                    width: 280, 
                    hozAlign: "center",
                    formatter: function(cell) {
                        var val = cell.getValue();
                        return val === "X" ? "<span style='color: red; font-weight: bold;'>" + val + "</span>" : val;
                    }
                },
                { 
                    title: "3.보관창고 내 바닥</br>상태는 적정한가?", 
                    field: "a_3", 
                    width: 280, 
                    hozAlign: "center",
                    formatter: function(cell) {
                        var val = cell.getValue();
                        return val === "X" ? "<span style='color: red; font-weight: bold;'>" + val + "</span>" : val;
                    }
                },
                { 
                    title: "4.유해화학물질 유출</br>흔적이 있는가", 
                    field: "a_4", 
                    width: 280, 
                    hozAlign: "center",
                    formatter: function(cell) {
                        var val = cell.getValue();
                        return val === "X" ? "<span style='color: red; font-weight: bold;'>" + val + "</span>" : val;
                    }
                },
                { 
                    title: "5.안전보호구 보관상태는</br>적정한가", 
                    field: "a_5", 
                    width: 280, 
                    hozAlign: "center",
                    formatter: function(cell) {
                        var val = cell.getValue();
                        return val === "X" ? "<span style='color: red; font-weight: bold;'>" + val + "</span>" : val;
                    }
                }
            ],


            rowFormatter: function (row) {
                row.getElement().style.fontWeight = "700";
                row.getElement().style.backgroundColor = "#FFFFFF";
            },
            rowDblClick: function (e, row) {
                const data = row.getData();
                $('input[name="ck_date"]').val(data.ck_date);
                $('input[name="idx"]').val(data.idx);
                $('select[name="a_1"]').val(data.a_1);
                $('select[name="a_2"]').val(data.a_2);
                $('select[name="a_3"]').val(data.a_3);
                $('select[name="a_4"]').val(data.a_4);
                $('select[name="a_5"]').val(data.a_5);
                openModal("#modalContainer");
            }
        });
    }

    function openModal(selector) {
        $(selector).css("z-index", 9999).addClass("show");
    }

    function closeModal(selector) {
    	  $(selector).removeClass("show");
    	}

    	// X 표시 닫기 버튼
    	$("#modalContainer .close").on("click", function() {
    	  closeModal("#modalContainer");
    	});

    	// 폼 내 닫기 버튼
    	$("#closeCleanModal").on("click", function() {
    	  closeModal("#modalContainer");
    	});




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
</script>

</body>
</html>

