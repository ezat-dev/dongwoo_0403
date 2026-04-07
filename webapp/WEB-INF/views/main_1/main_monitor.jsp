<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_monitor/vars.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_monitor/style.css">
  
  
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
  <title>메인 모니터링</title>
</head>
<body>
  <div class="group-1">

    <div class="over-view-1">
      <div class="hogi-12">
        <img class="bcf-12" src="${pageContext.request.contextPath}/img/main_monitor/bcf-120.png" />
        <img class="bcf-12-alarm" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-alarm0.png" />
        <img class="bcf-12-belt" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-belt0.png" />
        <img class="bcf-12-box-on-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-box-on-10.png" />
        <img class="bcf-12-box-off-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-box-off-10.png" />
        <img class="bcf-12-box-on-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-box-on-20.png" />
        <img class="bcf-12-box-off-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-box-off-20.png" />
        <img class="bcf-12-box-on-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-box-on-30.png" />
        <img class="bcf-12-box-off-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-box-off-30.png" />
        <img class="bcf-12-box-on-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-box-on-40.png" />
        <img class="bcf-12-box-off-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-box-off-40.png" />
        <img class="bcf-12-tray-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-tray-20.png" />
        <img class="bcf-12-tray-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-tray-10.png" />
        <div class="back-12"></div>
        <div class="bcf-12-open-1"></div>
        <div class="bcf-12-close-1"></div>
        <div class="bcf-12-open-2"></div>
        <div class="bcf-12-close-2"></div>
        <div class="bcf-12-open-3"></div>
        <div class="bcf-12-close-3"></div>
        <div class="bcf-12-stop"></div>
        <div class="bcf-12-up"></div>
        <div class="bcf-12-down"></div>
        <img class="bcf-12-heat-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-heat-off0.png" />
        <img class="bcf-12-heat-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-heat-on0.png" />
        <img class="bcf-12-obj-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-obj-off0.png" />
        <img class="bcf-12-obj-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-obj-on0.png" />
        <img class="bcf-12-pen-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-pen-20.png" />
        <img class="bcf-12-pen-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-pen-10.png" />
        <div class="bcf-12-jogging"></div>
        <img class="bcf-12-moter-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-moter-off0.png" />
        <img class="bcf-12-moter-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-12-moter-on0.png" />
      </div>
      <div class="hogi-1">
        <img class="bcf-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10.png" />
        <img class="bcf-1-alarm" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-alarm0.png" />
        <img class="bcf-1-belt" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-belt0.png" />
        <img class="bcf-1-box-on-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-box-on-10.png" />
        <img class="bcf-1-box-off-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-box-off-10.png" />
        <img class="bcf-1-box-on-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-box-on-20.png" />
        <img class="bcf-1-box-off-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-box-off-20.png" />
        <img class="bcf-1-box-on-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-box-on-30.png" />
        <img class="bcf-1-box-off-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-box-off-30.png" />
        <img class="bcf-1-box-on-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-box-on-40.png" />
        <img class="bcf-1-box-off-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-box-off-40.png" />
        <img class="bcf-1-tray-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-tray-20.png" />
        <img class="bcf-1-tray-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-tray-10.png" />
        <div class="back-1"></div>
        <div class="bcf-1-open-1"></div>
        <div class="bcf-1-close-1"></div>
        <div class="bcf-1-open-2"></div>
        <div class="bcf-1-close-2"></div>
        <div class="bcf-1-stop"></div>
        <div class="bcf-1-up"></div>
        <div class="bcf-1-down"></div>
        <div class="bcf-1-dt-ez-50"></div>
        <img class="bcf-1-heat-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-heat-off0.png" />
        <img class="bcf-1-heat-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-heat-on0.png" />
        <img class="bcf-1-obj-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-obj-off0.png" />
        <img class="bcf-1-obj-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-obj-on0.png" />
        <img class="bcf-1-pen-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-pen-20.png" />
        <img class="bcf-1-pen-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-pen-10.png" />
        <div class="bcf-1-jogging"></div>
        <img class="bcf-1-moter-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-moter-off0.png" />
        <img class="bcf-1-moter-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-1-moter-on0.png" />
      </div>
      <div class="hogi-2">
        <img class="bcf-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-20.png" />
        <img class="bcf-2-alarm" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-alarm0.png" />
        <img class="bcf-2-belt" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-belt0.png" />
        <img class="bcf-2-box-on-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-box-on-10.png" />
        <img class="bcf-2-box-off-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-box-off-10.png" />
        <img class="bcf-2-box-on-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-box-on-20.png" />
        <img class="bcf-2-box-off-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-box-off-20.png" />
        <img class="bcf-2-box-on-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-box-on-30.png" />
        <img class="bcf-2-box-off-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-box-off-30.png" />
        <img class="bcf-2-box-on-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-box-on-40.png" />
        <img class="bcf-2-box-off-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-box-off-40.png" />
        <img class="bcf-2-tray-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-tray-20.png" />
        <img class="bcf-2-tray-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-tray-10.png" />
        <div class="back-2"></div>
        <div class="bcf-2-open-1"></div>
        <div class="bcf-2-close-1"></div>
        <div class="bcf-2-open-2"></div>
        <div class="bcf-2-close-2"></div>
        <div class="bcf-2-stop"></div>
        <div class="bcf-2-up"></div>
        <div class="bcf-2-down"></div>
        <div class="bcf-2-dt"></div>
        <img class="bcf-2-heat-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-heat-off0.png" />
        <img class="bcf-2-heat-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-heat-on0.png" />
        <img class="bcf-2-obj-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-obj-off0.png" />
        <img class="bcf-2-obj-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-obj-on0.png" />
        <img class="bcf-2-pen-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-pen-20.png" />
        <img class="bcf-2-pen-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-pen-10.png" />
        <div class="bcf-2-jogging"></div>
        <img class="bcf-2-moter-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-moter-off0.png" />
        <img class="bcf-2-moter-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-2-moter-on0.png" />
      </div>
      <div class="hogi-3">
        <img class="bcf-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-30.png" />
        <img class="bcf-3-alarm" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-alarm0.png" />
        <img class="bcf-3-belt" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-belt0.png" />
        <img class="bcf-3-box-on-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-box-on-10.png" />
        <img class="bcf-3-box-off-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-box-off-10.png" />
        <img class="bcf-3-box-on-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-box-on-20.png" />
        <img class="bcf-3-box-off-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-box-off-20.png" />
        <img class="bcf-3-box-on-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-box-on-30.png" />
        <img class="bcf-3-box-off-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-box-off-30.png" />
        <img class="bcf-3-box-on-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-box-on-40.png" />
        <img class="bcf-3-box-off-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-box-off-40.png" />
        <img class="bcf-3-tray-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-tray-20.png" />
        <img class="bcf-3-tray-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-tray-10.png" />
        <div class="back-3"></div>
        <div class="bcf-3-open-1"></div>
        <div class="bcf-3-close-1"></div>
        <div class="bcf-3-open-2"></div>
        <div class="bcf-3-close-2"></div>
        <div class="bcf-3-stop"></div>
        <div class="bcf-3-up"></div>
        <div class="bcf-3-down"></div>
        <div class="bcf-3-dt"></div>
        <img class="bcf-3-heat-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-heat-off0.png" />
        <img class="bcf-3-heat-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-heat-on0.png" />
        <img class="bcf-3-obj-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-obj-off0.png" />
        <img class="bcf-3-obj-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-obj-on0.png" />
        <img class="bcf-3-pen-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-pen-20.png" />
        <img class="bcf-3-pen-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-pen-10.png" />
        <div class="bcf-3-jogging"></div>
        <img class="bcf-3-moter-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-moter-off0.png" />
        <img class="bcf-3-moter-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-3-moter-on0.png" />
      </div>
      <div class="hogi-4">
        <img class="bcf-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-40.png" />
        <img class="bcf-4-alarm" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-alarm0.png" />
        <img class="bcf-4-belt" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-belt0.png" />
        <img class="bcf-4-box-on-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-box-on-10.png" />
        <img class="bcf-4-box-off-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-box-off-10.png" />
        <img class="bcf-4-box-on-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-box-on-20.png" />
        <img class="bcf-4-box-off-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-box-off-20.png" />
        <img class="bcf-4-box-on-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-box-on-30.png" />
        <img class="bcf-4-box-off-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-box-off-30.png" />
        <img class="bcf-4-box-on-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-box-on-40.png" />
        <img class="bcf-4-box-off-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-box-off-40.png" />
        <img class="bcf-4-tray-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-tray-20.png" />
        <img class="bcf-4-tray-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-tray-10.png" />
        <div class="back-4"></div>
        <div class="bcf-4-open-1"></div>
        <div class="bcf-4-close-1"></div>
        <div class="bcf-4-open-2"></div>
        <div class="bcf-4-close-2"></div>
        <div class="bcf-4-stop"></div>
        <div class="bcf-4-up"></div>
        <div class="bcf-4-down"></div>
        <div class="bcf-4-dt"></div>
        <img class="bcf-4-heat-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-heat-off0.png" />
        <img class="bcf-4-heat-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-heat-on0.png" />
        <img class="bcf-4-obj-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-obj-off0.png" />
        <img class="bcf-4-obj-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-obj-on0.png" />
        <img class="bcf-4-pen-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-pen-20.png" />
        <img class="bcf-4-pen-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-pen-10.png" />
        <div class="bcf-4-jogging"></div>
        <img class="bcf-4-moter-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-moter-off0.png" />
        <img class="bcf-4-moter-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-4-moter-on0.png" />
      </div>
      <div class="hogi-10">
        <img class="bcf-10" src="${pageContext.request.contextPath}/img/main_monitor/bcf-100.png" />
        <img class="bcf-10-alarm" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-alarm0.png" />
        <img class="bcf-10-belt" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-belt0.png" />
        <img class="bcf-10-box-on-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-box-on-10.png" />
        <img class="bcf-10-box-off-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-box-off-10.png" />
        <img class="bcf-10-box-on-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-box-on-20.png" />
        <img class="bcf-10-box-off-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-box-off-20.png" />
        <img class="bcf-10-box-on-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-box-on-30.png" />
        <img class="bcf-10-box-off-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-box-off-30.png" />
        <img class="bcf-10-box-on-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-box-on-40.png" />
        <img class="bcf-10-box-off-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-box-off-40.png" />
        <img class="bcf-10-tray-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-tray-20.png" />
        <img class="bcf-10-tray-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-tray-10.png" />
        <div class="back-10"></div>
        <div class="bcf-10-open-1"></div>
        <div class="bcf-10-close-1"></div>
        <div class="bcf-10-open-2"></div>
        <div class="bcf-10-close-2"></div>
        <div class="bcf-10-stop"></div>
        <div class="bcf-10-up"></div>
        <div class="bcf-10-down"></div>
        <div class="bcf-10-dt"></div>
        <img class="bcf-10-heat-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-heat-off0.png" />
        <img class="bcf-10-heat-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-heat-on0.png" />
        <img class="bcf-10-obj-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-obj-off0.png" />
        <img class="bcf-10-obj-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-obj-on0.png" />
        <img class="bcf-10-pen-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-pen-20.png" />
        <img class="bcf-10-pen-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-pen-10.png" />
        <div class="bcf-10-jogging"></div>
        <img class="bcf-10-moter-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-moter-off0.png" />
        <img class="bcf-10-moter-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-10-moter-on0.png" />
      </div>
      <div class="hogi-5">
        <img class="bcf-5" src="${pageContext.request.contextPath}/img/main_monitor/bcf-50.png" />
        <img class="bcf-5-alarm" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-alarm0.png" />
        <img class="bcf-5-belt" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-belt0.png" />
        <img class="bcf-5-box-on-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-box-on-10.png" />
        <img class="bcf-5-box-off-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-box-off-10.png" />
        <img class="bcf-5-box-on-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-box-on-20.png" />
        <img class="bcf-5-box-off-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-box-off-20.png" />
        <img class="bcf-5-box-on-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-box-on-30.png" />
        <img class="bcf-5-box-off-3" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-box-off-30.png" />
        <img class="bcf-5-box-on-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-box-on-40.png" />
        <img class="bcf-5-box-off-4" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-box-off-40.png" />
        <img class="bcf-5-tray-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-tray-20.png" />
        <img class="bcf-5-tray-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-tray-10.png" />
        <div class="back-5"></div>
        <div class="bcf-5-open-1"></div>
        <div class="bcf-5-close-1"></div>
        <div class="bcf-5-open-2"></div>
        <div class="bcf-5-close-2"></div>
        <div class="bcf-5-open-3"></div>
        <div class="bcf-5-close-3"></div>
        <div class="bcf-5-stop"></div>
        <div class="bcf-5-up"></div>
        <div class="bcf-5-down"></div>
        <div class="bcf-5-dt"></div>
        <img class="bcf-5-heat-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-heat-off0.png" />
        <img class="bcf-5-heat-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-heat-on0.png" />
        <img class="bcf-5-obj-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-obj-off0.png" />
        <img class="bcf-5-obj-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-obj-on0.png" />
        <img class="bcf-5-pen-2" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-pen-20.png" />
        <img class="bcf-5-pen-1" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-pen-10.png" />
        <div class="bcf-5-jogging"></div>
        <img class="bcf-5-moter-off" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-moter-off0.png" />
        <img class="bcf-5-moter-on" src="${pageContext.request.contextPath}/img/main_monitor/bcf-5-moter-on0.png" />
      </div>
    </div>
  </div>
  
</body>
</html>