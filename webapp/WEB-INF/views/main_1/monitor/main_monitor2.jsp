<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<%= ctx %>/img/main_monitor_2/vars.css">
  <link rel="stylesheet" href="<%= ctx %>/img/main_monitor_2/style.css">
  
  
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
   html, body { height: 100%; overflow: hidden; }
   .ov-tab-group {
     position: fixed; top: 10px; right: 14px; z-index: 9999;
     display: flex; align-items: center;
     background: rgba(255,255,255,0.92); border: 1px solid #CBD5E0;
     border-radius: 8px; overflow: hidden;
     box-shadow: 0 2px 8px rgba(0,0,0,0.12);
     backdrop-filter: blur(4px);
   }
   .ov-tab {
     padding: 6px 16px; font-size: 11px; font-weight: 700;
     letter-spacing: .6px; color: #718096;
     background: none; border: none; cursor: pointer;
     transition: background .13s, color .13s;
     white-space: nowrap; font-family: 'Segoe UI', sans-serif;
   }
   .ov-tab:not(:last-child) { border-right: 1px solid #CBD5E0; }
   .ov-tab:hover { background: #EBF8FF; color: #3182CE; }
   .ov-tab.active { background: #3182CE; color: #fff; }

   /* ── BCF 명칭 / 운전모드 라벨 ── */
   .bcf-name-lbl {
     position: absolute;
     height: 26px;
     display: flex; align-items: center; justify-content: center;
     font-size: 13px; font-weight: 900; letter-spacing: .8px;
     background: linear-gradient(160deg, #f8fafc 0%, #eff6ff 100%);
     color: #1d4ed8;
     border: 1px solid #bfdbfe;
     border-radius: 6px 6px 0 0;
     top: 18px; z-index: 200;
     font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
     box-shadow: 0 1px 4px rgba(59,130,246,.12), inset 0 1px 0 rgba(255,255,255,.85);
     text-shadow: 0 1px 0 rgba(255,255,255,.85);
   }
   .bcf-mode-lbl {
     position: absolute;
     height: 26px;
     display: flex; align-items: center; justify-content: center;
     font-size: 12px; font-weight: 800;
     background: linear-gradient(160deg, #f0fdf4 0%, #dcfce7 100%);
     color: #15803d;
     border: 1px solid #bbf7d0;
     border-top: none;
     border-radius: 0 0 6px 6px;
     top: 44px; z-index: 200;
     font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
     letter-spacing: .2px;
     transition: background .2s, box-shadow .2s;
     box-shadow: 0 1px 4px rgba(16,185,129,.12), inset 0 1px 0 rgba(255,255,255,.7);
     text-shadow: 0 1px 0 rgba(255,255,255,.7);
   }

   .group-3 [class*="-jogging-"],
   .group-3 [class*="-open-"],
   .group-3 [class*="-close-"],
   .group-3 [class$="-stop"],
   .group-3 [class*="-stop "],
   .group-3 [class$="-up"],
   .group-3 [class*="-up "],
   .group-3 [class$="-down"],
   .group-3 [class*="-down "] {
     display: flex;
     align-items: center;
     justify-content: center;
     text-align: center;
     font-family: 'Malgun Gothic', 'Segoe UI', Arial, sans-serif;
     font-size: 12px;
     font-weight: 800;
     line-height: 1;
     letter-spacing: 0;
     white-space: nowrap;
     overflow: hidden;
     color: #111827;
     border-color: rgba(17, 24, 39, .72) !important;
     border-radius: 3px;
     box-shadow: inset 0 1px 0 rgba(255,255,255,.45), 0 1px 3px rgba(15,23,42,.22);
     text-shadow: 0 1px 0 rgba(255,255,255,.45);
   }

   .group-3 [class*="-jogging-"] {
     background: linear-gradient(180deg, #d9f99d 0%, #86efac 100%) !important;
   }
   .group-3 [class*="-close-"] {
     background: linear-gradient(180deg, #bbf7d0 0%, #22c55e 100%) !important;
     font-size: 11px !important;
   }
   .group-3 [class*="-open-"] {
     color: #fff;
     background: linear-gradient(180deg, #fb7185 0%, #dc2626 100%) !important;
     text-shadow: 0 1px 1px rgba(0,0,0,.35);
   }
   .group-3 [class$="-down"],
   .group-3 [class*="-down "] {
     background: linear-gradient(180deg, #fef08a 0%, #facc15 100%) !important;
   }
   .group-3 [class$="-up"],
   .group-3 [class*="-up "],
   .group-3 [class$="-stop"],
   .group-3 [class*="-stop "] {
     background: linear-gradient(180deg, #e0f2fe 0%, #60a5fa 100%) !important;
   }

   @keyframes penSpinRight {
     from { transform: rotate(0deg); }
     to   { transform: rotate(360deg); }
   }
   .group-3 img[class*="-pen-"] {
     transform-origin: 50% 50%;
     animation: penSpinRight 5.5s linear infinite;
     will-change: transform;
   }
   .group-3 img[class*="-pen-"].pen-rotating {
     animation-play-state: running;
   }
   .group-3 img[class*="-pen-"].pen-stopped {
     animation-play-state: paused;
   }
   </style>
  <title>Document</title>
</head>
<body>
  <div class="ov-tab-group">
    <button class="ov-tab" onclick="window.parent.goOverview(1)">OVERVIEW-1</button>
    <button class="ov-tab active">OVERVIEW-2</button>
  </div>
  <div class="group-3">

    <!-- BCF 명칭 / 운전모드 라벨 -->
    <div class="bcf-name-lbl" style="left:345px;width:113px">NO.11</div>
    <div class="bcf-mode-lbl" data-mode-tag="bcf11_25" style="left:345px;width:113px">확인중</div>

    <div class="bcf-name-lbl" style="left:563px;width:152px">NO.8</div>
    <div class="bcf-mode-lbl" data-mode-tag="bcf8_25" style="left:563px;width:152px">확인중</div>

    <div class="bcf-name-lbl" style="left:809px;width:152px">NO.9</div>
    <div class="bcf-mode-lbl" data-mode-tag="bcf9_25" style="left:809px;width:152px">확인중</div>

    <div class="bcf-name-lbl" style="left:1055px;width:152px">NO.7</div>
    <div class="bcf-mode-lbl" data-mode-tag="bcf7_25" style="left:1055px;width:152px">확인중</div>

    <div class="bcf-name-lbl" style="left:1314px;width:222px">NO.6</div>
    <div class="bcf-mode-lbl" data-mode-tag="bcf6_25" style="left:1314px;width:222px">확인중</div>

    <div class="group-2">
      <div class="bcf-11">
        <img class="bcf-112" src="<%= ctx %>/img/main_monitor_2/bcf-111.png" />
        <img class="bcf-11-alarm bcf11_65" src="<%= ctx %>/img/main_monitor_2/bcf-11-alarm0.png" />
        <img class="bcf-11-obj-off" src="<%= ctx %>/img/main_monitor_2/bcf-11-obj-off0.png" />
        <img class="bcf-11-obj-on" src="<%= ctx %>/img/main_monitor_2/bcf-11-obj-on0.png" />
        <img class="bcf-11-moter-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-off-10.png" />
        <img class="bcf-11-moter-on-1 bcf11_56 bcf11_57" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-on-10.png" />
        <img class="bcf-11-moter-off-12" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-off-11.png" />
        <img class="bcf-11-moter-on-12 bcf11_79 bcf11_80" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-on-11.png" />
        <img class="bcf-11-moter-off-13" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-off-12.png" />
        <img class="bcf-11-moter-on-13 bcf11_83 bcf11_84" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-on-12.png" />
        <img class="bcf-11-moter-off-14" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-off-13.png" />
        <img class="bcf-11-moter-on-14 bcf11_60" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-on-13.png" />
        <img class="bcf-11-moter-off-15" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-off-14.png" />
        <img class="bcf-11-moter-on-15 bcf11_62" src="<%= ctx %>/img/main_monitor_2/bcf-11-moter-on-14.png" />
        <img class="bcf-11-heat-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-11-heat-off-10.png" />
        <img class="bcf-11-heat-on-1" src="<%= ctx %>/img/main_monitor_2/bcf-11-heat-on-10.png" />
        <img class="bcf-11-heat-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-11-heat-off-20.png" />
        <img class="bcf-11-heat-on-2 bcf11_97" src="<%= ctx %>/img/main_monitor_2/bcf-11-heat-on-20.png" />
        <div class="bcf-11-jogging-1 bcf11_163">조깅</div>
        <div class="bcf-11-jogging-2 bcf11_162">조깅</div>
        <img class="bcf-11-tray-1 bcf11_40008" src="<%= ctx %>/img/main_monitor_2/bcf-11-tray-10.png" />
        <img class="bcf-11-tray-2 bcf11_40010" src="<%= ctx %>/img/main_monitor_2/bcf-11-tray-20.png" />
        <img class="bcf-11-tray-3 bcf11_40027" src="<%= ctx %>/img/main_monitor_2/bcf-11-tray-30.png" />
        <img class="bcf-11-tray-4 bcf11_40044" src="<%= ctx %>/img/main_monitor_2/bcf-11-tray-40.png" />
        <img class="bcf-11-tray-5 bcf11_40053" src="<%= ctx %>/img/main_monitor_2/bcf-11-tray-50.png" />
        <div class="bcf-11-dt-1 bcf11_40008"></div>
        <div class="bcf-11-dt-2 bcf11_40010"></div>
        <div class="bcf-11-dt-3 bcf11_40027"></div>
        <div class="bcf-11-dt-4 bcf11_40044"></div>
        <div class="bcf-11-dt-5 bcf11_40053"></div>
        <div class="bcf-11-open-1 bcf11_3">열림</div>
        <div class="bcf-11-close-1">닫힘</div>
        <div class="bcf-11-open-2 bcf11_5">열림</div>
        <div class="bcf-11-close-2">닫힘</div>
        <div class="bcf-11-open-3 bcf11_7">열림</div>
        <div class="bcf-11-close-3">닫힘</div>
        <div class="bcf-11-open-4 bcf11_9">열림</div>
        <div class="bcf-11-close-4">닫힘</div>
        <img class="bcf-11-pen-1 bcf11_98" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-11-pen-2 bcf11_100" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-11-pen-3 bcf11_117" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
      </div>
      <div class="bcf-8">
        <img class="bcf-82" src="<%= ctx %>/img/main_monitor_2/bcf-81.png" />
        <img class="bcf-8-alarm bcf8_93" src="<%= ctx %>/img/main_monitor_2/bcf-8-alarm0.png" />
        <img class="bcf-8-moter-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-8-moter-off-10.png" />
        <img class="bcf-8-moter-on-1 bcf8_87 bcf8_88" src="<%= ctx %>/img/main_monitor_2/bcf-8-moter-on-10.png" />
        <img class="bcf-8-moter-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-8-moter-off-20.png" />
        <img class="bcf-8-moter-on-2 bcf8_85 bcf8_86" src="<%= ctx %>/img/main_monitor_2/bcf-8-moter-on-20.png" />
        <img class="bcf-8-heat-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-8-heat-off-20.png" />
        <img class="bcf-8-heat-on-2" src="<%= ctx %>/img/main_monitor_2/bcf-8-heat-on-20.png" />
        <div class="bcf-8-open-1 bcf8_11">열림</div>
        <div class="bcf-8-close-1">닫힘</div>
        <div class="bcf-8-open-2 bcf8_13">열림</div>
        <div class="bcf-8-close-2">닫힘</div>
        <div class="bcf-8-open-3 bcf8_18">열림</div>
        <div class="bcf-8-close-3">닫힘</div>
        <img class="bcf-8-tray-1 bcf8_23" src="<%= ctx %>/img/main_monitor_2/bcf-8-tray-10.png" />
        <img class="bcf-8-tray-2 bcf8_7" src="<%= ctx %>/img/main_monitor_2/bcf-8-tray-20.png" />
        <img class="bcf-8-tray-3 bcf8_116" src="<%= ctx %>/img/main_monitor_2/bcf-8-tray-30.png" />
        <img class="bcf-8-tray-4 bcf8_117" src="<%= ctx %>/img/main_monitor_2/bcf-8-tray-40.png" />
        <img class="bcf-8-tray-5 bcf8_19" src="<%= ctx %>/img/main_monitor_2/bcf-8-tray-50.png" />
        <img class="bcf-8-pen-1 bcf8_113" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-8-pen-2 bcf8_113" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <div class="bcf-8-dt-1"></div>
        <div class="bcf-8-dt-2"></div>
        <img class="bcf-8-box-on-1" src="<%= ctx %>/img/main_monitor_2/bcf-8-box-on-10.png" />
        <img class="bcf-8-box-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-8-box-off-10.png" />
        <img class="bcf-8-box-on-2" src="<%= ctx %>/img/main_monitor_2/bcf-8-box-on-20.png" />
        <img class="bcf-8-box-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-8-box-off-20.png" />
        <img class="bcf-8-box-on-3" src="<%= ctx %>/img/main_monitor_2/bcf-8-box-on-30.png" />
        <img class="bcf-8-box-off-3" src="<%= ctx %>/img/main_monitor_2/bcf-8-box-off-30.png" />
        <img class="bcf-8-box-on-4" src="<%= ctx %>/img/main_monitor_2/bcf-8-box-on-40.png" />
        <img class="bcf-8-box-off-4" src="<%= ctx %>/img/main_monitor_2/bcf-8-box-off-40.png" />
        <div class="bcf-8-stop">정지</div>
        <div class="bcf-8-up bcf8_14">상승</div>
        <div class="bcf-8-down bcf8_15">하강</div>
      </div>
      <div class="bcf-9">
        <img class="bcf-92" src="<%= ctx %>/img/main_monitor_2/bcf-91.png" />
        <img class="bcf-9-alarm" src="<%= ctx %>/img/main_monitor_2/bcf-9-alarm0.png" />
        <img class="bcf-9-moter-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-9-moter-off-10.png" />
        <img class="bcf-9-moter-on-1 bcf9_110 bcf9_111" src="<%= ctx %>/img/main_monitor_2/bcf-9-moter-on-10.png" />
        <img class="bcf-9-moter-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-9-moter-off-20.png" />
        <img class="bcf-9-moter-on-2" src="<%= ctx %>/img/main_monitor_2/bcf-9-moter-on-20.png" />
        <img class="bcf-9-heat-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-9-heat-off-20.png" />
        <img class="bcf-9-heat-on-2" src="<%= ctx %>/img/main_monitor_2/bcf-9-heat-on-20.png" />
        <div class="bcf-9-open-1 bcf9_12">열림</div>
        <div class="bcf-9-close-1">닫힘</div>
        <div class="bcf-9-open-2 bcf9_14">열림</div>
        <div class="bcf-9-close-2">닫힘</div>
        <div class="bcf-9-open-3 bcf9_19">열림</div>
        <div class="bcf-9-close-3">닫힘</div>
        <img class="bcf-9-tray-1 bcf9_2" src="<%= ctx %>/img/main_monitor_2/bcf-9-tray-10.png" />
        <img class="bcf-9-tray-2 bcf9_1" src="<%= ctx %>/img/main_monitor_2/bcf-9-tray-20.png" />
        <img class="bcf-9-tray-3 bcf9_144" src="<%= ctx %>/img/main_monitor_2/bcf-9-tray-30.png" />
        <img class="bcf-9-tray-4 bcf9_145" src="<%= ctx %>/img/main_monitor_2/bcf-9-tray-40.png" />
        <img class="bcf-9-tray-5 bcf9_22" src="<%= ctx %>/img/main_monitor_2/bcf-9-tray-50.png" />
        <img class="bcf-9-pen-1 bcf9_157" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-9-pen-2 bcf9_157" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <div class="bcf-9-dt-1"></div>
        <div class="bcf-9-dt-2"></div>
        <img class="bcf-9-box-on-1" src="<%= ctx %>/img/main_monitor_2/bcf-9-box-on-10.png" />
        <img class="bcf-9-box-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-9-box-off-10.png" />
        <img class="bcf-9-box-on-2" src="<%= ctx %>/img/main_monitor_2/bcf-9-box-on-20.png" />
        <img class="bcf-9-box-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-9-box-off-20.png" />
        <img class="bcf-9-box-on-3" src="<%= ctx %>/img/main_monitor_2/bcf-9-box-on-30.png" />
        <img class="bcf-9-box-off-3" src="<%= ctx %>/img/main_monitor_2/bcf-9-box-off-30.png" />
        <img class="bcf-9-box-on-4" src="<%= ctx %>/img/main_monitor_2/bcf-9-box-on-40.png" />
        <img class="bcf-9-box-off-4" src="<%= ctx %>/img/main_monitor_2/bcf-9-box-off-40.png" />
        <div class="bcf-9-stop">정지</div>
        <div class="bcf-9-up">상승</div>
        <div class="bcf-9-down bcf9_18">하강</div>
      </div>
      <div class="bcf-7">
        <img class="bcf-72" src="<%= ctx %>/img/main_monitor_2/bcf-71.png" />
        <img class="bcf-7-alarm bcf7_40038" src="<%= ctx %>/img/main_monitor_2/bcf-7-alarm0.png" />
        <img class="bcf-7-moter-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-7-moter-off-10.png" />
        <img class="bcf-7-moter-on-1 bcf7_110 bcf7_111" src="<%= ctx %>/img/main_monitor_2/bcf-7-moter-on-10.png" />
        <img class="bcf-7-moter-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-7-moter-off-20.png" />
        <img class="bcf-7-moter-on-2 bcf7_88 bcf7_89" src="<%= ctx %>/img/main_monitor_2/bcf-7-moter-on-20.png" />
        <img class="bcf-7-heat-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-7-heat-off-20.png" />
        <img class="bcf-7-heat-on-2" src="<%= ctx %>/img/main_monitor_2/bcf-7-heat-on-20.png" />
        <div class="bcf-7-open-1 bcf7_12">열림</div>
        <div class="bcf-7-close-1">닫힘</div>
        <div class="bcf-7-open-2 bcf7_14">열림</div>
        <div class="bcf-7-close-2">닫힘</div>
        <div class="bcf-7-open-3 bcf7_19">열림</div>
        <div class="bcf-7-close-3">닫힘</div>
        <img class="bcf-7-tray-1 bcf7_2" src="<%= ctx %>/img/main_monitor_2/bcf-7-tray-10.png" />
        <img class="bcf-7-tray-2 bcf7_1" src="<%= ctx %>/img/main_monitor_2/bcf-7-tray-20.png" />
        <img class="bcf-7-tray-3 bcf7_144" src="<%= ctx %>/img/main_monitor_2/bcf-7-tray-30.png" />
        <img class="bcf-7-tray-4 bcf7_145" src="<%= ctx %>/img/main_monitor_2/bcf-7-tray-40.png" />
        <img class="bcf-7-tray-5 bcf7_22" src="<%= ctx %>/img/main_monitor_2/bcf-7-tray-50.png" />
        <img class="bcf-7-pen-1 bcf7_157" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-7-pen-2 bcf7_157" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <div class="bcf-7-dt-1"></div>
        <div class="bcf-7-dt-2"></div>
        <img class="bcf-7-box-on-1" src="<%= ctx %>/img/main_monitor_2/bcf-7-box-on-10.png" />
        <img class="bcf-7-box-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-7-box-off-10.png" />
        <img class="bcf-7-box-on-2" src="<%= ctx %>/img/main_monitor_2/bcf-7-box-on-20.png" />
        <img class="bcf-7-box-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-7-box-off-20.png" />
        <img class="bcf-7-box-on-3" src="<%= ctx %>/img/main_monitor_2/bcf-7-box-on-30.png" />
        <img class="bcf-7-box-off-3" src="<%= ctx %>/img/main_monitor_2/bcf-7-box-off-30.png" />
        <img class="bcf-7-box-on-4" src="<%= ctx %>/img/main_monitor_2/bcf-7-box-on-40.png" />
        <img class="bcf-7-box-off-4" src="<%= ctx %>/img/main_monitor_2/bcf-7-box-off-40.png" />
        <div class="bcf-7-stop">정지</div>
        <div class="bcf-7-up bcf7_17">상승</div>
        <div class="bcf-7-down bcf7_18">하강</div>
      </div>
      <div class="bcf-6">
        <img class="bcf-62" src="<%= ctx %>/img/main_monitor_2/bcf-61.png" />
        <img class="bcf-6-alarm" src="<%= ctx %>/img/main_monitor_2/bcf-6-alarm0.png" />
        <div class="bcf-6-back-1"></div>
        <div class="bcf-6-back-2"></div>
        <div class="bcf-6-jogging-1 bcf6_303 bcf6_304">조깅</div>
        <!-- <div class="bcf-6-jogging-2">조깅</div> -->
        <div class="bcf-6-jogging-3 bcf6_305 bcf6_306">조깅</div>
        <div class="bcf-6-jogging-4 bcf6_307 bcf6_308">조깅</div>
        <div class="bcf-6-jogging-5 bcf6_309 bcf6_310">조깅</div>
        <div class="bcf-6-jogging-6 bcf6_311 bcf6_312">조깅</div>
        <div class="bcf-6-jogging-7 bcf6_313 bcf6_314">조깅</div>
        <img class="bcf-6-moter-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-off-10.png" />
        <img class="bcf-6-moter-on-1 bcf6_244 bcf6_245" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-on-10.png" />
        <img class="bcf-6-moter-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-off-20.png" />
        <img class="bcf-6-moter-on-2 bcf6_187" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-on-20.png" />
        <img class="bcf-6-moter-off-3" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-off-30.png" />
        <img class="bcf-6-moter-on-3 bcf6_248 bcf6_249" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-on-30.png" />
        <img class="bcf-6-moter-off-4" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-off-40.png" />
        <img class="bcf-6-moter-on-4 bcf6_252 bcf6_253" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-on-40.png" />
        <img class="bcf-6-moter-off-5" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-off-50.png" />
        <img class="bcf-6-moter-on-5 bcf6_256 bcf6_257" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-on-50.png" />
        <img class="bcf-6-moter-off-6" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-off-60.png" />
        <img class="bcf-6-moter-on-6 bcf6_260 bcf6_261" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-on-60.png" />
        <img class="bcf-6-moter-off-7" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-off-70.png" />
        <img class="bcf-6-moter-on-7 bcf6_264 bcf6_265" src="<%= ctx %>/img/main_monitor_2/bcf-6-moter-on-70.png" />
        <img class="bcf-6-tray-1 bcf6_8" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-10.png" />
        <img class="bcf-6-tray-2 bcf6_291" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-20.png" />
        <img class="bcf-6-tray-3 bcf6_39" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-30.png" />
        <img class="bcf-6-tray-4 bcf6_293" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-40.png" />
        <img class="bcf-6-tray-5 bcf6_294" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-50.png" />
        <img class="bcf-6-tray-6 bcf6_295" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-60.png" />
        <img class="bcf-6-tray-7 bcf6_296" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-70.png" />
        <img class="bcf-6-tray-8 bcf6_297" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-80.png" />
        <img class="bcf-6-tray-9 bcf6_298" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-90.png" />
        <img class="bcf-6-tray-10 bcf6_43" src="<%= ctx %>/img/main_monitor_2/bcf-6-tray-100.png" />
        <img class="bcf-6-fire-off-1" src="<%= ctx %>/img/main_monitor_2/bcf-6-fire-off-10.png" />
        <img class="bcf-6-fire-on-1" src="<%= ctx %>/img/main_monitor_2/bcf-6-fire-on-10.png" />
        <img class="bcf-6-fire-off-2" src="<%= ctx %>/img/main_monitor_2/bcf-6-fire-off-20.png" />
        <img class="bcf-6-fire-on-2" src="<%= ctx %>/img/main_monitor_2/bcf-6-fire-on-20.png" />
        <img class="bcf-6-circle-off" src="<%= ctx %>/img/main_monitor_2/bcf-6-circle-off0.png" />
        <img class="bcf-6-circle-on" src="<%= ctx %>/img/main_monitor_2/bcf-6-circle-on0.png" />
        <div class="bcf-6-open-1 bcf6_14">열림</div>
        <div class="bcf-6-close-1">닫힘</div>
        <div class="bcf-6-open-2 bcf6_16">열림</div>
        <div class="bcf-6-close-2">닫힘</div>
        <div class="bcf-6-open-3 bcf6_20">열림</div>
        <div class="bcf-6-close-3">닫힘</div>
        <div class="bcf-6-open-4 bcf6_22">열림</div>
        <div class="bcf-6-close-4">닫힘</div>
        <div class="bcf-6-open-5 bcf6_24">열림</div>
        <div class="bcf-6-close-5">닫힘</div>
        <div class="bcf-6-open-6 bcf6_26">열림</div>
        <div class="bcf-6-close-6">닫힘</div>
        <div class="bcf-6-open-7 bcf6_30">열림</div>
        <div class="bcf-6-close-7">닫힘</div>
        <img class="bcf-6-pen-1 bcf6_224" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-6-pen-2 bcf6_225" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-6-pen-3 bcf6_84" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-6-pen-4 bcf6_226" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-6-pen-5 bcf6_234" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <img class="bcf-6-pen-6 bcf6_234" src="<%= ctx %>/img/main_monitor_1/ffeenn.png" />
        <div class="bcf-6-stop">정지</div>
        <div class="bcf-6-up">상승</div>
        <div class="bcf-6-down bcf6_37">하강</div>
      </div>
    </div>
  </div>

  <!-- ══════════════════════════════════════════
       온도 모니터링 패널 (하단 고정)
  ══════════════════════════════════════════ -->
  <style>
  .tm-panel {
    position: fixed;
    bottom: 0; left: 0; right: 0;
    z-index: 1000;
    background: #ffffff;
    border-top: 1px solid #e2e8f0;
    box-shadow: 0 -4px 20px rgba(0,0,0,0.06);
    padding: 10px 14px 14px;
    box-sizing: border-box;
    font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
  }
  /* 라벨 1개 + 항목 23개 = 24컬럼, 가로 꽉 채움 */
  .tm-grid {
    display: grid;
    grid-template-columns: 60px repeat(23, 1fr);
    gap: 5px;
    align-items: stretch;
  }

  /* 좌측 라벨 컬럼 */
  .tm-labels {
    display: flex;
    flex-direction: column;
    gap: 4px;
  }
  .tm-label-spacer { height: 26px; flex-shrink: 0; }
  .tm-label-cell {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 7px;
    text-align: center;
    line-height: 1.4;
  }
  .tm-label-cell .lc-title {
    font-size: 10px;
    font-weight: 700;
    color: #64748b;
    letter-spacing: .4px;
  }
  .tm-label-cell .lc-unit {
    font-size: 11px;
    font-weight: 500;
    color: #94a3b8;
  }

  /* 개별 항목 카드 */
  .tm-item {
    display: flex;
    flex-direction: column;
    gap: 4px;
    border-radius: 10px;
    padding: 5px 4px 5px;
    border: 1px solid;
  }
  .tm-item.tm-green {
    background: linear-gradient(160deg, #f0fdf4 0%, #f7fef9 100%);
    border-color: #bbf7d0;
    box-shadow: 0 1px 4px rgba(16,185,129,.08);
  }
  .tm-item.tm-blue {
    background: linear-gradient(160deg, #eff6ff 0%, #f5f9ff 100%);
    border-color: #bfdbfe;
    box-shadow: 0 1px 4px rgba(59,130,246,.08);
  }

  /* 항목 이름 헤더 */
  .tm-item-name {
    height: 26px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 5px;
    font-size: 10px;
    font-weight: 700;
    letter-spacing: .2px;
    white-space: nowrap;
  }
  .tm-green .tm-item-name { background: #dcfce7; color: #15803d; }
  .tm-blue  .tm-item-name { background: #dbeafe; color: #1d4ed8; }

  /* 값 셀 */
  .tm-cell {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 34px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: .2px;
    border: 1px solid;
    font-variant-numeric: tabular-nums;
  }
  /* 현재온도 */
  .tm-green .tm-cur { background: #fff;     color: #059669; border-color: #a7f3d0; }
  .tm-blue  .tm-cur { background: #fff;     color: #2563eb; border-color: #93c5fd; }
  /* 설정온도 */
  .tm-green .tm-set { background: #f0fdf4;  color: #16a34a; border-color: #bbf7d0; }
  .tm-blue  .tm-set { background: #eff6ff;  color: #3b82f6; border-color: #bfdbfe; }

  /* 통신 상태 패널 (fixed, tm-panel 바로 위) */
  .cs-panel {
    position: fixed;
    left: 0; right: 0;
    z-index: 999;
    background: rgba(248,250,252,0.97);
    border-top: 1px solid #e2e8f0;
    border-bottom: 1px solid #e2e8f0;
    padding: 5px 14px;
    display: flex;
    align-items: center;
    gap: 10px;
    box-shadow: 0 -1px 6px rgba(0,0,0,0.05);
    backdrop-filter: blur(4px);
    font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
  }
  .cs-title {
    font-size: 10px; font-weight: 700; color: #64748b;
    letter-spacing: .6px; white-space: nowrap;
    padding: 3px 8px;
    background: #fff; border: 1px solid #e2e8f0; border-radius: 5px;
  }
  .cs-items { display: flex; gap: 6px; }
  .cs-item {
    display: flex; align-items: center; gap: 5px;
    padding: 3px 10px 3px 8px; border-radius: 5px;
    font-size: 11px; font-weight: 700; letter-spacing: .3px;
  }
  .cs-item::before {
    content: ''; width: 8px; height: 8px;
    border-radius: 50%; flex-shrink: 0;
  }
  .cs-ok {
    background: linear-gradient(160deg, #f0fdf4, #dcfce7);
    color: #15803d; border: 1px solid #86efac;
  }
  @keyframes csPulse {
    0%, 100% { box-shadow: 0 0 3px #22c55e; }
    50%       { box-shadow: 0 0 8px #22c55e; }
  }
  .cs-ok::before {
    background: #22c55e;
    animation: csPulse 2s ease-in-out infinite;
  }
  </style>

  <div class="tm-panel">
    <div class="tm-grid">

      <!-- 좌측 라벨 -->
      <div class="tm-labels">
        <div class="tm-label-spacer"></div>
        <div class="tm-label-cell">
          <span class="lc-title">현재온도</span>
          <span class="lc-unit">℃</span>
        </div>
        <div class="tm-label-cell">
          <span class="lc-title">설정온도</span>
          <span class="lc-unit">℃</span>
        </div>
      </div>

      <!-- BCF-11 그룹: 초록 -->
      <div class="tm-item tm-green">
        <div class="tm-item-name">1실11</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">2실11</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">냉각</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">1실CP</div>
        <div class="tm-cell tm-cur">0.000</div>
        <div class="tm-cell tm-set">0.000</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">2실CP</div>
        <div class="tm-cell tm-cur">0.000</div>
        <div class="tm-cell tm-set">0.000</div>
      </div>

      <!-- BCF-8 그룹: 파랑 -->
      <div class="tm-item tm-blue">
        <div class="tm-item-name">침탄8</div>
        <div class="tm-cell tm-cur bcf8_s_40046">DT</div>
        <div class="tm-cell tm-set bcf8_s_40069">DT</div>
      </div>
      <div class="tm-item tm-blue">
        <div class="tm-item-name">유조8</div>
        <div class="tm-cell tm-cur bcf8_s_40047">DT</div>
        <div class="tm-cell tm-set bcf8_s_40070">DT</div>
      </div>
      <div class="tm-item tm-blue">
        <div class="tm-item-name">CP8</div>
        <div class="tm-cell tm-cur bcf8_s_40052">0.000</div>
        <div class="tm-cell tm-set bcf8_s_40071">0.000</div>
      </div>

      <!-- BCF-9 그룹: 초록 -->
      <div class="tm-item tm-green">
        <div class="tm-item-name">침탄9</div>
        <div class="tm-cell tm-cur bcf9_s_40046">DT</div>
        <div class="tm-cell tm-set bcf9_s_40069">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">유조9</div>
        <div class="tm-cell tm-cur bcf9_s_40047">DT</div>
        <div class="tm-cell tm-set bcf9_s_40070">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">CP9</div>
        <div class="tm-cell tm-cur bcf9_s_40052">0.000</div>
        <div class="tm-cell tm-set bcf9_s_40071">0.000</div>
      </div>

      <!-- BCF-7 그룹: 파랑 -->
      <div class="tm-item tm-blue">
        <div class="tm-item-name">침탄7</div>
        <div class="tm-cell tm-cur bcf7_s_40046">DT</div>
        <div class="tm-cell tm-set bcf7_s_40069">DT</div>
      </div>
      <div class="tm-item tm-blue">
        <div class="tm-item-name">유조7</div>
        <div class="tm-cell tm-cur bcf7_s_40047">DT</div>
        <div class="tm-cell tm-set bcf7_s_40070">DT</div>
      </div>
      <div class="tm-item tm-blue">
        <div class="tm-item-name">CP7</div>
        <div class="tm-cell tm-cur bcf7_s_40052">0.000</div>
        <div class="tm-cell tm-set bcf7_s_40071">0.000</div>
      </div>

      <!-- BCF-6 그룹: 초록 -->
      <div class="tm-item tm-green">
        <div class="tm-item-name">예열6</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">가열6</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">1침탄</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">2침탄6</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">강온6</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">유조</div>
        <div class="tm-cell tm-cur">DT</div>
        <div class="tm-cell tm-set">DT</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">가열CP</div>
        <div class="tm-cell tm-cur">0.000</div>
        <div class="tm-cell tm-set">0.000</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">침탄CP</div>
        <div class="tm-cell tm-cur">0.000</div>
        <div class="tm-cell tm-set">0.000</div>
      </div>
      <div class="tm-item tm-green">
        <div class="tm-item-name">강온CP</div>
        <div class="tm-cell tm-cur">0.000</div>
        <div class="tm-cell tm-set">0.000</div>
      </div>

    </div><!-- /tm-grid -->
  </div><!-- /tm-panel -->

  <!-- 통신 상태 패널 (tm-panel 바로 위, 표시용) -->
  <div class="cs-panel" id="cs-panel">
    <span class="cs-title">통신 상태</span>
    <div class="cs-items">
      <div class="cs-item cs-ok">NO.11</div>
      <div class="cs-item cs-ok">NO.8</div>
      <div class="cs-item cs-ok">NO.9</div>
      <div class="cs-item cs-ok">NO.7</div>
      <div class="cs-item cs-ok">NO.6</div>
    </div>
  </div>

<script>
(function () {
  'use strict';
  const ctx = '<%= ctx %>';

  /* ── 1. DOM 수집 ── */
  const wordElMap = {};
  const bitElMap  = {};

  document.querySelectorAll('[class]').forEach(function (el) {
    el.className.split(/\s+/).forEach(function (cls) {
      if (/^bcf\d+_s_/.test(cls)) {
        if (!wordElMap[cls]) wordElMap[cls] = [];
        wordElMap[cls].push(el);
      } else if (/^bcf\d+_\d+$/.test(cls)) {
        if (!bitElMap[cls]) bitElMap[cls] = [];
        bitElMap[cls].push(el);
      }
    });
  });

  const allTags = Object.keys(wordElMap).concat(Object.keys(bitElMap));
  const penEls = Array.prototype.slice.call(document.querySelectorAll('img[class*="-pen-"]'));

  penEls.forEach(function(el) { el.classList.add('pen-rotating'); });

  function isPenElement(el) {
    return /\b\S*-pen-\S*\b/.test(el.className || '');
  }
  function bitTagsOf(el) {
    return (el.className || '').split(/\s+/).filter(function(cls) {
      return /^bcf\d+_\d+$/.test(cls);
    });
  }

  const modeLblEls = document.querySelectorAll('[data-mode-tag]');
  modeLblEls.forEach(function(el) {
    var tag = el.getAttribute('data-mode-tag');
    if (allTags.indexOf(tag) < 0) allTags.push(tag);
  });

  /* ── 2. 데이터 반영 ── */
  var CP_TAG = /_(40052|40071|D1081|D1087)$/;

  function applyData(data) {
    Object.keys(wordElMap).forEach(function (tag) {
      if (data[tag] == null) return;
      var raw = Number(data[tag]);
      var text;
      if (isNaN(raw)) {
        text = data[tag];
      } else if (CP_TAG.test(tag)) {
        text = (raw * 0.001).toFixed(3);
      } else {
        text = raw.toFixed(0);
      }
      wordElMap[tag].forEach(function (el) { el.textContent = text; });
    });

    Object.keys(bitElMap).forEach(function (tag) {
      if (data[tag] == null) return;
      var show = (data[tag] === 1 || data[tag] === true);
      bitElMap[tag].forEach(function (el) {
        if (isPenElement(el)) return;
        el.style.visibility = show ? 'visible' : 'hidden';
      });
    });

    penEls.forEach(function(el) {
      var tags = bitTagsOf(el);
      var known = tags.filter(function(tag) { return data[tag] != null; });
      var rotate = known.length === 0 || known.some(function(tag) {
        return data[tag] === 1 || data[tag] === true;
      });
      el.classList.toggle('pen-rotating', rotate);
      el.classList.toggle('pen-stopped', !rotate);
      el.style.visibility = 'visible';
    });

    modeLblEls.forEach(function(el) {
      var tag = el.getAttribute('data-mode-tag');
      if (data[tag] == null) return;
      var isAuto = (data[tag] === 1 || data[tag] === true);
      el.textContent       = isAuto ? '자동운전' : '수동운전';
      el.style.background  = isAuto ? 'linear-gradient(160deg,#f0fdf4,#bbf7d0)' : 'linear-gradient(160deg,#fff7ed,#fed7aa)';
      el.style.color       = isAuto ? '#166534' : '#9a3412';
      el.style.borderColor = isAuto ? '#86efac' : '#fdba74';
    });
  }

  /* ══════════════════════════════════════════════════════════
     BCF11·BCF6 비바인딩 온도/CP 셀 수집
     (bcf_s_ 클래스가 없어 wordElMap에 포함되지 않는 셀)
  ══════════════════════════════════════════════════════════ */
  /* .tm-item 순서: BCF11(0-4) BCF8(5-7) BCF9(8-10) BCF7(11-13) BCF6(14-22) */
  var ITEM_PHASE = [
    0,     0,     0,     0,     0,      /* BCF11 */
    8000,  8000,  8000,              /* BCF8  (bound, unbound cells 없음) */
    16000, 16000, 16000,             /* BCF9  (bound) */
    24000, 24000, 24000,             /* BCF7  (bound) */
    32000, 32000, 32000, 32000, 32000, 32000, 32000, 32000, 32000  /* BCF6 */
  ];

  var unboundCells = [];
  document.querySelectorAll('.tm-item').forEach(function(item, idx) {
    var phase  = ITEM_PHASE[idx] !== undefined ? ITEM_PHASE[idx] : 0;
    var nameEl = item.querySelector('.tm-item-name');
    var name   = nameEl ? nameEl.textContent.trim() : '';
    var isCp   = /CP/i.test(name);

    item.querySelectorAll('.tm-cell').forEach(function(cell) {
      var bound = cell.className.split(/\s+/).some(function(cls) {
        return /^bcf\d+_s_/.test(cls);
      });
      if (!bound) {
        unboundCells.push({ el: cell, isCp: isCp, phase: phase });
      }
    });
  });

  /* ══════════════════════════════════════════════════════════
     데모 모드 – PLC 통신 주석 처리, 더미 데이터로 시각 동작
  ══════════════════════════════════════════════════════════ */
  /* ── 태그별 독립 랜덤 워크: 각 셀이 ~2초마다 제각각 변경 ── */
  var STEP_MS = 2000;
  var demoState = {};

  Object.keys(wordElMap).forEach(function(tag) {
    var isCp = CP_TAG.test(tag);
    demoState[tag] = {
      val:  isCp ? (0.1 + Math.random() * 0.8) : (600 + Math.random() * 600),
      next: Date.now() + Math.random() * STEP_MS
    };
  });

  /* BCF11·BCF6 비바인딩 셀 상태 초기화 */
  unboundCells.forEach(function(item) {
    item.val  = item.isCp ? (0.1 + Math.random() * 0.8) : (600 + Math.random() * 600);
    item.next = Date.now() + Math.random() * STEP_MS;
  });

  function stepVal(tag, now) {
    var s    = demoState[tag];
    var isCp = CP_TAG.test(tag);
    var step, min, max;
    if (isCp) { step = (Math.random() - 0.5) * 0.1;  min = 0.1;  max = 0.9; }
    else       { step = (Math.random() - 0.5) * 60;   min = 600;  max = 1200; }
    s.val  = Math.min(max, Math.max(min, s.val + step));
    s.next = now + STEP_MS * (0.9 + Math.random() * 0.2);
  }

  function demoTick() {
    var now  = Date.now();
    var data = {};

    Object.keys(wordElMap).forEach(function(tag) {
      if (now >= demoState[tag].next) stepVal(tag, now);
      var s    = demoState[tag];
      data[tag] = CP_TAG.test(tag) ? Math.round(s.val * 1000) : Math.round(s.val);
    });

    Object.keys(bitElMap).forEach(function(tag) { data[tag] = 1; });
    modeLblEls.forEach(function(el) { data[el.getAttribute('data-mode-tag')] = 1; });

    applyData(data);

    /* BCF11·BCF6 비바인딩 셀 직접 업데이트 */
    unboundCells.forEach(function(item) {
      if (now >= item.next) {
        var step, min, max;
        if (item.isCp) { step = (Math.random() - 0.5) * 0.1;  min = 0.1;  max = 0.9; }
        else            { step = (Math.random() - 0.5) * 60;   min = 600;  max = 1200; }
        item.val  = Math.min(max, Math.max(min, item.val + step));
        item.next = now + STEP_MS * (0.9 + Math.random() * 0.2);
      }
      item.el.textContent = item.isCp ? item.val.toFixed(3) : Math.round(item.val);
    });
  }

  /* ── PLC 통신 코드 (주석 처리) ──────────────────────────────
  var POLL_INTERVAL = 6000;
  var FAIL_COOLDOWN = 12000;
  function scheduleNext(delay) { setTimeout(fetchData, delay); }
  function fetchData() {
    fetch(ctx + '/monitor/main-data', {
      method:  'POST',
      headers: { 'Content-Type': 'application/json' },
      body:    JSON.stringify(allTags)
    })
    .then(function (r) { return r.ok ? r.json() : Promise.reject(r.status); })
    .then(function (data) { applyData(data); scheduleNext(POLL_INTERVAL); })
    .catch(function (err) {
      console.warn('[monitor2] PLC fetch 실패:', err);
      scheduleNext(FAIL_COOLDOWN);
    });
  }
  fetchData();
  ──────────────────────────────────────────────────────────── */

  demoTick();
  setInterval(demoTick, 100);

  /* 통신 상태 패널 위치: tm-panel 바로 위 */
  function positionCsPanel() {
    var tmPanel = document.querySelector('.tm-panel');
    var csPanel = document.getElementById('cs-panel');
    if (tmPanel && csPanel) {
      csPanel.style.bottom = tmPanel.offsetHeight + 'px';
    }
  }
  positionCsPanel();
  window.addEventListener('resize', positionCsPanel);
})();
</script>
</body>
</html>
