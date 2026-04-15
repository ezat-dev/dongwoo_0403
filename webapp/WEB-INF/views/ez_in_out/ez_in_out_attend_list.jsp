<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main_1/common_style.jsp" %>
<style>
/* ── 레이아웃 ── */
.attend-wrap {
  display: grid;
  grid-template-columns: 220px 1fr;
  gap: 16px;
  align-items: start;
}
@media(max-width:800px){ .attend-wrap{ grid-template-columns:1fr; } }

/* ── 좌측 명단 ── */
.emp-panel {
  background: var(--white); border: 1px solid var(--border);
  border-radius: 12px; box-shadow: var(--shadow); overflow: hidden;
  position: sticky; top: 16px;
}
.emp-panel-head {
  padding: 12px 14px; font-size: 12px; font-weight: 700;
  background: var(--bg); border-bottom: 1px solid var(--border);
  display: flex; justify-content: space-between; align-items: center;
}
.emp-list { max-height: calc(100vh - 220px); overflow-y: auto; }
.emp-item {
  padding: 9px 14px; cursor: pointer; border-bottom: 1px solid var(--border);
  transition: background .12s; font-size: 13px;
}
.emp-item:last-child { border-bottom: none; }
.emp-item:hover   { background: var(--bg); }
.emp-item.active  { background: #EBF8FF; border-left: 3px solid var(--primary); color: var(--primary); font-weight: 700; }
.emp-item.all     { font-weight: 700; color: var(--primary); }
.emp-badge {
  display: inline-block; font-size: 10px; padding: 1px 6px;
  border-radius: 10px; background: var(--bg); color: var(--muted);
  margin-left: 6px; float: right;
}
.emp-item.active .emp-badge { background: var(--primary); color: #fff; }

/* ── 상태 뱃지 ── */
.badge { display:inline-block; padding:2px 9px; border-radius:20px; font-size:11px; font-weight:700; white-space:nowrap; }
.b-in  { background:#EBF8FF; color:var(--primary); border:1px solid #BEE3F8; }
.b-ext { background:#FFFAF0; color:var(--orange);  border:1px solid #FBD38D; }
.b-out { background:#F0FFF4; color:var(--green);   border:1px solid #9AE6B4; }

/* ── 우측 컨텐츠 ── */
.content-panel {}

/* ── 필터 바 ── */
.filter-bar {
  background: var(--white); border: 1px solid var(--border);
  border-radius: 12px; padding: 14px 18px;
  margin-bottom: 14px; box-shadow: var(--shadow);
  display: flex; gap: 12px; flex-wrap: wrap; align-items: flex-end;
}
.filter-field { display:flex; flex-direction:column; gap:4px; }
.filter-field label { font-size:11px; font-weight:600; color:var(--muted); }

/* ── 요약 카드 ── */
.summary-row {
  display: grid; grid-template-columns: repeat(4,1fr); gap: 10px; margin-bottom: 14px;
}
@media(max-width:600px){ .summary-row{ grid-template-columns:repeat(2,1fr); } }
.sum-card {
  background: var(--white); border: 1px solid var(--border);
  border-radius: 10px; padding: 10px 14px;
  box-shadow: var(--shadow); text-align: center;
}
.sum-lbl { font-size: 11px; color: var(--muted); margin-bottom: 3px; }
.sum-val { font-size: 22px; font-weight: 800; }

/* ── 선택 사원 타이틀 ── */
.emp-title {
  font-size: 15px; font-weight: 700; margin-bottom: 10px;
  display: flex; align-items: center; gap: 10px;
}
.emp-title span { font-size: 12px; font-weight: 400; color: var(--muted); }
</style>

<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">출퇴근 기록 조회</div>
      <div class="page-sub">사원별 출퇴근 기록 조회 및 엑셀 다운로드</div>
    </div>
    <div style="display:flex;gap:8px;flex-wrap:wrap" id="excelBtns">
      <button class="btn-outline" onclick="downloadExcelAll()">📥 전체 다운로드</button>
      <button class="btn-primary" id="btnEmpExcel" onclick="downloadExcelEmp()" style="display:none">📥 개별 다운로드</button>
      <button class="btn-outline" onclick="location.href=base + '/ez_in_out/attend/list'" style="height:36px">
        🔄 PLC 상태 페이지
      </button>
    </div>
  </div>

  <!-- 필터 바 -->
  <div class="filter-bar">
    <div class="filter-field">
      <label>시작일</label>
      <input class="form-input" type="date" id="fromDt" style="width:140px">
    </div>
    <div class="filter-field">
      <label>종료일</label>
      <input class="form-input" type="date" id="toDt" style="width:140px">
    </div>
    <div class="filter-field">
      <label>&nbsp;</label>
      <button class="btn-primary btn-sm" style="height:34px" onclick="doSearch()">조회</button>
    </div>
    <div id="totalCount" style="font-size:12px;color:var(--muted);align-self:center;margin-left:4px"></div>
  </div>

  <!-- 본문 -->
  <div class="attend-wrap">

    <!-- 좌측 명단 -->
    <div class="emp-panel">
      <div class="emp-panel-head">
        <span>사원 명단</span>
        <span id="empCount" style="font-size:11px;color:var(--muted)">0명</span>
      </div>
      <div class="emp-list" id="empList">
        <div style="padding:20px;text-align:center;color:var(--muted);font-size:12px">조회 후 표시됩니다</div>
      </div>
    </div>

    <!-- 우측 기록 -->
    <div class="content-panel">
      <!-- 요약 카드 -->
      <div class="summary-row">
        <div class="sum-card">
          <div class="sum-lbl">전체</div>
          <div class="sum-val" id="sCnt" style="color:var(--primary)">0</div>
        </div>
        <div class="sum-card">
          <div class="sum-lbl">출근</div>
          <div class="sum-val" id="sIn" style="color:var(--primary)">0</div>
        </div>
        <div class="sum-card">
          <div class="sum-lbl">외근</div>
          <div class="sum-val" id="sExt" style="color:var(--orange)">0</div>
        </div>
        <div class="sum-card">
          <div class="sum-lbl">퇴근</div>
          <div class="sum-val" id="sOut" style="color:var(--green)">0</div>
        </div>
      </div>

      <div class="card">
        <div class="emp-title" id="empTitle">
          전체 기록
          <span id="empTitleSub"></span>
        </div>
        <div style="overflow-x:auto">
          <table class="data-table" id="recordTable">
            <thead>
              <tr>
                <th style="width:44px">No</th>
                <th style="width:110px">날짜</th>
                <th id="thEmpName">사원명</th>
                <th style="text-align:center;width:90px">출근</th>
                <th style="text-align:center;width:90px">외근</th>
                <th style="text-align:center;width:90px">퇴근</th>
                <th style="width:120px">카드코드</th>
              </tr>
            </thead>
            <tbody id="recordBody">
              <tr><td colspan="7" style="text-align:center;padding:40px;color:var(--muted)">조회 버튼을 눌러 기록을 확인하세요</td></tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
var base       = '${pageContext.request.contextPath}';
var allRecords = [];    // 전체 조회 결과 캐시
var curEmp     = null;  // 현재 선택 사원 (null=전체)

/* ── 이번 달 기본값 세팅 ── */
(function initDates() {
  var now   = new Date();
  var y     = now.getFullYear();
  var m     = String(now.getMonth() + 1).padStart(2, '0');
  var last  = new Date(y, now.getMonth() + 1, 0).getDate();
  document.getElementById('fromDt').value = y + '-' + m + '-01';
  document.getElementById('toDt').value   = y + '-' + m + '-' + String(last).padStart(2, '0');
})();

/* ══════════════════════════════════════════
   조회
══════════════════════════════════════════ */
function doSearch() {
  var fromDt = document.getElementById('fromDt').value;
  var toDt   = document.getElementById('toDt').value;
  var qs = '?fromDt=' + encodeURIComponent(fromDt) + '&toDt=' + encodeURIComponent(toDt);

  document.getElementById('recordBody').innerHTML =
    '<tr><td colspan="7" style="text-align:center;padding:30px;color:var(--muted)">로딩 중…</td></tr>';
  // 전체 조회 시 사원명 컬럼 항상 표시
  document.getElementById('thEmpName').style.display = '';

  fetch(base + '/ez_in_out/attend/search' + qs)
    .then(function(r){ return r.json(); })
    .then(function(d) {
      if (!d.success) { alert(d.error || '조회 실패'); return; }
      allRecords = d.data || [];
      curEmp     = null;

      renderEmpList(d.empList || []);
      renderRecords(allRecords);
      document.getElementById('totalCount').textContent = '총 ' + allRecords.length + '건';
    })
    .catch(function() { alert('조회 오류'); });
}

/* ══════════════════════════════════════════
   좌측 명단 렌더링
══════════════════════════════════════════ */
function renderEmpList(empList) {
  document.getElementById('empCount').textContent = empList.length + '명';
  var html = '<div class="emp-item all active" id="emp-all" onclick="selectEmp(null)">'
           + '전체'
           + '<span class="emp-badge">' + allRecords.length + '</span>'
           + '</div>';

  empList.forEach(function(e) {
    html += '<div class="emp-item" id="emp-' + esc(e.empName) + '" onclick="selectEmp(\'' + esc(e.empName) + '\')">'
          + esc(e.empName)
          + '<span class="emp-badge">' + e.totalCnt + '</span>'
          + '</div>';
  });
  document.getElementById('empList').innerHTML = html;
}

/* ══════════════════════════════════════════
   사원 선택
══════════════════════════════════════════ */
function selectEmp(empName) {
  curEmp = empName;

  // 좌측 명단 active
  document.querySelectorAll('.emp-item').forEach(function(el) {
    el.classList.remove('active');
  });
  var target = empName
    ? document.getElementById('emp-' + empName)
    : document.getElementById('emp-all');
  if (target) target.classList.add('active');

  // 개별 다운로드 버튼
  document.getElementById('btnEmpExcel').style.display = empName ? '' : 'none';

  // 사원 선택 시 서버에서 해당 사원 일별 데이터 재조회
  if (empName) {
    var fromDt = document.getElementById('fromDt').value;
    var toDt   = document.getElementById('toDt').value;
    var qs = '?fromDt=' + encodeURIComponent(fromDt)
           + '&toDt='   + encodeURIComponent(toDt)
           + '&empName=' + encodeURIComponent(empName);
    fetch(base + '/ez_in_out/attend/search' + qs)
      .then(function(r){ return r.json(); })
      .then(function(d) {
        if (!d.success) return;
        renderRecords(d.data || [], empName);
      });
  } else {
    renderRecords(allRecords, null);
  }

  // 타이틀
  document.getElementById('empTitle').childNodes[0].textContent = empName ? empName : '전체 기록';
}

/* ══════════════════════════════════════════
   기록 테이블 렌더링 (하루 1줄)
   list: [{empName, cardCode, workDate, inTime, extTime, outTime}, ...]
   selectedEmp: null=전체, string=특정사원
══════════════════════════════════════════ */
function renderRecords(list, selectedEmp) {
  var showEmp = !selectedEmp;
  // 사원명 컬럼 표시 여부
  document.getElementById('thEmpName').style.display = showEmp ? '' : 'none';

  if (!list.length) {
    document.getElementById('recordBody').innerHTML =
      '<tr><td colspan="7" style="text-align:center;padding:40px;color:var(--muted)">기록이 없습니다.</td></tr>';
    updateSummary(0, 0, 0, 0);
    document.getElementById('empTitleSub').textContent = '0건';
    return;
  }

  var inCnt = 0, extCnt = 0, outCnt = 0;
  var html = '';
  list.forEach(function(r, i) {
    if (r.inTime)  inCnt++;
    if (r.extTime) extCnt++;
    if (r.outTime) outCnt++;

    var inCell  = r.inTime  ? '<span class="badge b-in">'  + esc(r.inTime)  + '</span>' : '<span style="color:var(--muted)">—</span>';
    var extCell = r.extTime ? '<span class="badge b-ext">' + esc(r.extTime) + '</span>' : '<span style="color:var(--muted)">—</span>';
    var outCell = r.outTime ? '<span class="badge b-out">' + esc(r.outTime) + '</span>' : '<span style="color:var(--muted)">—</span>';

    html += '<tr>'
      + '<td style="text-align:center;color:var(--muted);font-size:11px">' + (i + 1) + '</td>'
      + '<td style="font-weight:600">' + esc(r.workDate || '') + '</td>'
      + (showEmp ? '<td style="font-weight:600">' + esc(r.empName || '') + '</td>' : '')
      + '<td style="text-align:center">' + inCell  + '</td>'
      + '<td style="text-align:center">' + extCell + '</td>'
      + '<td style="text-align:center">' + outCell + '</td>'
      + '<td style="font-family:monospace;font-size:11px;color:var(--muted)">' + esc(r.cardCode || '') + '</td>'
      + '</tr>';
  });
  document.getElementById('recordBody').innerHTML = html;
  updateSummary(list.length, inCnt, extCnt, outCnt);
  document.getElementById('empTitleSub').textContent = list.length + '건';
}

function updateSummary(total, inCnt, extCnt, outCnt) {
  document.getElementById('sCnt').textContent  = total;
  document.getElementById('sIn').textContent   = inCnt;
  document.getElementById('sExt').textContent  = extCnt;
  document.getElementById('sOut').textContent  = outCnt;
}

/* ══════════════════════════════════════════
   엑셀 다운로드
══════════════════════════════════════════ */
function downloadExcelAll() {
  var fromDt = document.getElementById('fromDt').value;
  var toDt   = document.getElementById('toDt').value;
  var url = base + '/ez_in_out/attend/excel/all'
          + '?fromDt=' + encodeURIComponent(fromDt)
          + '&toDt='   + encodeURIComponent(toDt);
  window.location.href = url;
}

function downloadExcelEmp() {
  if (!curEmp) return;
  var fromDt = document.getElementById('fromDt').value;
  var toDt   = document.getElementById('toDt').value;
  var url = base + '/ez_in_out/attend/excel/emp'
          + '?empName=' + encodeURIComponent(curEmp)
          + '&fromDt='  + encodeURIComponent(fromDt)
          + '&toDt='    + encodeURIComponent(toDt);
  window.location.href = url;
}

/* ── XSS 방지 ── */
function esc(s) {
  return String(s)
    .replace(/&/g,'&amp;').replace(/</g,'&lt;')
    .replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}

/* ── 초기 조회 ── */
doSearch();
</script>
</body>
