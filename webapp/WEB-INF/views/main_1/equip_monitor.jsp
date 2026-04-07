<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common_style.jsp" %>
<style>
.equip-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
}
.equip-card {
  background: var(--white); border: 1px solid var(--border);
  border-radius: 12px; padding: 18px 20px;
  box-shadow: var(--shadow); transition: all .18s;
  position: relative; overflow: hidden;
}
.equip-card:hover { box-shadow: var(--shadow-md); transform: translateY(-2px); }
.equip-card::before {
  content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px;
  border-radius: 12px 12px 0 0;
}
.equip-card.status-ok::before    { background: var(--green); }
.equip-card.status-warn::before  { background: var(--orange); }
.equip-card.status-alarm::before { background: var(--red); }
.equip-card.status-off::before   { background: var(--light); }

.eq-header { display:flex; align-items:flex-start; justify-content:space-between; margin-bottom:14px; }
.eq-name { font-size:15px; font-weight:700; color:var(--text); }
.eq-id   { font-size:11px; color:var(--light); margin-top:2px; font-family:monospace; }

.eq-metrics { display:grid; grid-template-columns:repeat(4,1fr); gap:5px; margin-bottom:10px; }
.eq-metric { background:var(--bg); border-radius:7px; padding:5px 6px; text-align:center; }
.eq-metric-label { font-size:9px; color:var(--light); margin-bottom:2px; white-space:nowrap; }
.eq-metric-value { font-size:13px; font-weight:700; color:var(--text); font-family:monospace; }

.eq-footer { display:flex; align-items:center; justify-content:space-between;
  padding-top:10px; border-top:1px solid var(--border); font-size:11px; color:var(--muted); }

.summary-bar { display:flex; gap:12px; margin-bottom:20px; flex-wrap:wrap; }
.summary-chip {
  display:flex; align-items:center; gap:7px; padding:7px 16px;
  border-radius:8px; border:1px solid var(--border); background:var(--white);
  font-size:12px; font-weight:600; box-shadow:var(--shadow);
}
.dot { width:8px; height:8px; border-radius:50%; flex-shrink:0; }
.dot-ok    { background: var(--green); }
.dot-warn  { background: var(--orange); }
.dot-alarm { background: var(--red); }
.dot-off   { background: var(--light); }

.pulse {
  display:inline-block; width:7px; height:7px; border-radius:50%;
  margin-right:4px; vertical-align:middle;
}
.pulse-ok    { background:var(--green);  animation:blink 1.4s infinite; }
.pulse-alarm { background:var(--red);    animation:blink 0.8s infinite; }
.pulse-warn  { background:var(--orange); animation:blink 1.2s infinite; }
.pulse-off   { background:var(--light); }
@keyframes blink { 0%,100%{opacity:1} 50%{opacity:.25} }

.sparkline-wrap { margin:8px 0 2px; height:36px; }

.err-card {
  grid-column: 1 / -1; text-align:center; padding:60px;
  color:var(--muted); font-size:13px;
}
</style>
<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">통신 모니터링</div>
      <div class="page-sub" id="subTitle">PLC 목록 로딩 중…</div>
    </div>
    <div style="display:flex;gap:8px;align-items:center">
      <span style="font-size:11px;color:var(--muted)" id="lastUpdate"></span>
      <button class="btn-primary" onclick="refreshAll()">🔄 새로고침</button>
    </div>
  </div>

  <div class="summary-bar">
    <div class="summary-chip"><div class="dot dot-ok"></div>정상 <strong id="cntOk">0</strong>대</div>
    <div class="summary-chip"><div class="dot dot-warn"></div>경고 <strong id="cntWarn">0</strong>대</div>
    <div class="summary-chip"><div class="dot dot-alarm"></div>오류 <strong id="cntAlarm">0</strong>대</div>
    <div class="summary-chip"><div class="dot dot-off"></div>오프라인 <strong id="cntOff">0</strong>대</div>
  </div>

  <div class="equip-grid" id="equipGrid">
    <div class="err-card">PLC 목록을 불러오는 중…</div>
  </div>
</div>

<script>
var base = '${pageContext.request.contextPath}';
var plcList  = [];
var plcState = {};   // { id: {status, values, lastOk, error} }
var sparkBuf = {};   // { id: [number, …] }  — 최대 40개 보관

var STATUS_LABEL = { ok:'정상', warn:'경고', alarm:'오류', off:'오프라인' };
var TYPE_ICON    = { LS:'🔵', MITSUBISHI:'🔴', MODBUS_TCP:'🟠' };
var DOT_COLOR    = { ok:'#38A169', warn:'#DD6B20', alarm:'#E53E3E', off:'#A0AEC0' };

/* ── PLC 목록 ── */
function fetchList(){
  return fetch(base + '/plc/dblist')
    .then(function(r){ return r.json(); })
    .then(function(d){ if(d && d.data) plcList = d.data; })
    .catch(function(){ plcList = []; });
}

/* ── 단일 PLC 폴링 ── */
function pollOne(plc){
  var id = plc.plcId || plc.plc_id || plc.id;
  return fetch(base + '/plc/read/' + encodeURIComponent(id) + '?start=10000&count=4')
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d && d.success && d.values){
        var v0 = d.values[0] != null ? Number(d.values[0]) : 0;
        if(!sparkBuf[id]) sparkBuf[id] = [];
        sparkBuf[id].push(v0);
        if(sparkBuf[id].length > 40) sparkBuf[id].shift();
        plcState[id] = { status:'ok', values:d.values, lastOk:new Date(), error:'' };
      } else {
        plcState[id] = plcState[id] || {};
        plcState[id].status = 'alarm';
        plcState[id].values = [];
        plcState[id].error  = (d && d.error) ? d.error : '응답 오류';
      }
    })
    .catch(function(e){
      plcState[id] = plcState[id] || {};
      plcState[id].status = 'off';
      plcState[id].values = [];
      plcState[id].error  = e.message || '연결 실패';
    });
}

function pollAll(){
  if(!plcList.length) return Promise.resolve();
  return plcList.reduce(function(chain, plc){
    return chain.then(function(){
      return pollOne(plc).then(renderGrid);
    });
  }, Promise.resolve());
}

/* ── 스파크라인 SVG ── */
function sparkSvg(buf, color){
  if(!buf || buf.length < 2) return '';
  var W=130, H=34;
  var mn = Math.min.apply(null, buf), mx = Math.max.apply(null, buf);
  var rng = mx - mn || 1;
  function px(i){ return Math.round(i/(buf.length-1)*(W-2)+1); }
  function py(v){ return Math.round((H-4) - (v-mn)/rng*(H-8) + 2); }
  var d = buf.map(function(v,i){ return (i===0?'M':'L')+px(i)+','+py(v); }).join(' ');
  var lx = px(buf.length-1), ly = py(buf[buf.length-1]);
  return '<svg width="'+W+'" height="'+H+'" viewBox="0 0 '+W+' '+H+'">'
       + '<path d="'+d+'" fill="none" stroke="'+color+'" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" opacity=".85"/>'
       + '<circle cx="'+lx+'" cy="'+ly+'" r="3" fill="'+color+'"/>'
       + '</svg>';
}

/* ── 렌더링 ── */
function renderGrid(){
  if(!plcList.length){
    document.getElementById('equipGrid').innerHTML =
      '<div class="err-card">등록된 PLC가 없습니다. (tb_plc 테이블 확인)</div>';
    updateSummary({ok:0,warn:0,alarm:0,off:0});
    document.getElementById('subTitle').textContent = 'PLC 0대 등록됨';
    return;
  }

  var cnt = {ok:0, warn:0, alarm:0, off:0};
  var html = '';

  plcList.forEach(function(plc){
    var id    = plc.plcId || plc.plc_id || plc.id;
    var label = plc.label || id;
    var ip    = (plc.ip || '?') + ':' + (plc.port || '?');
    var ptype = (plc.plcType || '').toUpperCase();
    var icon  = TYPE_ICON[ptype] || '⚙️';
    var st    = plcState[id] || {status:'off', values:[], error:'폴링 전'};
    var s     = st.status in cnt ? st.status : 'off';
    cnt[s]++;

    var badgeCls = s==='ok'?'badge-ok':s==='warn'?'badge-warn':s==='alarm'?'badge-alarm':'badge-off';
    var dotColor = DOT_COLOR[s];

    /* 값 메트릭 */
    var metricsHtml = '';
    var vals = st.values || [];
    if(s === 'ok' && vals.length > 0){
      var show = Math.min(vals.length, 4);
      for(var i=0;i<show;i++){
        metricsHtml += '<div class="eq-metric">'
          + '<div class="eq-metric-label">D'+(10000+i)+'</div>'
          + '<div class="eq-metric-value">'+(vals[i]!=null?vals[i]:'-')+'</div>'
          + '</div>';
      }
    } else {
      metricsHtml = '<div class="eq-metric" style="grid-column:1/-1;color:var(--muted);font-size:12px">'
        +(st.error||'데이터 없음')+'</div>';
    }

    /* 마지막 갱신 */
    var lastStr = st.lastOk ? fmtTime(st.lastOk) : '-';

    /* 스파크라인 */
    var spark = sparkSvg(sparkBuf[id], dotColor);

    html += '<div class="equip-card status-'+s+'">'
          + '<div class="eq-header">'
          + '  <div><div class="eq-name">'+icon+' '+esc(label)+'</div>'
          + '  <div class="eq-id">'+esc(id)+' · '+esc(ip)+' · '+ptype+'</div></div>'
          + '  <span class="badge '+badgeCls+'"><span class="pulse pulse-'+s+'"></span>'+STATUS_LABEL[s]+'</span>'
          + '</div>'
          + '<div class="eq-metrics">'+metricsHtml+'</div>';
    if(spark){
      html += '<div class="sparkline-wrap">'+spark+'</div>';
    }
    html += '<div class="eq-footer">'
          + '<span>⏱ 갱신: '+lastStr+'</span>'
          + '<span style="font-family:monospace;font-size:10px;color:var(--border-dark,#CBD5E0)">'+ptype+'</span>'
          + '</div>'
          + '</div>';
  });

  document.getElementById('equipGrid').innerHTML = html;
  updateSummary(cnt);
  document.getElementById('subTitle').textContent = '등록된 PLC ' + plcList.length + '대 실시간 현황';

  var now = new Date();
  document.getElementById('lastUpdate').textContent = '최종 갱신: ' + fmtTime(now);
}

function updateSummary(cnt){
  document.getElementById('cntOk').textContent    = cnt.ok;
  document.getElementById('cntWarn').textContent  = cnt.warn;
  document.getElementById('cntAlarm').textContent = cnt.alarm;
  document.getElementById('cntOff').textContent   = cnt.off;
}

/* ── 유틸 ── */
function fmtTime(d){
  return String(d.getHours()).padStart(2,'0') + ':'
       + String(d.getMinutes()).padStart(2,'0') + ':'
       + String(d.getSeconds()).padStart(2,'0');
}
function esc(s){ return String(s||'').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

/* ── 초기 실행 ── */
function refreshAll(){
  pollAll().then(function(){
    setTimeout(refreshAll, 60000);
  });
}

fetchList().then(function(){
  renderGrid();
  return pollAll();
}).then(function(){
  setTimeout(refreshAll, 60000);
});
</script>
</body>
</html>
