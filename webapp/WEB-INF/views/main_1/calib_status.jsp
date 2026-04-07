<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common_style.jsp" %>
<style>
.calib-tabs { display:flex; gap:6px; margin-bottom:16px; }
.calib-tab {
  padding:7px 20px; border-radius:8px; border:1px solid var(--border);
  background:var(--white); font-size:13px; font-weight:600;
  cursor:pointer; transition:all .13s; color:var(--muted);
}
.calib-tab.active { background:var(--primary); color:#fff; border-color:var(--primary); }
.dday { font-weight:700; }
.dday.over   { color:var(--red); }
.dday.near   { color:var(--orange); }
.dday.ok     { color:var(--green); }
</style>
<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">보정현황</div>
      <div class="page-sub">열전대 · O₂센서 · 온도조절계 교정/보정 현황</div>
    </div>
    <button class="btn-primary">📥 엑셀 다운로드</button>
  </div>

  <div class="calib-tabs">
    <button class="calib-tab active" onclick="showTab('thermocouple',this)">열전대</button>
    <button class="calib-tab" onclick="showTab('o2sensor',this)">O₂ 센서</button>
    <button class="calib-tab" onclick="showTab('controller',this)">온도조절계</button>
  </div>

  <div id="tab-thermocouple">
    <div class="card">
      <div class="card-title">열전대 보정현황</div>
      <table class="data-table">
        <thead><tr><th>No</th><th>설비명</th><th>채널</th><th>TAG</th><th>최근 보정일</th><th>다음 보정 예정일</th><th>D-Day</th><th>보정값 (°C)</th><th>상태</th><th>담당자</th></tr></thead>
        <tbody id="tbody-thermocouple"></tbody>
      </table>
    </div>
  </div>

  <div id="tab-o2sensor" style="display:none">
    <div class="card">
      <div class="card-title">O₂ 센서 보정현황</div>
      <table class="data-table">
        <thead><tr><th>No</th><th>설비명</th><th>TAG</th><th>최근 보정일</th><th>다음 보정 예정일</th><th>D-Day</th><th>보정값 (%)</th><th>상태</th><th>담당자</th></tr></thead>
        <tbody id="tbody-o2sensor"></tbody>
      </table>
    </div>
  </div>

  <div id="tab-controller" style="display:none">
    <div class="card">
      <div class="card-title">온도조절계 보정현황</div>
      <table class="data-table">
        <thead><tr><th>No</th><th>설비명</th><th>모델</th><th>최근 교정일</th><th>다음 교정 예정일</th><th>D-Day</th><th>편차</th><th>상태</th><th>담당자</th></tr></thead>
        <tbody id="tbody-controller"></tbody>
      </table>
    </div>
  </div>
</div>

<script>
function dDayHtml(nextDate){
  var today = new Date(); today.setHours(0,0,0,0);
  var nd = new Date(nextDate);
  var diff = Math.round((nd-today)/(1000*60*60*24));
  var cls = diff < 0 ? 'over' : diff <= 14 ? 'near' : 'ok';
  var label = diff < 0 ? 'D+'+Math.abs(diff)+' 초과' : diff === 0 ? 'D-Day' : 'D-'+diff;
  return '<span class="dday '+cls+'">'+label+'</span>';
}

var tcData = [
  {equip:'열처리로 1호기',ch:'CH1',tag:'TT-101',last:'2026-01-10',next:'2026-07-10',val:'+0.5',ok:true,handler:'김계측'},
  {equip:'열처리로 1호기',ch:'CH2',tag:'TT-102',last:'2026-01-10',next:'2026-07-10',val:'+0.3',ok:true,handler:'김계측'},
  {equip:'열처리로 2호기',ch:'CH1',tag:'TT-201',last:'2026-02-15',next:'2026-04-15',val:'+1.2',ok:false,handler:'이계측'},
  {equip:'열처리로 3호기',ch:'CH1',tag:'TT-301',last:'2025-10-01',next:'2026-04-01',val:'+2.1',ok:false,handler:'박계측'},
  {equip:'열처리로 4호기',ch:'CH1',tag:'TT-401',last:'2026-03-01',next:'2026-09-01',val:'+0.8',ok:true,handler:'최계측'},
  {equip:'세척기 1호기',  ch:'CH1',tag:'TT-901',last:'2026-02-20',next:'2026-08-20',val:'-0.2',ok:true,handler:'정계측'},
];
var html=''; tcData.forEach(function(r,i){
  html+='<tr><td>'+(i+1)+'</td><td>'+r.equip+'</td><td>'+r.ch+'</td><td>'+r.tag+'</td>'
      +'<td>'+r.last+'</td><td>'+r.next+'</td><td>'+dDayHtml(r.next)+'</td><td>'+r.val+'</td>'
      +'<td><span class="badge '+(r.ok?'badge-ok':'badge-alarm')+'">'+(r.ok?'정상':'만료임박')+'</span></td>'
      +'<td>'+r.handler+'</td></tr>';
}); document.getElementById('tbody-thermocouple').innerHTML=html;

var o2Data = [
  {equip:'열처리로 1호기',tag:'AT-101',last:'2026-03-01',next:'2026-06-01',val:'+0.01',ok:true,handler:'김계측'},
  {equip:'열처리로 2호기',tag:'AT-201',last:'2026-01-15',next:'2026-04-15',val:'+0.05',ok:false,handler:'이계측'},
  {equip:'열처리로 3호기',tag:'AT-301',last:'2026-03-20',next:'2026-06-20',val:'+0.02',ok:true,handler:'박계측'},
  {equip:'열처리로 4호기',tag:'AT-401',last:'2026-02-10',next:'2026-05-10',val:'+0.03',ok:true,handler:'최계측'},
];
html=''; o2Data.forEach(function(r,i){
  html+='<tr><td>'+(i+1)+'</td><td>'+r.equip+'</td><td>'+r.tag+'</td>'
      +'<td>'+r.last+'</td><td>'+r.next+'</td><td>'+dDayHtml(r.next)+'</td><td>'+r.val+'%</td>'
      +'<td><span class="badge '+(r.ok?'badge-ok':'badge-alarm')+'">'+(r.ok?'정상':'만료임박')+'</span></td>'
      +'<td>'+r.handler+'</td></tr>';
}); document.getElementById('tbody-o2sensor').innerHTML=html;

var ctData = [
  {equip:'열처리로 1호기',model:'PXR9',last:'2026-01-05',next:'2027-01-05',val:'±0.5°C',ok:true,handler:'김전기'},
  {equip:'열처리로 2호기',model:'PXR9',last:'2025-12-01',next:'2026-12-01',val:'±0.8°C',ok:true,handler:'이전기'},
  {equip:'열처리로 3호기',model:'E5CC', last:'2025-06-01',next:'2026-06-01',val:'±1.5°C',ok:true,handler:'박전기'},
  {equip:'세척기 1호기',  model:'E5EC', last:'2025-04-01',next:'2026-04-01',val:'±0.3°C',ok:false,handler:'최전기'},
];
html=''; ctData.forEach(function(r,i){
  html+='<tr><td>'+(i+1)+'</td><td>'+r.equip+'</td><td>'+r.model+'</td>'
      +'<td>'+r.last+'</td><td>'+r.next+'</td><td>'+dDayHtml(r.next)+'</td><td>'+r.val+'</td>'
      +'<td><span class="badge '+(r.ok?'badge-ok':'badge-alarm')+'">'+(r.ok?'정상','만료임박')+'</span></td>'
      +'<td>'+r.handler+'</td></tr>';
}); document.getElementById('tbody-controller').innerHTML=html;

function showTab(id, btn){
  ['thermocouple','o2sensor','controller'].forEach(function(t){
    document.getElementById('tab-'+t).style.display = t===id?'':'none';
  });
  document.querySelectorAll('.calib-tab').forEach(function(b){ b.classList.remove('active'); });
  btn.classList.add('active');
}
</script>
</body></html>
