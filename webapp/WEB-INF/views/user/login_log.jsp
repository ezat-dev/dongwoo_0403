<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<title>로그인 이력</title>
<%@include file="../include/pluginpage.jsp" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Tabulator -->
<link href="https://unpkg.com/tabulator-tables@5.6.4/dist/css/tabulator.min.css" rel="stylesheet">
<script src="https://unpkg.com/tabulator-tables@5.6.4/dist/js/tabulator.min.js"></script>

<style>
body{
    font-family: Arial, sans-serif;
    background:#f4f6f9;
    margin:20px;
}

.page-title{
    font-size:20px;
    font-weight:600;
    margin-bottom:15px;
}

#loginLogTable{
    background:#fff;
    border-radius:6px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
}
</style>

</head>

<body>

<div class="page-title">로그인 이력</div>

<div id="loginLogTable"></div>

<script>

let now_page_code = "a06";

$(function(){

    new Tabulator("#loginLogTable", {
        height: "600px",
        layout: "fitColumns",
        ajaxURL: "/chunil/user/login/log/list", // 컨트롤러 URL
        ajaxConfig: "POST",
        ajaxResponse:function(url, params, response){
            return response.data; // { data : [...] } 구조 기준
        },
        pagination: "local",
        paginationSize: 20,
        paginationSizeSelector:[20,50,100],
        initialSort:[
            {column:"login_dt", dir:"desc"}
        ],
        columns:[
            {title:"NO", formatter:"rownum", width:70, hozAlign:"center"},
            { 
                title:"ID", 
                field:"user_id", 
                width:140,
                formatter:function(cell, formatterParams, onRendered){
                    return cell.getValue() === "q" ? "EZ_ADMIN" : cell.getValue();
                }
            },
            {title:"이름", field:"user_name", width:120},
            {title:"부서", field:"user_busu", width:120},
            {title:"직급", field:"user_jick", width:120},
            {
                title:"로그인 시간",
                field:"login_dt",
                width:180,
                hozAlign:"center"
            },
            {title:"메모", field:"memo", widthGrow:1}
        ],
    });

});
</script>

</body>
</html>
