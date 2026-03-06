<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>점검일정 체크</title>
<%@include file="../include/pluginpage.jsp" %>    
<style>
.search{
	height:40px;
}
.container {
	display: flex;
	justify-content: space-between;
	padding: 20px;
	margin-left:1008px;
	margin-top:200px;
}
    
</style>
    
    
<body>

	<main class="main">
    	<!-- 조회조건 표시 -->
    	<div class="search">
    		
    	</div>
    	
    	
		<jsp:include page="../include/tabBar.jsp"/>
	   
	    
	    <!-- 화면표시 -->
	    <div class="view">
	    	
	    </div>
	    

	</main>
	
<script>
	//전역변수
    let now_page_code = "i02";
	//로드
	$(function(){
		$(".headerP").text("문서관리 - 점검일정체크");
	});

	//이벤트
	
	
	//함수

</script>

</body>
</html>
