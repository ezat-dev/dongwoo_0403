<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common_style.jsp" %>
<style>
.inspect-header-row { display:flex; gap:12px; margin-bottom:16px; flex-wrap:wrap; align-items:center; }
.check-cell { text-align:center; font-size:18px; cursor:pointer; }
.check-ok   { color:var(--green); }
.check-ng   { color:var(--red); }
.check-none { color:var(--light); }
.sign-box {
  width:60px;height:28px;border:1px solid var(--border);border-radius:5px;
  background:var(--bg);text-align:center;font-size:12px;line-height:28px;color:var(--muted);
}
.submit-row { display:flex;justify-content:flex-end;gap:8px;margin-top:16px; }
.inspect-legend { display:flex;gap:14px;font-size:12px;color:var(--muted);align-items:center; }
</style>
<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">일상점검일지</div>
      <div class="page-sub">설비 일상 점검 기록 및 이력 조회</div>
    </div>
    <button class="btn-primary">📥 인쇄 / 저장</button>
  </div>

  <div class="inspect-header-row">
    <div class="form-field">
      <label class="form-label">점검일</label>
      <input class="form-input" type="date" id="inspDate" style="width:150px">
    </div>
    <div class="form-field">
      <label class="form-label">설비</label>
      <select class="form-select" id="inspEquip" style="width:180px" onchange="loadInspect()">
        <option>열처리로 1호기</option><option>열처리로 2호기</option>
        <option>열처리로 3호기</option><option>열처리로 4호기</option>
        <option>냉각장치 1호기</option><option>냉각장치 2호기</option>
        <option>세척기 1호기</option><option>세척기 2호기</option>
      </select>
    </div>
    <div class="form-field">
      <label class="form-label">반</label>
      <select class="form-select" id="inspShift" style="width:100px">
        <option>주간</option><option>야간</option>
      </select>
    </div>
    <button class="btn-primary btn-sm" style="margin-top:18px" onclick="loadInspect()">조회</button>
    <div class="inspect-legend" style="margin-left:auto">
      <span>✅ 이상없음</span><span>❌ 이상있음</span><span>— 미점검</span>
    </div>
  </div>

  <div class="card">
    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:12px">
      <div class="card-title" style="margin:0" id="inspTitle">열처리로 1호기 — 일상점검일지</div>
      <div>
        점검자: <input class="form-input" type="text" placeholder="성명" style="width:90px;display:inline-block;padding:4px 8px">
        &nbsp;확인자: <input class="form-input" type="text" placeholder="성명" style="width:90px;display:inline-block;padding:4px 8px">
      </div>
    </div>
    <table class="data-table" id="inspTable">
      <thead>
        <tr>
          <th style="width:40px">No</th>
          <th>점검 항목</th>
          <th>점검 기준</th>
          <th style="width:70px;text-align:center">결과</th>
          <th>특이사항</th>
        </tr>
      </thead>
      <tbody id="inspBody"></tbody>
    </table>
    <div class="submit-row">
      <button class="btn-outline">임시저장</button>
      <button class="btn-primary">✅ 점검 완료 저장</button>
    </div>
  </div>
</div>

<script>
var inspItems = {
  '열처리로': [
    {item:'외관 점검',      std:'균열·변형·오염 없음',       result:1, memo:''},
    {item:'도어 실링',      std:'손상·마모 없음',              result:1, memo:''},
    {item:'히터 통전',      std:'단선·소손 없음',              result:1, memo:''},
    {item:'열전대 연결',    std:'접속 불량 없음',              result:1, memo:''},
    {item:'온도 지시 확인', std:'설정값 ±5°C 이내',           result:1, memo:''},
    {item:'O2 센서',        std:'0~1% 정상 지시',              result:0, memo:'0.85% 이상 지시'},
    {item:'분위기 가스 압력','std':'0.05~0.1 MPa',             result:1, memo:''},
    {item:'냉각수 유량',    std:'5L/min 이상',                 result:1, memo:''},
    {item:'인터록 동작',    std:'정상 동작 확인',              result:1, memo:''},
    {item:'배기 팬 동작',   std:'이상 소음·진동 없음',         result:1, memo:''},
    {item:'안전 장치',      std:'정상 작동 확인',              result:1, memo:''},
    {item:'청결 상태',      std:'설비 및 주변 청결 유지',       result:1, memo:''},
  ],
  '냉각장치': [
    {item:'외관 점검',       std:'이상 없음',                  result:1, memo:''},
    {item:'냉각수 수위',     std:'MIN 이상',                   result:1, memo:''},
    {item:'냉각수 온도',     std:'25°C ±3',                    result:0, memo:'28°C 측정'},
    {item:'펌프 동작',       std:'이상 소음 없음',              result:1, memo:''},
    {item:'밸브 개폐 확인',  std:'정상 개폐',                  result:1, memo:''},
  ],
  '세척기': [
    {item:'외관 점검',       std:'이상 없음',                  result:1, memo:''},
    {item:'세척액 농도',     std:'규정 농도 유지',              result:1, memo:''},
    {item:'세척 온도',       std:'60°C ±5',                    result:1, memo:''},
    {item:'필터 상태',       std:'막힘 없음',                  result:1, memo:''},
    {item:'드레인 동작',     std:'정상 배수',                  result:1, memo:''},
  ]
};

function loadInspect(){
  var equip = document.getElementById('inspEquip').value;
  document.getElementById('inspTitle').textContent = equip + ' — 일상점검일지';
  var key = Object.keys(inspItems).find(function(k){ return equip.indexOf(k) >= 0; }) || '열처리로';
  var rows = inspItems[key];
  var html = '';
  rows.forEach(function(r, i){
    var icon = r.result === 1 ? '✅' : r.result === 0 ? '❌' : '—';
    var cls  = r.result === 1 ? 'check-ok' : r.result === 0 ? 'check-ng' : 'check-none';
    html += '<tr>'
          + '<td style="text-align:center">'+(i+1)+'</td>'
          + '<td style="font-weight:600">'+r.item+'</td>'
          + '<td style="color:var(--muted)">'+r.std+'</td>'
          + '<td class="check-cell '+cls+'" onclick="toggleResult('+i+',\''+key+'\',this)">'+icon+'</td>'
          + '<td><input class="form-input" type="text" value="'+r.memo+'" placeholder="특이사항 입력" style="width:100%;padding:4px 8px"></td>'
          + '</tr>';
  });
  document.getElementById('inspBody').innerHTML = html;
}

function toggleResult(idx, key, el){
  var rows = inspItems[key];
  rows[idx].result = rows[idx].result === 1 ? 0 : 1;
  el.textContent = rows[idx].result === 1 ? '✅' : '❌';
  el.className = 'check-cell ' + (rows[idx].result === 1 ? 'check-ok' : 'check-ng');
}

var today = new Date();
document.getElementById('inspDate').value = today.getFullYear()+'-'+String(today.getMonth()+1).padStart(2,'0')+'-'+String(today.getDate()).padStart(2,'0');
loadInspect();
</script>
</body></html>
