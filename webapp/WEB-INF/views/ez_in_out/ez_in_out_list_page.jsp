<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main_1/common_style.jsp" %>
<style>
/* ── 상태 카드 ── */
.plc-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:14px; margin-bottom:18px; }
@media(max-width:700px){ .plc-grid{ grid-template-columns:repeat(2,1fr); } }

.plc-card {
  background:var(--white); border:1px solid var(--border); border-radius:12px;
  padding:16px 18px; box-shadow:var(--shadow); text-align:center; transition:border-color .2s;
}
.plc-card.active { border-color:var(--primary); box-shadow:0 0 0 2px rgba(49,130,206,.2); }
.plc-lbl  { font-size:11px; color:var(--muted); margin-bottom:6px; font-weight:600; letter-spacing:.5px; text-transform:uppercase; }
.plc-val  { font-size:28px; font-weight:800; color:var(--text); line-height:1.1; }
.plc-sub  { font-size:12px; color:var(--muted); margin-top:4px; }

/* ── 인식 결과 박스 ── */
.recognize-box {
  background:var(--white); border:1px solid var(--border); border-radius:12px;
  padding:18px 22px; margin-bottom:18px; box-shadow:var(--shadow);
  display:grid; grid-template-columns:repeat(3,1fr) auto; gap:16px; align-items:center;
}
@media(max-width:700px){ .recognize-box{ grid-template-columns:1fr 1fr; } }

.rec-item {}
.rec-lbl  { font-size:11px; color:var(--muted); margin-bottom:4px; font-weight:600; }
.rec-val  { font-size:16px; font-weight:700; }
.saveable-badge {
  display:inline-block; padding:4px 14px; border-radius:20px;
  font-size:12px; font-weight:700; white-space:nowrap;
}
.s-ok   { background:#EBF8FF; color:var(--primary); border:1px solid #BEE3F8; }
.s-wait { background:var(--bg); color:var(--muted);    border:1px solid var(--border); }
.s-err  { background:#FFF5F5; color:var(--red);       border:1px solid #FEB2B2; }

/* ── 로그 박스 ── */
.log-box {
  background:#1a1a2e; color:#a0d8ef; border-radius:10px;
  padding:14px 16px; font-size:12px; font-family:monospace;
  height:160px; overflow-y:auto; line-height:1.7;
  margin-bottom:18px;
}
.log-box .log-ok   { color:#68d391; }
.log-box .log-dup  { color:#f6ad55; }
.log-box .log-err  { color:#fc8181; }
.log-box .log-info { color:#a0d8ef; }

/* ── 상태 뱃지 ── */
.badge { display:inline-block; padding:2px 9px; border-radius:20px; font-size:11px; font-weight:700; }
.b-in  { background:#EBF8FF; color:var(--primary); border:1px solid #BEE3F8; }
.b-out { background:#F0FFF4; color:var(--green);   border:1px solid #9AE6B4; }
.b-ext { background:#FFFAF0; color:var(--orange);  border:1px solid #FBD38D; }

/* ── 연결 상태 ── */
.conn-dot {
  display:inline-block; width:9px; height:9px; border-radius:50%;
  background:var(--muted); margin-right:6px; transition:background .3s;
}
.conn-dot.ok  { background:var(--green); }
.conn-dot.err { background:var(--red); }

/* ── D46 트리거 버튼 ── */
.btn-trigger {
  padding:7px 18px; border-radius:8px; border:1px solid var(--primary);
  background:var(--primary); color:#fff; font-size:13px; font-weight:600;
  cursor:pointer; transition:opacity .15s;
}
.btn-trigger:hover { opacity:.85; }
.btn-trigger.active { background:#e53e3e; border-color:#e53e3e; }

/* ── 테스트 패널 ── */
.test-panel {
  background:var(--white); border:1px solid var(--border); border-radius:12px;
  padding:18px 22px; margin-bottom:18px; box-shadow:var(--shadow);
}
.test-panel-title {
  font-size:13px; font-weight:700; color:var(--muted);
  margin-bottom:14px; display:flex; align-items:center; gap:8px;
}
.test-panel-title::before {
  content:''; display:inline-block; width:4px; height:16px;
  background:var(--orange); border-radius:2px;
}
.test-row { display:flex; gap:12px; align-items:flex-end; flex-wrap:wrap; }
.test-field { display:flex; flex-direction:column; gap:4px; }
.test-field label { font-size:11px; font-weight:600; color:var(--muted); }
</style>

<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">출퇴근 PLC 기록 관리</div>
      <div class="page-sub">
        <span class="conn-dot" id="connDot"></span>
        <span id="connStatus">PLC 연결 확인 중…</span>
        <span style="margin-left:14px;color:var(--muted);font-size:11px" id="lastUpdate"></span>
      </div>
    </div>
    <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
      <button class="btn-trigger" id="btnTrigger" onclick="testTrigger()"
              title="테스트용: D46=1 write (운영 시 PLC가 자동 처리)">
        🔖 태그 사원증 저장 (테스트)
      </button>
      <button class="btn-outline" onclick="location.href=base + '/ez_in_out/attend/record-list'" style="height:36px">
        📋 기록 조회 페이지
      </button>
    </div>
  </div>

  <!-- ══ 테스트 패널: D45·카드코드 쓰기 ══ -->
  <div class="test-panel">
    <div class="test-panel-title">테스트 PLC 쓰기 (D45 상태 + D61~D64 카드코드)</div>
    <div class="test-row">
      <div class="test-field">
        <label>사원 선택</label>
        <select class="form-select" id="testEmpSel" style="width:160px" onchange="onEmpSelect()">
          <option value="">-- 사원 선택 --</option>
        </select>
      </div>
      <div class="test-field">
        <label>카드코드 (8자리)</label>
        <input class="form-input" type="text" id="testCardCode" maxlength="8"
               placeholder="예) 73054C46" style="width:140px;font-family:monospace;text-transform:uppercase">
      </div>
      <div class="test-field">
        <label>D45 상태</label>
        <select class="form-select" id="testD45" style="width:110px">
          <option value="1">1 · 출근</option>
          <option value="2">2 · 외근</option>
          <option value="3">3 · 퇴근</option>
        </select>
      </div>
      <div class="test-field">
        <label>&nbsp;</label>
        <button class="btn-primary" id="btnWriteTest" onclick="doWriteTest()" style="height:36px;padding:0 18px">
          PLC 값 쓰기
        </button>
      </div>
      <div class="test-field">
        <label>&nbsp;</label>
        <button class="btn-trigger" id="btnTrigger2" onclick="testTrigger()" style="height:36px">
          D46 트리거 (저장)
        </button>
      </div>
    </div>
    <div id="writeResult" style="margin-top:10px;font-size:12px;color:var(--muted)"></div>
  </div>

  <!-- ══ PLC 값 카드 ══ -->
  <div class="plc-grid">
    <!-- D45 -->
    <div class="plc-card" id="cardD45">
      <div class="plc-lbl">D45 · 상태 영역</div>
      <div class="plc-val" id="valD45">—</div>
      <div class="plc-sub" id="nameD45">대기 중</div>
    </div>
    <!-- D46 -->
    <div class="plc-card" id="cardD46">
      <div class="plc-lbl">D46 · 저장 트리거</div>
      <div class="plc-val" id="valD46">—</div>
      <div class="plc-sub" id="nameD46">대기</div>
    </div>
    <!-- D61~D64 합산 -->
    <div class="plc-card" id="cardCode">
      <div class="plc-lbl">카드코드 (D61~D64)</div>
      <div class="plc-val" style="font-size:18px;letter-spacing:1px" id="valCardCode">—</div>
      <div class="plc-sub" id="valD6x" style="font-size:10px">D61· D62· D63· D64·</div>
    </div>
    <!-- 사원명 -->
    <div class="plc-card" id="cardEmp">
      <div class="plc-lbl">인식 사원</div>
      <div class="plc-val" style="font-size:20px" id="valEmpName">—</div>
      <div class="plc-sub" id="valCardFound">카드 미인식</div>
    </div>
  </div>

  <!-- ══ 현재 인식 결과 ══ -->
  <div class="recognize-box">
    <div class="rec-item">
      <div class="rec-lbl">상태</div>
      <div class="rec-val" id="recInOutName" style="color:var(--primary)">—</div>
    </div>
    <div class="rec-item">
      <div class="rec-lbl">카드코드</div>
      <div class="rec-val" style="font-family:monospace" id="recCardCode">—</div>
    </div>
    <div class="rec-item">
      <div class="rec-lbl">사원명</div>
      <div class="rec-val" id="recEmpName">—</div>
    </div>
    <div class="rec-item" style="text-align:right">
      <div class="rec-lbl">저장 가능</div>
      <span class="saveable-badge s-wait" id="recSaveable">대기</span>
    </div>
  </div>

  <!-- ══ 로그 ══ -->
  <div class="card" style="margin-bottom:18px">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:10px">
      <div class="card-title" style="margin:0">스케줄러 로그</div>
      <button class="btn-outline" style="font-size:11px;padding:3px 10px" onclick="clearLogDisplay()">지우기</button>
    </div>
    <div class="log-box" id="logBox">
      <span class="log-info">로그를 불러오는 중…</span>
    </div>
  </div>

  <!-- ══ 최근 저장 이력 ══ -->
  <div class="card">
    <div style="display:flex;align-items:center;gap:10px;margin-bottom:14px">
      <div class="card-title" style="margin:0">최근 저장 이력</div>
      <span id="recordCount" style="font-size:11px;color:var(--muted)"></span>
      <div style="margin-left:auto;display:flex;gap:8px">
        <select class="form-select" id="limitSel" style="width:90px" onchange="loadRecords()">
          <option value="20">20건</option>
          <option value="50">50건</option>
          <option value="100">100건</option>
        </select>
        <button class="btn-primary btn-sm" onclick="loadRecords()">새로고침</button>
      </div>
    </div>
    <div style="overflow-x:auto">
      <table class="data-table" id="recordTable">
        <thead>
          <tr>
            <th>No</th>
            <th>기록일시</th>
            <th style="text-align:center">상태</th>
            <th>카드코드</th>
            <th>사원명</th>
            <th style="text-align:center">D45</th>
            <th style="text-align:center">D46</th>
            <th style="text-align:center">D61</th>
            <th style="text-align:center">D62</th>
            <th style="text-align:center">D63</th>
            <th style="text-align:center">D64</th>
          </tr>
        </thead>
        <tbody id="recordBody">
          <tr><td colspan="11" style="text-align:center;padding:30px;color:var(--muted)">로딩 중…</td></tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script>
var base      = '${pageContext.request.contextPath}';
var pollTimer = null;
var logShown  = [];   // 화면에 출력된 로그 (중복 방지)

/* ══════════════════════════════════════════
   2초마다 PLC 상태 + 로그 폴링
══════════════════════════════════════════ */
function startPolling() {
  pollStatus();
  pollLogs();
  pollTimer = setInterval(function() {
    pollStatus();
    pollLogs();
  }, 2000);
}

/* ── PLC 현재 상태 ── */
function pollStatus() {
  fetch(base + '/ez_in_out/attend/status')
    .then(function(r){ return r.json(); })
    .then(function(d) {
      var dot = document.getElementById('connDot');
      var connTxt = document.getElementById('connStatus');

      if (!d.success) {
        dot.className = 'conn-dot err';
        connTxt.textContent = 'PLC 연결 오류: ' + (d.error || '');
        return;
      }

      dot.className = 'conn-dot ok';
      connTxt.textContent = 'PLC 연결 정상';
      document.getElementById('lastUpdate').textContent = '마지막 조회: ' + d.timestamp;

      /* D45 */
      var d45el = document.getElementById('valD45');
      d45el.textContent = d.d45;
      document.getElementById('nameD45').textContent = d.d45Name;
      var card45 = document.getElementById('cardD45');
      card45.classList.toggle('active', d.d45 >= 1 && d.d45 <= 3);
      var d45Colors = {1:'var(--primary)', 2:'var(--orange)', 3:'var(--green)'};
      d45el.style.color = d45Colors[d.d45] || 'var(--muted)';

      /* D46 */
      var d46el = document.getElementById('valD46');
      d46el.textContent = d.d46;
      document.getElementById('nameD46').textContent = d.d46 === 1 ? '트리거 ON' : '대기';
      d46el.style.color = d.d46 === 1 ? '#e53e3e' : 'var(--muted)';
      document.getElementById('cardD46').classList.toggle('active', d.d46 === 1);

      /* 카드코드 */
      document.getElementById('valCardCode').textContent = d.cardCode || '—';
      document.getElementById('valD6x').textContent =
        'D61:' + d.d61 + '  D62:' + d.d62 + '  D63:' + d.d63 + '  D64:' + d.d64;

      /* 사원명 */
      var empEl = document.getElementById('valEmpName');
      empEl.textContent  = d.empName || '—';
      empEl.style.color  = d.cardFound ? 'var(--primary)' : 'var(--muted)';
      document.getElementById('valCardFound').textContent = d.cardFound ? '카드 인식됨' : '미등록 카드';
      document.getElementById('cardEmp').classList.toggle('active', d.cardFound);

      /* 인식 결과 */
      document.getElementById('recInOutName').textContent = d.d45Name;
      document.getElementById('recCardCode').textContent  = d.cardCode || '—';
      document.getElementById('recEmpName').textContent   = d.empName  || '—';

      var sb = document.getElementById('recSaveable');
      if (d.saveable) {
        sb.textContent  = '저장 가능';
        sb.className    = 'saveable-badge s-ok';
      } else if (!d.cardFound) {
        sb.textContent  = '카드 미인식';
        sb.className    = 'saveable-badge s-err';
      } else {
        sb.textContent  = '대기 중';
        sb.className    = 'saveable-badge s-wait';
      }
    })
    .catch(function(e) {
      document.getElementById('connDot').className = 'conn-dot err';
      document.getElementById('connStatus').textContent = 'PLC API 통신 오류';
    });
}

/* ── 스케줄러 로그 ── */
function pollLogs() {
  fetch(base + '/ez_in_out/attend/logs')
    .then(function(r){ return r.json(); })
    .then(function(d) {
      if (!d.success || !d.logs) return;
      var box  = document.getElementById('logBox');
      var logs = d.logs;                 // 서버: 최신순 정렬

      // 새 로그만 prepend
      var newLogs = [];
      for (var i = 0; i < logs.length; i++) {
        if (logShown.indexOf(logs[i]) === -1) newLogs.push(logs[i]);
      }
      if (newLogs.length === 0) return;

      // logShown 갱신 (최대 200건 유지)
      logShown = logs.slice(0, 200);

      // 로그 html 빌드 (최신이 위)
      var html = '';
      for (var j = 0; j < newLogs.length; j++) {
        var cls = 'log-info';
        var msg = newLogs[j];
        if (msg.indexOf('저장 완료') >= 0) cls = 'log-ok';
        else if (msg.indexOf('중복') >= 0 || msg.indexOf('생략') >= 0) cls = 'log-dup';
        else if (msg.indexOf('오류') >= 0 || msg.indexOf('실패') >= 0) cls = 'log-err';
        html += '<div class="' + cls + '">' + esc(msg) + '</div>';
      }

      // 첫 로그면 초기화, 아니면 앞에 붙이기
      if (box.innerHTML.indexOf('불러오는 중') >= 0) {
        box.innerHTML = html;
      } else {
        box.innerHTML = html + box.innerHTML;
      }
      // 최대 200줄 유지
      var divs = box.querySelectorAll('div');
      if (divs.length > 200) {
        for (var k = 200; k < divs.length; k++) box.removeChild(divs[k]);
      }

      // 새 이력이 있으면 테이블 자동 갱신
      if (newLogs.some(function(l){ return l.indexOf('저장 완료') >= 0; })) {
        loadRecords();
      }
    });
}

function clearLogDisplay() {
  document.getElementById('logBox').innerHTML = '';
  logShown = [];
}

/* ══════════════════════════════════════════
   최근 이력 테이블
══════════════════════════════════════════ */
function loadRecords() {
  var limit = document.getElementById('limitSel').value;
  fetch(base + '/ez_in_out/attend/records?limit=' + limit)
    .then(function(r){ return r.json(); })
    .then(function(d) {
      if (!d.success) { return; }
      var list = d.data || [];
      document.getElementById('recordCount').textContent = '총 ' + list.length + '건';

      if (!list.length) {
        document.getElementById('recordBody').innerHTML =
          '<tr><td colspan="11" style="text-align:center;padding:30px;color:var(--muted)">저장된 이력이 없습니다.</td></tr>';
        return;
      }

      var html = '';
      var badgeMap = {1:'b-in', 2:'b-ext', 3:'b-out'};
      list.forEach(function(r, i) {
        var bc = badgeMap[r.inOutGubun] || '';
        html += '<tr>'
          + '<td style="text-align:center">' + (i + 1) + '</td>'
          + '<td style="font-size:12px">' + esc(r.regDate || r.createdAt || '') + '</td>'
          + '<td style="text-align:center"><span class="badge ' + bc + '">' + esc(r.inOutName || '') + '</span></td>'
          + '<td style="font-family:monospace;font-size:12px">' + esc(r.cardCode || '') + '</td>'
          + '<td style="font-weight:600">' + esc(r.empName || '') + '</td>'
          + '<td style="text-align:center;color:var(--muted)">' + r.plcD45Value + '</td>'
          + '<td style="text-align:center;color:var(--muted)">' + r.plcD46Value + '</td>'
          + '<td style="text-align:center;font-family:monospace">' + esc(r.d61Value || '') + '</td>'
          + '<td style="text-align:center;font-family:monospace">' + esc(r.d62Value || '') + '</td>'
          + '<td style="text-align:center;font-family:monospace">' + esc(r.d63Value || '') + '</td>'
          + '<td style="text-align:center;font-family:monospace">' + esc(r.d64Value || '') + '</td>'
          + '</tr>';
      });
      document.getElementById('recordBody').innerHTML = html;
    })
    .catch(function() {
      document.getElementById('recordBody').innerHTML =
        '<tr><td colspan="11" style="text-align:center;padding:30px;color:var(--red)">이력 조회 실패</td></tr>';
    });
}

/* ══════════════════════════════════════════
   테스트용 D46 트리거
   (실제 운영에서는 PLC가 D46=1 처리)
══════════════════════════════════════════ */
function testTrigger() {
  var btn = document.getElementById('btnTrigger');
  btn.disabled = true;
  btn.textContent = '전송 중…';

  fetch(base + '/ez_in_out/attend/trigger', { method: 'POST' })
    .then(function(r){ return r.json(); })
    .then(function(d) {
      if (d.success) {
        btn.textContent = '✔ 전송 완료';
        btn.classList.add('active');
      } else {
        btn.textContent = '✘ 실패';
        alert('D46 write 실패: ' + (d.error || ''));
      }
      setTimeout(function() {
        btn.disabled    = false;
        btn.textContent = '🔖 태그 사원증 저장 (테스트)';
        btn.classList.remove('active');
      }, 2000);
    })
    .catch(function() {
      btn.disabled    = false;
      btn.textContent = '🔖 태그 사원증 저장 (테스트)';
      alert('PLC 통신 오류');
    });
}

/* ── XSS 방지 ── */
function esc(s) {
  return String(s)
    .replace(/&/g,'&amp;')
    .replace(/</g,'&lt;')
    .replace(/>/g,'&gt;')
    .replace(/"/g,'&quot;');
}

/* ══════════════════════════════════════════
   테스트 패널: 카드 목록 로드
══════════════════════════════════════════ */
function loadCardList() {
  fetch(base + '/ez_in_out/attend/cards')
    .then(function(r){ return r.json(); })
    .then(function(d) {
      if (!d.success) return;
      var sel = document.getElementById('testEmpSel');
      var html = '<option value="">-- 사원 선택 --</option>';
      (d.data || []).forEach(function(c) {
        html += '<option value="' + esc(c.cardCode) + '">'
              + esc(c.empName) + ' (' + esc(c.cardCode) + ')</option>';
      });
      sel.innerHTML = html;
    });
}

/* 사원 선택 시 카드코드 자동 입력 */
function onEmpSelect() {
  var cardCode = document.getElementById('testEmpSel').value;
  document.getElementById('testCardCode').value = cardCode;
}

/* D45 + D61~D64 PLC 쓰기 */
function doWriteTest() {
  var cardCode = document.getElementById('testCardCode').value.trim().toUpperCase();
  var d45      = document.getElementById('testD45').value;
  var resEl    = document.getElementById('writeResult');

  if (cardCode.length !== 8) {
    resEl.style.color = 'var(--red)';
    resEl.textContent = '카드코드는 8자리여야 합니다.';
    return;
  }

  var btn = document.getElementById('btnWriteTest');
  btn.disabled = true;
  btn.textContent = '전송 중…';
  resEl.textContent = '';

  fetch(base + '/ez_in_out/attend/write-test', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ d45: parseInt(d45), cardCode: cardCode })
  })
  .then(function(r){ return r.json(); })
  .then(function(d) {
    if (d.success) {
      resEl.style.color = 'var(--green)';
      resEl.textContent = '✔ PLC 쓰기 완료 — D45=' + d45 + ', 카드코드=' + cardCode;
    } else {
      resEl.style.color = 'var(--red)';
      resEl.textContent = '✘ 실패: ' + (d.error || '');
    }
  })
  .catch(function() {
    resEl.style.color = 'var(--red)';
    resEl.textContent = '✘ 통신 오류';
  })
  .finally(function() {
    btn.disabled    = false;
    btn.textContent = 'PLC 값 쓰기';
  });
}

/* ── 초기화 ── */
loadCardList();
loadRecords();
startPolling();
</script>
</body>
