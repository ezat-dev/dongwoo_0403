<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common_style.jsp" %>
<style>
.detail-grid { display: grid; grid-template-columns: 320px 1fr; gap: 16px; margin-bottom: 16px; }
@media(max-width:900px){ .detail-grid { grid-template-columns: 1fr; } }

/* 설비 선택 패널 */
.equip-select-panel { display: flex; flex-direction: column; gap: 8px; }
.equip-select-item {
  display: flex; align-items: center; gap: 10px;
  padding: 10px 14px; border-radius: 9px; cursor: pointer;
  border: 1px solid var(--border); background: var(--white);
  transition: all .13s;
}
.equip-select-item:hover { border-color: var(--primary-m); background: var(--primary-l); }
.equip-select-item.active { border-color: var(--primary); background: var(--primary-l); box-shadow: 0 0 0 2px var(--primary-m); }
.eq-sel-dot { width: 9px; height: 9px; border-radius: 50%; flex-shrink: 0; }
.eq-sel-name { font-size: 13px; font-weight: 600; flex: 1; }
.eq-sel-id   { font-size: 10px; color: var(--light); }

/* 상세 정보 */
.detail-main { display: flex; flex-direction: column; gap: 14px; }
.metrics-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); gap: 10px; }
.metric-card {
  background: var(--bg); border-radius: 10px; padding: 14px 16px;
  border: 1px solid var(--border);
}
.metric-label { font-size: 10px; color: var(--muted); margin-bottom: 6px; text-transform: uppercase; letter-spacing: .5px; }
.metric-value { font-size: 26px; font-weight: 700; color: var(--text); }
.metric-unit  { font-size: 12px; color: var(--muted); margin-left: 3px; }
.metric-card.hl-ok     { border-left: 3px solid var(--green);  }
.metric-card.hl-warn   { border-left: 3px solid var(--orange); }
.metric-card.hl-alarm  { border-left: 3px solid var(--red);    }

/* 미니 차트 (CSS 바 */
.bar-chart { display: flex; flex-direction: column; gap: 6px; }
.bar-row { display: flex; align-items: center; gap: 8px; }
.bar-label { font-size: 11px; color: var(--muted); width: 60px; flex-shrink: 0; text-align: right; }
.bar-bg { flex: 1; height: 10px; background: var(--bg); border-radius: 5px; overflow: hidden; }
.bar-fill { height: 100%; border-radius: 5px; background: var(--primary); transition: width .4s; }
.bar-fill.ok    { background: var(--green); }
.bar-fill.warn  { background: var(--orange); }
.bar-fill.alarm { background: var(--red); }
.bar-val { font-size: 11px; color: var(--text); font-weight: 600; width: 50px; flex-shrink: 0; }
</style>
<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title" id="detailTitle">설비 상세</div>
      <div class="page-sub">설비를 선택하면 상세 정보를 확인할 수 있습니다</div>
    </div>
    <div style="display:flex;gap:8px">
      <span class="badge" id="statusBadge" style="font-size:13px;padding:5px 14px">—</span>
    </div>
  </div>

  <div class="detail-grid">
    <!-- 좌측: 설비 목록 -->
    <div class="card">
      <div class="card-title">설비 선택 (12대)</div>
      <div class="equip-select-panel" id="equipList"></div>
    </div>

    <!-- 우측: 상세 정보 -->
    <div class="detail-main">
      <div class="card">
        <div class="card-title">실시간 계측값</div>
        <div class="metrics-grid" id="metricsGrid">
          <div style="color:var(--light);font-size:13px;grid-column:1/-1;padding:20px;text-align:center">
            좌측에서 설비를 선택하세요
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-title">온도 추이 (최근 1시간)</div>
        <div class="bar-chart" id="tempChart" style="padding:8px 0">
          <div style="color:var(--light);font-size:13px;text-align:center;padding:20px">설비 선택 후 표시됩니다</div>
        </div>
      </div>
      <div class="card">
        <div class="card-title">최근 알람 이력</div>
        <table class="data-table" id="alarmTable">
          <thead><tr><th>시각</th><th>항목</th><th>내용</th><th>상태</th></tr></thead>
          <tbody><tr><td colspan="4" style="text-align:center;color:var(--light)">설비 선택 후 표시됩니다</td></tr></tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script>
var equipList = [
  {id:'EQ-001',name:'열처리로 1호기',status:'ok',   temp:850,setTemp:860,o2:0.3,humidity:45,pressure:1.01,power:85},
  {id:'EQ-002',name:'열처리로 2호기',status:'ok',   temp:842,setTemp:850,o2:0.4,humidity:44,pressure:1.00,power:82},
  {id:'EQ-003',name:'열처리로 3호기',status:'warn', temp:895,setTemp:860,o2:0.8,humidity:50,pressure:1.02,power:95},
  {id:'EQ-004',name:'열처리로 4호기',status:'ok',   temp:855,setTemp:860,o2:0.3,humidity:43,pressure:1.01,power:84},
  {id:'EQ-005',name:'냉각장치 1호기',status:'ok',   temp:25, setTemp:25, o2:null,humidity:55,pressure:null,power:40},
  {id:'EQ-006',name:'냉각장치 2호기',status:'alarm',temp:38, setTemp:25, o2:null,humidity:60,pressure:null,power:72},
  {id:'EQ-007',name:'컨베이어 1호기',status:'ok',   temp:null,setTemp:null,o2:null,humidity:null,pressure:null,power:30},
  {id:'EQ-008',name:'컨베이어 2호기',status:'off',  temp:null,setTemp:null,o2:null,humidity:null,pressure:null,power:0},
  {id:'EQ-009',name:'세척기 1호기',  status:'ok',   temp:60, setTemp:60, o2:null,humidity:70,pressure:null,power:55},
  {id:'EQ-010',name:'세척기 2호기',  status:'warn', temp:70, setTemp:60, o2:null,humidity:75,pressure:null,power:68},
  {id:'EQ-011',name:'프레스 1호기',  status:'ok',   temp:null,setTemp:null,o2:null,humidity:null,pressure:null,power:90},
  {id:'EQ-012',name:'프레스 2호기',  status:'off',  temp:null,setTemp:null,o2:null,humidity:null,pressure:null,power:0}
];

var dotColor = {ok:'var(--green)',warn:'var(--orange)',alarm:'var(--red)',off:'var(--light)'};
var badgeClass = {ok:'badge-ok',warn:'badge-warn',alarm:'badge-alarm',off:'badge-off'};
var statusLabel = {ok:'정상',warn:'주의',alarm:'알람',off:'정지'};

// 목록 렌더
var listHtml = '';
equipList.forEach(function(e){
  listHtml += '<div class="equip-select-item" id="sel_'+e.id+'" onclick="selectEquip(\''+e.id+'\')">'
            + '<div class="eq-sel-dot" style="background:'+dotColor[e.status]+'"></div>'
            + '<div style="flex:1"><div class="eq-sel-name">'+e.name+'</div><div class="eq-sel-id">'+e.id+'</div></div>'
            + '<span class="badge '+badgeClass[e.status]+'">'+statusLabel[e.status]+'</span>'
            + '</div>';
});
document.getElementById('equipList').innerHTML = listHtml;

// URL 파라미터로 자동 선택
var params = new URLSearchParams(location.search);
var initId = params.get('id');
if(initId) selectEquip(initId);

function selectEquip(id){
  document.querySelectorAll('.equip-select-item').forEach(function(i){ i.classList.remove('active'); });
  var el = document.getElementById('sel_'+id);
  if(el) el.classList.add('active');

  var e = equipList.find(function(x){ return x.id === id; });
  if(!e) return;

  document.getElementById('detailTitle').textContent = '설비 상세 — '+e.name;
  var badge = document.getElementById('statusBadge');
  badge.className = 'badge '+badgeClass[e.status];
  badge.style = 'font-size:13px;padding:5px 14px';
  badge.textContent = statusLabel[e.status];

  // 계측값
  var m = '';
  if(e.temp != null){
    var tCls = e.temp > e.setTemp*1.03 ? 'hl-alarm' : e.temp > e.setTemp*1.01 ? 'hl-warn' : 'hl-ok';
    m += metric('현재 온도', e.temp, '°C', tCls);
    m += metric('설정 온도', e.setTemp, '°C', '');
  }
  if(e.o2 != null) m += metric('O₂ 농도', e.o2, '%', e.o2>0.5?'hl-warn':'hl-ok');
  if(e.humidity != null) m += metric('습도', e.humidity, '%', '');
  if(e.pressure != null) m += metric('압력', e.pressure, 'bar', '');
  m += metric('전력', e.power, '%', e.power>90?'hl-warn':'');
  document.getElementById('metricsGrid').innerHTML = m;

  // 온도 추이 (샘플)
  var times = ['60분전','50분','40분','30분','20분','10분','현재'];
  var base = e.temp || 50;
  var chartHtml = '';
  times.forEach(function(t, i){
    var v = base + Math.round((Math.random()-0.5)*10) - (times.length-1-i)*2;
    var pct = Math.min(100, Math.round(v / 1000 * 100));
    var cls = v > (e.setTemp||base)*1.03 ? 'alarm' : v > (e.setTemp||base)*1.01 ? 'warn' : 'ok';
    chartHtml += '<div class="bar-row">'
               + '<div class="bar-label">'+t+'</div>'
               + '<div class="bar-bg"><div class="bar-fill '+cls+'" style="width:'+pct+'%"></div></div>'
               + '<div class="bar-val">'+v+(e.temp!=null?'°C':'%')+'</div>'
               + '</div>';
  });
  document.getElementById('tempChart').innerHTML = chartHtml;

  // 알람 이력
  var alarms = e.status==='ok'
    ? '<tr><td colspan="4" style="text-align:center;color:var(--light)">최근 알람 없음</td></tr>'
    : '<tr><td>09:12:34</td><td>온도 이상</td><td>설정값 초과 (+'+Math.abs(e.temp-(e.setTemp||50))+'°C)</td><td><span class="badge badge-alarm">미처리</span></td></tr>'
    + '<tr><td>08:45:10</td><td>온도 이상</td><td>설정값 초과</td><td><span class="badge badge-ok">처리완료</span></td></tr>';
  document.getElementById('alarmTable').querySelector('tbody').innerHTML = alarms;
}

function metric(label, val, unit, cls){
  return '<div class="metric-card '+cls+'"><div class="metric-label">'+label+'</div>'
       + '<div class="metric-value">'+val+'<span class="metric-unit">'+unit+'</span></div></div>';
}
</script>
</body></html>
