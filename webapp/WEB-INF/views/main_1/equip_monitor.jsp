<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common_style.jsp" %>
<style>
.equip-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 16px;
}
.equip-card {
  background: var(--white); border: 1px solid var(--border);
  border-radius: 12px; padding: 18px 20px;
  box-shadow: var(--shadow); cursor: pointer;
  transition: all .18s; position: relative; overflow: hidden;
}
.equip-card:hover { box-shadow: var(--shadow-md); transform: translateY(-2px); border-color: var(--primary-m); }
.equip-card::before {
  content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px;
  border-radius: 12px 12px 0 0;
}
.equip-card.status-ok::before    { background: var(--green); }
.equip-card.status-warn::before  { background: var(--orange); }
.equip-card.status-alarm::before { background: var(--red); }
.equip-card.status-off::before   { background: var(--light); }

.eq-header { display: flex; align-items: flex-start; justify-content: space-between; margin-bottom: 14px; }
.eq-name { font-size: 15px; font-weight: 700; color: var(--text); }
.eq-id   { font-size: 11px; color: var(--light); margin-top: 2px; }
.eq-status-badge {
  font-size: 10px; font-weight: 700; padding: 3px 9px; border-radius: 20px;
  white-space: nowrap;
}
.badge-ok    { background: #F0FFF4; color: var(--green); border: 1px solid #9AE6B4; }
.badge-warn  { background: #FFFAF0; color: var(--orange); border: 1px solid #FBD38D; }
.badge-alarm { background: #FFF5F5; color: var(--red);    border: 1px solid #FEB2B2; }
.badge-off   { background: var(--bg); color: var(--light); border: 1px solid var(--border); }

.eq-metrics { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-bottom: 14px; }
.eq-metric { background: var(--bg); border-radius: 8px; padding: 8px 10px; }
.eq-metric-label { font-size: 10px; color: var(--light); margin-bottom: 3px; }
.eq-metric-value { font-size: 16px; font-weight: 700; color: var(--text); }
.eq-metric-unit  { font-size: 10px; color: var(--muted); margin-left: 2px; }

.eq-footer { display: flex; align-items: center; justify-content: space-between; padding-top: 10px; border-top: 1px solid var(--border); }
.eq-uptime { font-size: 11px; color: var(--muted); }
.btn-detail {
  font-size: 11px; padding: 4px 12px; border-radius: 6px;
  border: 1px solid var(--primary-m); background: var(--primary-l);
  color: var(--primary); font-weight: 600; cursor: pointer;
  transition: all .13s;
}
.btn-detail:hover { background: var(--primary); color: #fff; }

.summary-bar {
  display: flex; gap: 12px; margin-bottom: 20px; flex-wrap: wrap;
}
.summary-chip {
  display: flex; align-items: center; gap: 7px;
  padding: 7px 16px; border-radius: 8px;
  border: 1px solid var(--border); background: var(--white);
  font-size: 12px; font-weight: 600; box-shadow: var(--shadow);
}
.dot { width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0; }
.dot-ok    { background: var(--green); }
.dot-warn  { background: var(--orange); }
.dot-alarm { background: var(--red); }
.dot-off   { background: var(--light); }
</style>
<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">설비 모니터링</div>
      <div class="page-sub">전체 설비 12대 실시간 현황</div>
    </div>
    <div style="display:flex;gap:8px">
      <button class="btn-primary" onclick="location.reload()">🔄 새로고침</button>
    </div>
  </div>

  <div class="summary-bar">
    <div class="summary-chip"><div class="dot dot-ok"></div>정상 <strong id="cntOk">0</strong>대</div>
    <div class="summary-chip"><div class="dot dot-warn"></div>주의 <strong id="cntWarn">0</strong>대</div>
    <div class="summary-chip"><div class="dot dot-alarm"></div>알람 <strong id="cntAlarm">0</strong>대</div>
    <div class="summary-chip"><div class="dot dot-off"></div>정지 <strong id="cntOff">0</strong>대</div>
  </div>

  <div class="equip-grid" id="equipGrid"></div>
</div>

<script>
var equipList = [
  {id:'EQ-001', name:'열처리로 1호기', type:'열처리로',  status:'ok',    temp:850, setTemp:860, o2:0.3, runtime:'72h 14m'},
  {id:'EQ-002', name:'열처리로 2호기', type:'열처리로',  status:'ok',    temp:842, setTemp:850, o2:0.4, runtime:'48h 02m'},
  {id:'EQ-003', name:'열처리로 3호기', type:'열처리로',  status:'warn',  temp:895, setTemp:860, o2:0.8, runtime:'12h 30m'},
  {id:'EQ-004', name:'열처리로 4호기', type:'열처리로',  status:'ok',    temp:855, setTemp:860, o2:0.3, runtime:'96h 00m'},
  {id:'EQ-005', name:'냉각장치 1호기', type:'냉각장치',  status:'ok',    temp:25,  setTemp:25,  o2:null, runtime:'120h 10m'},
  {id:'EQ-006', name:'냉각장치 2호기', type:'냉각장치',  status:'alarm', temp:38,  setTemp:25,  o2:null, runtime:'3h 45m'},
  {id:'EQ-007', name:'컨베이어 1호기', type:'컨베이어',  status:'ok',    temp:null,setTemp:null,o2:null, runtime:'200h 00m'},
  {id:'EQ-008', name:'컨베이어 2호기', type:'컨베이어',  status:'off',   temp:null,setTemp:null,o2:null, runtime:'정지'},
  {id:'EQ-009', name:'세척기 1호기',   type:'세척기',    status:'ok',    temp:60,  setTemp:60,  o2:null, runtime:'55h 20m'},
  {id:'EQ-010', name:'세척기 2호기',   type:'세척기',    status:'warn',  temp:70,  setTemp:60,  o2:null, runtime:'8h 15m'},
  {id:'EQ-011', name:'프레스 1호기',   type:'프레스',    status:'ok',    temp:null,setTemp:null,o2:null, runtime:'180h 30m'},
  {id:'EQ-012', name:'프레스 2호기',   type:'프레스',    status:'off',   temp:null,setTemp:null,o2:null, runtime:'정지'}
];

var statusLabel = {ok:'정상', warn:'주의', alarm:'알람', off:'정지'};
var cnt = {ok:0, warn:0, alarm:0, off:0};

var html = '';
equipList.forEach(function(e){
  cnt[e.status]++;
  var tempHtml = e.temp != null
    ? '<div class="eq-metric"><div class="eq-metric-label">현재온도</div><div class="eq-metric-value">'+e.temp+'<span class="eq-metric-unit">°C</span></div></div>'
    + '<div class="eq-metric"><div class="eq-metric-label">설정온도</div><div class="eq-metric-value">'+e.setTemp+'<span class="eq-metric-unit">°C</span></div></div>'
    : '<div class="eq-metric" style="grid-column:1/-1"><div class="eq-metric-label">유형</div><div class="eq-metric-value" style="font-size:13px">'+e.type+'</div></div>';

  html += '<div class="equip-card status-'+e.status+'" onclick="goDetail(\''+e.id+'\',\''+e.name+'\')">'
        + '<div class="eq-header">'
        + '  <div><div class="eq-name">'+e.name+'</div><div class="eq-id">'+e.id+'</div></div>'
        + '  <span class="eq-status-badge badge-'+e.status+'">'+statusLabel[e.status]+'</span>'
        + '</div>'
        + '<div class="eq-metrics">'+tempHtml+'</div>'
        + '<div class="eq-footer">'
        + '  <span class="eq-uptime">⏱ '+e.runtime+'</span>'
        + '  <button class="btn-detail">상세보기 →</button>'
        + '</div>'
        + '</div>';
});

document.getElementById('equipGrid').innerHTML = html;
document.getElementById('cntOk').textContent    = cnt.ok;
document.getElementById('cntWarn').textContent  = cnt.warn;
document.getElementById('cntAlarm').textContent = cnt.alarm;
document.getElementById('cntOff').textContent   = cnt.off;

function goDetail(id, name){
  // iframe 부모로 메시지 전달
  try {
    parent.go(parent.document.getElementById('pageFrame').src.replace('monitor','detail')+'?id='+id, '설비 상세 — '+name, null);
    parent.document.getElementById('pageFrame').src = parent.document.getElementById('pageFrame').src.replace(/\/equip\/[^?]+/, '/equip/detail')+'?id='+id;
    parent.document.getElementById('pageTitle').textContent = '설비 상세 — '+name;
    parent.document.querySelectorAll('.sb-item').forEach(function(i){ i.classList.remove('active'); });
    var items = parent.document.querySelectorAll('.sb-item');
    items.forEach(function(i){ if(i.textContent.trim().indexOf('설비 상세') >= 0) i.classList.add('active'); });
  } catch(e) {}
  location.href = location.href.replace('monitor','detail')+'?id='+encodeURIComponent(id)+'&name='+encodeURIComponent(name);
}
</script>
</body>
</html>
