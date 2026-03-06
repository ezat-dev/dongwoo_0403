<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리계획서 및 작업 표준서</title>
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
        .view {
            display: flex;
            justify-content: center;
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
		    width: 1100px;
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
        
        
        
        /*모달css  */
		   .modal {
		    display: none;
		    position: fixed;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.5);
		    transition: opacity 0.3s ease-in-out;
		    overflow: auto;
		}
		.row_select {
		    background-color: #d0d0d0 !important;
		}
		
		.modal-content {
		    background: white;
		    width: 40%; /* 가로 길이를 50%로 설정 */
		    max-width: 400px; /* 최대 너비를 설정하여 너무 커지지 않도록 */
		    max-height: 800px; /* 화면 높이에 맞게 제한 */
		    overflow-y: auto;
		    margin: 2% auto; /* 수평 중앙 정렬 */
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
		    background-color: white;
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
		    width: 100%;
		    padding: 8px;
		    margin-bottom: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}

		.modal-content select {
		    width: 104%;
		    height: 38px;
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
		 .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;
	
	    height: 42px;
	    margin-left: 9px;
        }
        
        .radio-group {
		  display: flex;
		  gap: 20px;
		  margin-bottom: 15px;
		  align-items: center;
		}
		
		.radio-group label {
		  display: flex;
		
		  gap: 5px;
		  font-size: 18px;
		  padding: 4px 8px;
		  border: 1px solid #ccc;
		  border-radius: 6px;
		  cursor: pointer;
		  transition: all 0.2s;
		}
		
		.radio-group input[type="radio"] {
		  accent-color: #007bff; /* 파란색 포인트 */
		  cursor: pointer;
		}
		
		.radio-group label:hover {
		  background-color: #f0f0f0;
		  border-color: #007bff;
		}
.legend {
  font-family: 'Arial', sans-serif;
  background: #f9f9f9;
  padding: 12px 20px;
  border-radius: 8px;
  max-width:1100px;
  margin: 20px auto;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

.legend-items {
  display: flex;
  gap: 40px;
  flex-wrap: nowrap;
  justify-content: flex-start;
  align-items: center; /* 세로 정렬 */
}

.legend-item {
  white-space: nowrap;
  font-size: 15px;
}

.legend-item h3 {
  margin: 0;
  font-weight: 800;
  font-size: 18px;
  color: #333;
}
.legend-item strong {
  color: #222;
  margin-right: 6px;
  font-weight: 700;
}


    </style>
</head>
<body>

    <main class="main">
        <div class="tab">
        
        
        
        
        

            <div class="button-container">
            
             <div class="box1">
			<p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
			
			<input type="hidden" id="id" name="id">

			
			
			           <label class="daylabel">검색 날짜 :</label>
				<input type="text" autocomplete="off"class="daySet" id="startDate" style="font-size: 16px; margin-bottom:10px;" placeholder="시작 날짜 선택">
				
				<span class="mid" style="font-size: 20px; font-weight: bold; margin-botomm:10px;"> ~ </span>
	
				<input type="text"autocomplete="off" class="daySet" id="endDate" style="font-size: 16px; margin-bottom:10px;" placeholder="종료 날짜 선택">
			
			<label class="daylabel">설비명 :</label>
			<select name="mch_name"id="mch_name" class="dayselect" style="width: 20%; font-size: 15px; height: 34px; text-align: center; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px;">
			    <option value="">전체</option>
                <option value="G-800">G-800</option>
                <option value="G-600">G-600</option>
                <option value="k_balck">K-BLACK</option>
                <option value="공용설비">공용설비</option>
                <option value="방청">방청</option>
                <option value="이코팅 1호기">이코팅 1호기</option>
                <option value="이코팅 2호기">이코팅 2호기</option>
                <option value="세척 공통">세척 공통</option>
                <option value="세척 1호기">세척 1호기</option>
                <option value="세척 2호기">세척 2호기</option>
			</select>


    
			</div>
                <button class="select-button">
                    <img src="/chunil/css/tabBar/search-icon.png" alt="select" class="button-image">조회
                </button>
                <button class="insert-button">
                    <img src="/chunil/css/tabBar/add-outline.png" alt="insert" class="button-image">추가
                </button>

                <button class="delete-button">
				    <img src="/chunil/css/tabBar/xDel3.png" alt="delete" class="button-image"> 삭제
				</button>
				
				
            </div>
        </div>

		





        <div class="view">
            <div id="dataList"></div>
        </div>
    </main>


<div id="modalContainer" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>관리게획서 및 작업표준서</h2>
       <form id="corrForm" autocomplete="off" enctype="multipart/form-data">

          <label>저장 날짜</label>
			  <input type="text"name="cr_date"  class="daySet" placeholder="일 선택" style="text-align: left;">
           
              <input type="hidden" id="idx" name="idx" />
            <label>설비</label>
			
			<select name="mch_name" class="daySet" style="text-align: left;">
			    <option value="G-800">G-800</option>
			    <option value="G-600">G-600</option>
			    <option value="k_balck">K-BLACK</option>
			    <option value="공용설비">공용설비</option>
			    <option value="방청">방청</option>
			    <option value="이코팅 1호기">이코팅 1호기</option>
			    <option value="이코팅 2호기">이코팅 2호기</option>
			    <option value="세척 공통">세척 공통</option>
			    <option value="세척 1호기">세척 1호기</option>
			    <option value="세척 2호기">세척 2호기</option>
			</select>
            
  
  

	
			<label>관리계획서</label>
			<input type="file" name="box1" id="fileInput" placeholder="관리계획서">
			<span id="box1FileName"></span>
			<label>작업표준서</label>
			<input type="file" name="box2" id="fileInput" placeholder="작업표준서">
			<span id="box2FileName"></span>
			<label>설비점검일지</label>
			<input type="file" name="box3" id="fileInput" placeholder="설비점검일지">
			<span id="box3FileName"></span>
			<label>MSDS</label>
			<input type="file" name="box4" id="fileInput" placeholder="MSDS">
			<span id="box4FileName"></span>
            <label>비고</label>
			 <input type="text"  name="memo" placeholder="비고 입력">
	

            <button type="submit" id="saveCorrStatus">저장</button>
            <button type="button" id="closeModal">닫기</button>
        </form>
    </div>
</div>

<script>
let now_page_code = "i01";
let dataTable;
let selectedRow;

$(document).ready(function () {
    var today = new Date();
    var yesterday = new Date(today);
    yesterday.setDate(today.getDate() - 1);

    function formatDate(date) {
        var year = date.getFullYear();
        var month = ("0" + (date.getMonth() + 1)).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        return year + "-" + month + "-" + day;
    }

    $("#startDate").val(formatDate(yesterday));
    $("#endDate").val(formatDate(today));

    getDataList();

    $(".insert-button").click(function () {
        $("#corrForm")[0].reset();
        $("#idx").val("");
      
        var today = new Date();
        var year = today.getFullYear();
        var month = ("0" + (today.getMonth() + 1)).slice(-2);
        var day = ("0" + today.getDate()).slice(-2);
        var todayStr = year + "-" + month + "-" + day;
        $("input[name='cr_date']").val(todayStr);
        $("#box1FileName").text("");
        $("#box2FileName").text("");
        $("#box3FileName").text("");
        $("#box4FileName").text("");
        let modal = $("#modalContainer");
        modal.show();
        modal.addClass("show");
    });

    $(".close, #closeModal").click(function () {
        $("#modalContainer").removeClass("show").hide();
    });

    $("#mch_name").on("change", function () {
        console.log("선택된 설비명:", $(this).val());
    });

    $(".select-button").click(function () {
        var mch_name = $("#mch_name").val();
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();

        dataTable.setData("/chunil/user/standardDoc/list", {
            mch_name: mch_name,
            startDate: startDate,
            endDate: endDate
        });
    });

    $("#saveCorrStatus").click(function (event) {
        event.preventDefault();

        const formElement = document.getElementById("corrForm");
        const formData = new FormData(formElement);

        if (!formData.get("idx") || formData.get("idx").trim() === "") {
            formData.delete("idx");
        }

        for (let pair of formData.entries()) {
            console.log(pair[0] + ": " + pair[1]);
        }

        $.ajax({
            url: "/chunil/user/standardDoc/insert",
            type: "POST",
            data: formData,
            dataType: "json",
            processData: false,
            contentType: false,
            success: function (response) {
                if (response.result === "success") {
                    alert("관리계획서 및 작업 표준서 성공적으로 저장되었습니다!");
                    $("#modalContainer").hide();
                    getDataList();
                } else {
                    alert("저장 실패: " + (response.message || "알 수 없는 오류"));
                }
            },
            error: function () {
                alert("서버 오류 발생!");
            }
        });
    });

    $(".delete-button").click(function(event) {
        event.preventDefault();

        if (!selectedRow) {
            alert("삭제할 행을 선택하세요.");
            return;
        }

        var idx = selectedRow.getData().idx;

        if (!idx) {
            alert("삭제할 항목이 없습니다.");
            return;
        }

        if (!confirm("정말 삭제하시겠습니까?")) {
            return;
        }

        var requestData = JSON.stringify({ "idx": idx });

        $.ajax({
            url: "/chunil/user/standardDoc/del",
            type: "POST",
            contentType: "application/json",
            data: requestData,
            dataType: "json",
            success: function(response) {
                alert("삭제가 완료되었습니다.");
                dataTable.replaceData();
            },
            error: function(xhr, status, error) {
                alert("삭제 중 오류가 발생했습니다: " + error);
            }
        });
    });
});

// getDataList 함수는 $(document).ready 바깥에 선언
function getDataList() {
    dataTable = new Tabulator("#dataList", {
        height: "760px",
        layout: "fitColumns",
        headerHozAlign: "center",
        columnHeaderVertAlign: "middle",
        rowVertAlign: "middle",
        ajaxConfig: "POST",
        ajaxLoader: false,
        ajaxURL: "/chunil/user/standardDoc/list",
        ajaxParams: {
            mch_name: $("#mch_name").val() || "",
            startDate: $("#startDate").val() || "",
            endDate: $("#endDate").val() || ""
        },
        placeholder: "조회된 데이터가 없습니다.",
        ajaxResponse: function (url, params, response) {
            console.log("서버 응답 데이터:", response);
            return response;
        },
        columns: [
            { title: "NO2", field: "idx", visible: false },
            { title: "No", formatter: "rownum", hozAlign: "center", width: 70, headerSort: false },
            { title: "생성", field: "cr_date", width: 120, hozAlign: "center" },
            { title: "설비", field: "mch_name", width: 120, hozAlign: "center" },
            {
                title: "관리계획서", field: "box1",
                hozAlign: "center",
                width: 250,
                formatter: function(cell, formatterParams, onRendered) {
                    const fileName = cell.getValue();
                    if (!fileName) return "";
                    return '<a href="/chunil/download_standardDoc?filename=' +
                        encodeURIComponent(fileName + "") +
                        '" target="_blank">' +
                        fileName  
                        '</a>';
                }
            },
            {
                title: "작업표준서", field: "box2",
                hozAlign: "center",
                width: 250,
                formatter: function(cell, formatterParams, onRendered) {
                    const fileName = cell.getValue();
                    if (!fileName) return "";
                    return '<a href="/chunil/download_standardDoc?filename=' +
                        encodeURIComponent(fileName + "") +
                        '" target="_blank">' +
                        fileName  
                        '</a>';
                }
            },
            {
                title: "설비점검일지", field: "box3",
                hozAlign: "center",
                width: 250,
                formatter: function(cell, formatterParams, onRendered) {
                    const fileName = cell.getValue();
                    if (!fileName) return "";
                    return '<a href="/chunil/download_standardDoc?filename=' +
                        encodeURIComponent(fileName + "") +
                        '" target="_blank">' +
                        fileName  
                        '</a>';
                }
            },
            {
                title: "MSDS", field: "box4",
                hozAlign: "center",
                width: 250,
                formatter: function(cell, formatterParams, onRendered) {
                    const fileName = cell.getValue();
                    if (!fileName) return "";
                    return '<a href="/chunil/download_standardDoc?filename=' +
                        encodeURIComponent(fileName + "") +
                        '" target="_blank">' +
                        fileName 
                        '</a>';
                }
            },
            { title: "비고", field: "memo", width: 300, hozAlign: "center" }
        ],
        rowClick: function (e, row) {
            $("#dataList .tabulator-row").removeClass("row_select");
            row.getElement().classList.add("row_select");
            selectedRow = row;
            console.log("선택된 row idx:", selectedRow.getData().idx);
        },
        rowDblClick: function (e, row) {
            const rowData = row.getData();
            $("input[name='idx']").val(rowData.idx);
            $("input[name='cr_date']").val(rowData.cr_date);
            $("select[name='mch_name']").val(rowData.mch_name);
            // 파일 input에는 값을 넣지 않는다!
            $("input[name='memo']").val(rowData.memo);

            // 파일명 표시 (있으면 "기존 파일: 파일명", 없으면 "")
            $("#box1FileName").text(rowData.box1 ? "기존 관리계획서 : " + rowData.box1 : "");
            $("#box2FileName").text(rowData.box2 ? "기존 작업표준서 : " + rowData.box2 : "");
            $("#box3FileName").text(rowData.box3 ? "기존 설비점검일지 : " + rowData.box3 : "");
            $("#box4FileName").text(rowData.box4 ? "기존 MSDS : " + rowData.box4 : "");

            let modal = $("#modalContainer");
            modal.show();
            setTimeout(function() {
                modal.addClass("show");
            }, 10);
        }
    });
}

</script>
</body>
</html>
