<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>EX PAGE</title>
<link rel="stylesheet" href="<%=ctx%>/css/monitoring/monitor_nav.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
:root {
  --bg:      #07090F;
  --panel:   #0A0D1A;
  --panel2:  #0D1020;
  --border:  #1A3A5C;
  --accent:  #00F0FF;
  --accent2: #B24BF3;
  --accent3: #00FF88;
  --text:    #A8D8F0;
  --muted:   #3A5A7A;
  --warn:    #FFB700;
  --err:     #FF3B5C;
  --mono:    'Consolas', monospace;
}
* { box-sizing: border-box; margin: 0; padding: 0; }
html, body { height: 100%; overflow: hidden; }
body { background: var(--bg); color: var(--text); font-family: var(--mono); display: flex; flex-direction: column; height: 100vh; }

/* ── 좌측 내부 메뉴 ── */
.layout { display: flex; flex: 1; overflow: hidden; }
.side-menu {
  width: 148px; flex-shrink: 0;
  background: var(--panel2); border-right: 1px solid var(--border);
  display: flex; flex-direction: column; padding: 12px 0; gap: 2px;
}
.side-menu .menu-item {
  padding: 10px 14px; font-size: 12px; font-weight: bold;
  color: var(--muted); cursor: pointer;
  border-left: 3px solid transparent; transition: all .15s; user-select: none;
}
.side-menu .menu-item:hover { color: var(--text); background: #111828; }
.side-menu .menu-item.active { color: var(--accent); border-left-color: var(--accent); background: #001A2A; }

.content { flex: 1; overflow: hidden; display: flex; flex-direction: column; }
.section { display: none; flex: 1; overflow: hidden; }
.section.active { display: flex; }

/* ════ 섹션1: 메인 ════ */
.sec-main { flex-direction: column; align-items: center; justify-content: center; gap: 18px; padding: 40px; }
.main-card { background: var(--panel); border: 1px solid var(--border); border-radius: 8px; padding: 32px 48px; text-align: center; max-width: 500px; width: 100%; }
.main-card h2 { font-size: 20px; color: var(--accent); margin-bottom: 10px; }
.main-card p  { font-size: 12px; color: var(--muted); line-height: 1.9; }
.badge-row { display: flex; gap: 10px; justify-content: center; margin-top: 18px; flex-wrap: wrap; }
.badge { padding: 4px 12px; border-radius: 12px; font-size: 11px; font-weight: bold; border: 1px solid; }
.badge.cyan   { border-color: var(--accent);  color: var(--accent);  }
.badge.purple { border-color: var(--accent2); color: var(--accent2); }
.badge.green  { border-color: var(--accent3); color: var(--accent3); }

/* ════ 섹션2: 도형 편집 ════ */
.sec-shape { flex-direction: row; overflow: hidden; }

.shape-palette {
  width: 120px; flex-shrink: 0;
  background: var(--panel2); border-right: 1px solid var(--border);
  padding: 10px 6px; display: flex; flex-direction: column; gap: 6px; overflow-y: auto;
}
.shape-palette .pal-title { font-size: 10px; color: var(--muted); text-align: center; margin-bottom: 2px; }
.shape-btn {
  display: flex; flex-direction: column; align-items: center; gap: 4px;
  padding: 8px 4px; border: 1px solid var(--border); border-radius: 6px;
  background: var(--panel); cursor: pointer; transition: all .15s;
  font-size: 10px; color: var(--muted);
}
.shape-btn:hover  { border-color: var(--accent); color: var(--text); }
.shape-btn.active { border-color: var(--accent); background: #001A2A; color: var(--accent); }
.shape-icon { font-size: 22px; line-height: 1; }

/* 미리보기 */
.preview-area {
  flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 10px; background: #050710; padding: 16px; position: relative;
}
.preview-label { position: absolute; top: 10px; left: 14px; font-size: 10px; color: var(--muted); }
#shapeCanvas   { border: 1px dashed var(--border); border-radius: 6px; }

/* PLC 연동 패널 (미리보기 아래) */
.plc-inline {
  width: 100%; max-width: 400px;
  background: var(--panel); border: 1px solid var(--border); border-radius: 6px;
  padding: 10px 14px; display: flex; flex-direction: column; gap: 8px;
}
.plc-inline .pi-title { font-size: 11px; color: var(--accent); font-weight: bold; }
.pi-row { display: flex; align-items: center; gap: 8px; }
.pi-row label { font-size: 11px; color: var(--muted); width: 60px; flex-shrink: 0; }
.pi-row select,
.pi-row input[type="text"],
.pi-row input[type="number"] {
  flex: 1; background: var(--panel2); border: 1px solid var(--border);
  color: var(--text); border-radius: 3px; padding: 4px 7px;
  font-size: 11px; font-family: var(--mono); outline: none;
}
.pi-row select:focus, .pi-row input:focus { border-color: var(--accent); }
.pi-row select option { background: #0A0D1A; }
.btn-plc-write {
  padding: 7px 0; background: #001A2A; border: 1px solid var(--accent);
  border-radius: 4px; color: var(--accent); font-family: var(--mono);
  font-size: 12px; font-weight: bold; cursor: pointer; transition: all .15s; letter-spacing: 1px;
}
.btn-plc-write:hover { background: #002A3A; box-shadow: 0 0 8px #00F0FF44; }
.poll-status { font-size: 10px; color: var(--muted); text-align: center; }
.poll-status.on  { color: var(--accent3); }
.poll-status.off { color: var(--err); }

/* 속성 패널 */
.prop-panel {
  width: 210px; flex-shrink: 0;
  background: var(--panel2); border-left: 1px solid var(--border);
  padding: 10px 10px; overflow-y: auto; display: flex; flex-direction: column; gap: 7px;
}
.prop-panel .panel-title { font-size: 11px; font-weight: bold; color: var(--accent); border-bottom: 1px solid var(--border); padding-bottom: 5px; }
.prop-row { display: flex; align-items: center; justify-content: space-between; gap: 6px; font-size: 11px; }
.prop-row label { color: var(--muted); flex-shrink: 0; }
.prop-row input[type="checkbox"] { accent-color: var(--accent); width: 14px; height: 14px; cursor: pointer; }
.prop-row input[type="number"],
.prop-row input[type="text"]  { background: var(--panel); border: 1px solid var(--border); color: var(--text); border-radius: 3px; padding: 3px 6px; font-size: 11px; font-family: var(--mono); width: 80px; }
.prop-row input[type="color"] { padding: 1px 3px; width: 46px; height: 22px; cursor: pointer; background: var(--panel); border: 1px solid var(--border); border-radius: 3px; }
.prop-sec { font-size: 10px; color: var(--accent2); margin-top: 5px; border-top: 1px solid #1A1A3A; padding-top: 5px; }

/* ════ 섹션3: PLC 쓰기 테스트 ════ */
.sec-plc { flex-direction: column; overflow-y: auto; padding: 14px 18px; gap: 12px; }
.plc-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; flex-shrink: 0; }
.plc-card { background: var(--panel); border: 1px solid var(--border); border-radius: 6px; padding: 12px 14px; display: flex; flex-direction: column; gap: 9px; }
.plc-card .card-title { font-size: 12px; font-weight: bold; color: var(--accent); border-bottom: 1px solid var(--border); padding-bottom: 5px; }
.form-row { display: flex; flex-direction: column; gap: 4px; }
.form-row label { font-size: 11px; color: var(--muted); }
.form-row select,
.form-row input[type="text"],
.form-row input[type="number"] {
  background: var(--panel2); border: 1px solid var(--border); color: var(--text);
  border-radius: 3px; padding: 5px 8px; font-size: 11px; font-family: var(--mono); width: 100%; outline: none;
}
.form-row select:focus, .form-row input:focus { border-color: var(--accent); }
.form-row select option { background: #0A0D1A; }
.btn-write {
  padding: 8px 0; background: #001A2A; border: 1px solid var(--accent);
  border-radius: 4px; color: var(--accent); font-family: var(--mono);
  font-size: 12px; font-weight: bold; cursor: pointer; transition: all .15s; letter-spacing: 1px;
}
.btn-write:hover { background: #002A3A; box-shadow: 0 0 8px #00F0FF44; }

.result-box { background: var(--panel2); border: 1px solid var(--border); border-radius: 6px; padding: 10px 14px; flex-shrink: 0; }
.result-box .box-title { font-size: 11px; color: var(--accent2); margin-bottom: 6px; }
.result-line { font-size: 11px; padding: 3px 0; border-bottom: 1px solid #111828; display: flex; gap: 10px; }
.result-line .r-key { color: var(--muted); width: 100px; flex-shrink: 0; }
.result-line .r-val { color: var(--text); word-break: break-all; }
.status-ok  { color: var(--accent3) !important; }
.status-err { color: var(--err) !important; }

.log-box { background: #030507; border: 1px solid var(--border); border-radius: 6px; padding: 10px 12px; flex-shrink: 0; max-height: 100px; overflow-y: auto; }
.log-box .box-title { font-size: 11px; color: var(--muted); margin-bottom: 5px; }
.log-line { font-size: 10px; line-height: 1.7; font-family: var(--mono); }
.log-line.ok  { color: var(--accent3); }
.log-line.err { color: var(--err); }
.log-line.inf { color: var(--muted); }

.code-section { background: var(--panel2); border: 1px solid var(--border); border-radius: 6px; padding: 10px 14px; flex-shrink: 0; }
.code-section .box-title { font-size: 11px; color: var(--accent); margin-bottom: 7px; }
.code-tabs { display: flex; gap: 6px; margin-bottom: 8px; }
.code-tab { padding: 3px 10px; font-size: 11px; border: 1px solid var(--border); border-radius: 3px; background: var(--panel); color: var(--muted); cursor: pointer; transition: all .15s; font-family: var(--mono); }
.code-tab.active { border-color: var(--accent); color: var(--accent); background: #001A2A; }
.code-block { display: none; background: #030507; border: 1px solid #111828; border-radius: 4px; padding: 10px 12px; font-size: 11px; font-family: var(--mono); color: #A8D8F0; white-space: pre; overflow-x: auto; line-height: 1.7; }
.code-block.active { display: block; }
.c-key { color: #B24BF3; } .c-str { color: #00FF88; } .c-fn { color: #00F0FF; } .c-cmt { color: #3A5A7A; }
</style>
</head>
<body>

<%@ include file="../include/monitorNav.jsp" %>

<div class="layout">

  <!-- 좌측 메뉴 -->
  <div class="side-menu">
    <div class="menu-item active" data-sec="main">▶ 메인</div>
    <div class="menu-item"        data-sec="shape">◈ 도형 편집</div>
    <div class="menu-item"        data-sec="plc">⚡ PLC 쓰기 테스트</div>
  </div>

  <div class="content">

    <!-- ════ 섹션1: 메인 ════ -->
    <div class="section sec-main active" id="sec-main">
      <div class="main-card">
        <h2>EX PAGE</h2>
        <p>도형 편집 · PLC 쓰기 · AJAX 코드 확인을 위한 예제 페이지입니다.<br><br>
           좌측 메뉴에서 원하는 섹션으로 이동하세요.</p>
        <div class="badge-row">
          <span class="badge cyan">도형 편집</span>
          <span class="badge purple">속성 패널</span>
          <span class="badge green">PLC 쓰기</span>
        </div>
      </div>
    </div>

    <!-- ════ 섹션2: 도형 편집 ════ -->
    <div class="section sec-shape" id="sec-shape">

      <!-- 도형 팔레트 -->
      <div class="shape-palette">
        <div class="pal-title">도형 선택</div>
        <div class="shape-btn active" data-shape="rect">   <span class="shape-icon">▭</span>사각형</div>
        <div class="shape-btn"        data-shape="circle"> <span class="shape-icon">◯</span>원형</div>
        <div class="shape-btn"        data-shape="triangle"><span class="shape-icon">△</span>삼각형</div>
        <div class="shape-btn"        data-shape="button"> <span class="shape-icon">▣</span>버튼박스</div>
      </div>

      <!-- 미리보기 + PLC 연동 -->
      <div class="preview-area">
        <span class="preview-label">PREVIEW</span>
        <canvas id="shapeCanvas" width="320" height="220"></canvas>

        <!-- PLC 연동 패널 -->
        <div class="plc-inline">
          <div class="pi-title">⚡ PLC 연동 — 값 쓰기 / 상태 모니터링</div>
          <div class="pi-row">
            <label>PLC 선택</label>
            <select id="shapePlcSelect">
              <option value="">-- DB 로딩 중 --</option>
            </select>
          </div>
          <div class="pi-row">
            <label>주소</label>
            <input type="text" id="shapeAddress" placeholder="%MW100 또는 10001">
          </div>
          <div class="pi-row">
            <label>쓸 값</label>
            <input type="number" id="shapeWriteVal" value="1" min="0">
          </div>
          <button class="btn-plc-write" id="btnShapeWrite">▶ 주소에 값 쓰기</button>
          <div class="poll-status" id="pollStatus">● 폴링 대기 중 (주소 입력 후 자동 시작)</div>
        </div>
      </div>

      <!-- 속성 패널 -->
      <div class="prop-panel">
        <div class="panel-title">⚙ 속성</div>

        <div class="prop-sec">표시 / 애니메이션</div>
        <div class="prop-row"><label>보이기</label>    <input type="checkbox" id="p-visible" checked></div>
        <div class="prop-row"><label>깜빡임</label>    <input type="checkbox" id="p-blink"></div>

        <div class="prop-sec">변환</div>
        <div class="prop-row"><label>회전 (°)</label>  <input type="number" id="p-rotate" value="0" min="0" max="360"></div>
        <div class="prop-row"><label>좌우 뒤집기</label><input type="checkbox" id="p-flipx"></div>
        <div class="prop-row"><label>상하 뒤집기</label><input type="checkbox" id="p-flipy"></div>

        <div class="prop-sec">색상</div>
        <div class="prop-row"><label>배경색</label>    <input type="color" id="p-bgcolor"      value="#00F0FF"></div>
        <div class="prop-row"><label>테두리색</label>   <input type="color" id="p-bordercolor"  value="#1A3A5C"></div>
        <div class="prop-row"><label>활성화색</label>   <input type="color" id="p-activecolor"  value="#00FF88"></div>

        <div class="prop-sec">텍스트 / 값</div>
        <div class="prop-row"><label>텍스트 표시</label><input type="checkbox" id="p-showtext" checked></div>
        <div class="prop-row"><label>Value 입력란</label><input type="checkbox" id="p-showvalue"></div>
      </div>
    </div><!-- /sec-shape -->

    <!-- ════ 섹션3: PLC 쓰기 테스트 ════ -->
    <div class="section sec-plc" id="sec-plc">

      <div class="plc-grid">
        <div class="plc-card">
          <div class="card-title">① PLC 선택 (tb_plc)</div>
          <div class="form-row">
            <label>PLC 선택 (label)</label>
            <select id="plcItemSelect">
              <option value="">-- 로딩 중 --</option>
            </select>
          </div>
          <div class="form-row">
            <label>주소 (직접 수정 가능)</label>
            <input type="text" id="plcAddress" placeholder="%MW100">
          </div>
        </div>
        <div class="plc-card">
          <div class="card-title">② 값 입력 및 쓰기</div>
          <div class="form-row">
            <label>Value</label>
            <input type="number" id="plcValue" value="1" min="0">
          </div>
          <button class="btn-write" id="btnWrite">▶ 값 쓰기 (WRITE)</button>
        </div>
      </div>

      <div class="result-box">
        <div class="box-title">마지막 요청 결과</div>
        <div class="result-line"><span class="r-key">PLC</span>      <span class="r-val" id="r-item">-</span></div>
        <div class="result-line"><span class="r-key">주소</span>     <span class="r-val" id="r-addr">-</span></div>
        <div class="result-line"><span class="r-key">값</span>       <span class="r-val" id="r-val">-</span></div>
        <div class="result-line"><span class="r-key">상태</span>     <span class="r-val" id="r-status">-</span></div>
        <div class="result-line"><span class="r-key">서버 응답</span><span class="r-val" id="r-resp">-</span></div>
      </div>

      <div class="log-box">
        <div class="box-title">▍ 디버그 로그</div>
        <div id="logArea"></div>
      </div>

      <div class="code-section">
        <div class="box-title">AJAX 요청 코드 보기</div>
        <div class="code-tabs">
          <div class="code-tab active" data-ctab="jquery">jQuery</div>
          <div class="code-tab"        data-ctab="fetch">fetch</div>
        </div>
        <div class="code-block active" id="code-jquery"></div>
        <div class="code-block"        id="code-fetch"></div>
      </div>

    </div><!-- /sec-plc -->
  </div>
</div>

<script>
var CTX = '<%=ctx%>';

/* ════════════════════════════════════
   내부 메뉴 SPA 전환
════════════════════════════════════ */
$('.side-menu .menu-item').on('click', function () {
  var sec = $(this).data('sec');
  $('.menu-item').removeClass('active');
  $(this).addClass('active');
  $('.section').removeClass('active');
  $('#sec-' + sec).addClass('active');
  if (sec === 'shape') renderShape();
  if (sec === 'plc')   updateCodeExample();
});

/* ════════════════════════════════════
   tb_plc DB 목록 로드 (공통)
════════════════════════════════════ */
var plcDbList = [];

function loadPlcList(callback) {
  $.ajax({
    url: CTX + '/plc/dblist',
    type: 'GET',
    dataType: 'json',
    success: function (res) {
      if (res.success) {
        plcDbList = res.data;

        // 도형 편집 섹션 select
        var $ss = $('#shapePlcSelect').empty().append('<option value="">-- 선택 --</option>');
        // PLC 쓰기 테스트 섹션 select
        var $ps = $('#plcItemSelect').empty().append('<option value="">-- 선택 --</option>');

        $.each(plcDbList, function (i, p) {
          var opt = '<option value="' + p.plcId + '" data-label="' + p.label + '">' + p.label + ' (' + p.ip + ')</option>';
          $ss.append(opt);
          $ps.append(opt);
        });

        if (callback) callback();
      }
    },
    error: function () {
      $('#shapePlcSelect').html('<option value="">DB 연결 실패</option>');
      $('#plcItemSelect').html('<option value="">DB 연결 실패</option>');
    }
  });
}

/* ════════════════════════════════════
   도형 캔버스
════════════════════════════════════ */
var currentShape = 'rect';
var blinkTimer   = null;
var blinkState   = true;
var pollTimer    = null;
var isActive     = false;   // PLC 값 == 1 이면 true

function getProps() {
  return {
    visible    : $('#p-visible').is(':checked'),
    blink      : $('#p-blink').is(':checked'),
    rotate     : parseInt($('#p-rotate').val()) || 0,
    flipX      : $('#p-flipx').is(':checked'),
    flipY      : $('#p-flipy').is(':checked'),
    bgColor    : isActive ? $('#p-activecolor').val() : $('#p-bgcolor').val(),
    borderColor: $('#p-bordercolor').val(),
    showText   : $('#p-showtext').is(':checked'),
    showValue  : $('#p-showvalue').is(':checked')
  };
}

function renderShape(forceVisible) {
  var p   = getProps();
  var cv  = document.getElementById('shapeCanvas');
  var ctx = cv.getContext('2d');
  var W = cv.width, H = cv.height;
  ctx.clearRect(0, 0, W, H);

  var visible = (forceVisible !== undefined) ? forceVisible : p.visible;
  if (!visible) {
    ctx.fillStyle = '#0A0D1A'; ctx.fillRect(0, 0, W, H);
    ctx.fillStyle = '#3A5A7A'; ctx.font = '13px Consolas';
    ctx.textAlign = 'center'; ctx.fillText('[ 숨김 상태 ]', W/2, H/2);
    return;
  }

  ctx.save();
  ctx.translate(W/2, H/2);
  ctx.rotate((p.rotate * Math.PI) / 180);
  ctx.scale(p.flipX ? -1 : 1, p.flipY ? -1 : 1);

  ctx.fillStyle   = p.bgColor;
  ctx.strokeStyle = p.borderColor;
  ctx.lineWidth   = isActive ? 3 : 2;

  var s = currentShape;
  if (s === 'rect' || s === 'button') {
    var rw = s === 'button' ? 130 : 100, rh = s === 'button' ? 48 : 100;
    roundRect(ctx, -rw/2, -rh/2, rw, rh, s === 'button' ? 8 : 4);
    ctx.fill(); ctx.stroke();
    if (p.showText) {
      ctx.restore(); ctx.save(); ctx.translate(W/2, H/2);
      ctx.fillStyle = '#07090F'; ctx.font = 'bold 12px Consolas';
      ctx.textAlign = 'center'; ctx.textBaseline = 'middle';
      ctx.fillText(s === 'button' ? (isActive ? '▶  ON' : '▶  OFF') : (isActive ? 'ON' : 'RECT'), 0, 0);
    }
  } else if (s === 'circle') {
    ctx.beginPath(); ctx.arc(0, 0, 65, 0, Math.PI*2); ctx.fill(); ctx.stroke();
    if (p.showText) {
      ctx.restore(); ctx.save(); ctx.translate(W/2, H/2);
      ctx.fillStyle = '#07090F'; ctx.font = 'bold 12px Consolas';
      ctx.textAlign = 'center'; ctx.textBaseline = 'middle';
      ctx.fillText(isActive ? 'ON' : 'CIRC', 0, 0);
    }
  } else if (s === 'triangle') {
    ctx.beginPath(); ctx.moveTo(0,-72); ctx.lineTo(68,58); ctx.lineTo(-68,58); ctx.closePath();
    ctx.fill(); ctx.stroke();
    if (p.showText) {
      ctx.restore(); ctx.save(); ctx.translate(W/2, H/2);
      ctx.fillStyle = '#07090F'; ctx.font = 'bold 11px Consolas';
      ctx.textAlign = 'center'; ctx.textBaseline = 'middle';
      ctx.fillText(isActive ? 'ON' : 'TRI', 0, 14);
    }
  }
  ctx.restore();

  if (p.showValue) {
    ctx.fillStyle = '#1A3A5C'; ctx.fillRect(W/2-44, H/2+82, 88, 20);
    ctx.strokeStyle = '#2A5A7A'; ctx.lineWidth = 1; ctx.strokeRect(W/2-44, H/2+82, 88, 20);
    ctx.fillStyle = '#00F0FF'; ctx.font = '10px Consolas';
    ctx.textAlign = 'center'; ctx.textBaseline = 'middle';
    ctx.fillText('val: ' + ($('#shapeWriteVal').val()||'0'), W/2, H/2+92);
  }

  // 활성화 시 글로우 효과
  if (isActive) {
    ctx.save();
    ctx.shadowColor = $('#p-activecolor').val();
    ctx.shadowBlur  = 24;
    ctx.strokeStyle = $('#p-activecolor').val();
    ctx.lineWidth   = 1;
    if (s === 'circle') { ctx.beginPath(); ctx.arc(W/2, H/2, 68, 0, Math.PI*2); ctx.stroke(); }
    ctx.restore();
  }
}

function roundRect(ctx, x, y, w, h, r) {
  ctx.beginPath();
  ctx.moveTo(x+r,y); ctx.lineTo(x+w-r,y); ctx.quadraticCurveTo(x+w,y,x+w,y+r);
  ctx.lineTo(x+w,y+h-r); ctx.quadraticCurveTo(x+w,y+h,x+w-r,y+h);
  ctx.lineTo(x+r,y+h); ctx.quadraticCurveTo(x,y+h,x,y+h-r);
  ctx.lineTo(x,y+r); ctx.quadraticCurveTo(x,y,x+r,y); ctx.closePath();
}

$('.shape-btn').on('click', function () {
  $('.shape-btn').removeClass('active'); $(this).addClass('active');
  currentShape = $(this).data('shape'); renderShape();
});

$('#p-visible,#p-blink,#p-flipx,#p-flipy,#p-showtext,#p-showvalue').on('change', function () { restartBlink(); renderShape(); });
$('#p-rotate,#p-bgcolor,#p-bordercolor,#p-activecolor').on('input', function () { renderShape(); });
$('#shapeWriteVal').on('input', function () { renderShape(); });

function restartBlink() {
  if (blinkTimer) clearInterval(blinkTimer);
  if ($('#p-blink').is(':checked') && $('#p-visible').is(':checked')) {
    blinkTimer = setInterval(function () { blinkState = !blinkState; renderShape(blinkState); }, 500);
  }
}

/* ════════════════════════════════════
   도형 편집 — PLC 쓰기
════════════════════════════════════ */
$('#btnShapeWrite').on('click', function () {
  var plcId   = $('#shapePlcSelect').val();
  var address = $('#shapeAddress').val().trim();
  var value   = parseInt($('#shapeWriteVal').val()) || 0;

  if (!address) { $('#pollStatus').text('⚠ 주소를 입력하세요.').removeClass('on off'); return; }

  var payload = { address: parseInt(address) || 0, value: value };
  var url = plcId ? CTX + '/plc/write/' + plcId : CTX + '/plc/write';

  $.ajax({
    url: url, type: 'POST', contentType: 'application/json',
    data: JSON.stringify(payload),
    success: function (res) {
      if (res && res.success) {
        $('#pollStatus').text('✔ 쓰기 성공 — 폴링 중...').addClass('on').removeClass('off');
        startPoll(plcId, address);
      } else {
        $('#pollStatus').text('✘ 쓰기 실패: ' + (res.error||'')).addClass('off').removeClass('on');
      }
    },
    error: function (xhr) {
      $('#pollStatus').text('✘ HTTP 오류: ' + xhr.status).addClass('off').removeClass('on');
    }
  });
});

/* ── 주소 값 폴링 (1이면 도형 활성화) ── */
function startPoll(plcId, address) {
  if (pollTimer) clearInterval(pollTimer);
  var addr = parseInt(address) || 0;
  var url  = plcId
    ? CTX + '/plc/read/' + plcId + '?start=' + addr + '&count=1'
    : CTX + '/plc/read?start=' + addr + '&count=1';

  pollTimer = setInterval(function () {
    $.ajax({
      url: url, type: 'GET', dataType: 'json',
      success: function (res) {
        if (res && res.success && res.values && res.values.length > 0) {
          var val = res.values[0];
          var wasActive = isActive;
          isActive = (val === 1);
          if (wasActive !== isActive) renderShape();
          $('#pollStatus')
            .text('● 폴링 중 — 현재값: ' + val + (isActive ? '  [활성화]' : '  [비활성]'))
            .toggleClass('on', isActive).toggleClass('off', !isActive);
        }
      }
    });
  }, 1000);
}

/* 주소 입력하면 자동 폴링 시작 */
$('#shapeAddress').on('change', function () {
  var addr = $(this).val().trim();
  if (addr) startPoll($('#shapePlcSelect').val(), addr);
  else { if (pollTimer) clearInterval(pollTimer); }
});

/* ════════════════════════════════════
   PLC 쓰기 테스트 섹션
════════════════════════════════════ */
$('#plcItemSelect').on('change', function () {
  updateCodeExample();
});
$('#plcAddress,#plcValue').on('input', updateCodeExample);

$('#btnWrite').on('click', function () {
  var plcId   = $('#plcItemSelect').val();
  var label   = $('#plcItemSelect option:selected').data('label') || plcId || '-';
  var address = $('#plcAddress').val().trim();
  var value   = $('#plcValue').val();

  if (!address) { addLog('err', '주소를 입력하세요.'); return; }

  var payload = { address: parseInt(address) || 0, value: parseInt(value) || 0 };
  var url = plcId ? CTX + '/plc/write/' + plcId : CTX + '/plc/write';

  $('#r-item').text(label); $('#r-addr').text(address); $('#r-val').text(value);
  $('#r-status').text('요청 중...').attr('class','r-val');
  addLog('inf', '→ POST ' + url + '  ' + JSON.stringify(payload));

  $.ajax({
    url: url, type: 'POST', contentType: 'application/json',
    data: JSON.stringify(payload),
    success: function (res) {
      if (res && res.success) {
        $('#r-status').text('✔ 성공').addClass('status-ok');
        addLog('ok', '← 성공: ' + JSON.stringify(res));
      } else {
        $('#r-status').text('✘ 실패').addClass('status-err');
        addLog('err', '← 실패: ' + JSON.stringify(res));
      }
      $('#r-resp').text(JSON.stringify(res));
    },
    error: function (xhr) {
      var msg = xhr.status + ' ' + xhr.statusText;
      $('#r-status').text('✘ 오류').addClass('status-err');
      $('#r-resp').text(msg);
      addLog('err', '← HTTP 오류: ' + msg);
    }
  });
});

function addLog(type, msg) {
  var time = new Date().toTimeString().substr(0,8);
  $('#logArea').prepend('<div class="log-line '+type+'">['+time+'] '+msg+'</div>');
  var lines = $('#logArea .log-line');
  if (lines.length > 30) lines.last().remove();
}

/* ════════════════════════════════════
   AJAX 코드 예시
════════════════════════════════════ */
function updateCodeExample() {
  var plcId = $('#plcItemSelect').val() || 'plc1';
  var label = $('#plcItemSelect option:selected').data('label') || plcId;
  var addr  = $('#plcAddress').val() || '%MW100';
  var val   = $('#plcValue').val()   || '1';
  var url   = CTX + '/plc/write' + (plcId ? '/' + plcId : '');

  var jq = '<span class="c-cmt">// jQuery AJAX — PLC: ' + label + '</span>\n'
    + '<span class="c-fn">$.ajax</span>({\n'
    + '  <span class="c-key">url</span>        : <span class="c-str">\'' + url + '\'</span>,\n'
    + '  <span class="c-key">type</span>       : <span class="c-str">\'POST\'</span>,\n'
    + '  <span class="c-key">contentType</span>: <span class="c-str">\'application/json\'</span>,\n'
    + '  <span class="c-key">data</span>       : <span class="c-fn">JSON.stringify</span>({ <span class="c-key">address</span>: <span class="c-str">\'' + addr + '\'</span>, <span class="c-key">value</span>: <span class="c-str">\'' + val + '\'</span> }),\n'
    + '  <span class="c-key">success</span>: res => <span class="c-fn">console</span>.log(res),\n'
    + '  <span class="c-key">error</span>  : xhr => <span class="c-fn">console</span>.error(xhr.statusText)\n'
    + '});';

  var ft = '<span class="c-cmt">// fetch — PLC: ' + label + '</span>\n'
    + '<span class="c-fn">fetch</span>(<span class="c-str">\'' + url + '\'</span>, {\n'
    + '  <span class="c-key">method</span> : <span class="c-str">\'POST\'</span>,\n'
    + '  <span class="c-key">headers</span>: { <span class="c-str">\'Content-Type\'</span>: <span class="c-str">\'application/json\'</span> },\n'
    + '  <span class="c-key">body</span>   : <span class="c-fn">JSON.stringify</span>({ <span class="c-key">address</span>: <span class="c-str">\'' + addr + '\'</span>, <span class="c-key">value</span>: <span class="c-str">\'' + val + '\'</span> })\n'
    + '})\n'
    + '.<span class="c-fn">then</span>(r => r.<span class="c-fn">json</span>())\n'
    + '.<span class="c-fn">then</span>(res => <span class="c-fn">console</span>.log(res))\n'
    + '.<span class="c-fn">catch</span>(err => <span class="c-fn">console</span>.error(err));';

  $('#code-jquery').html(jq);
  $('#code-fetch').html(ft);
}

$('.code-tab').on('click', function () {
  var tab = $(this).data('ctab');
  $('.code-tab').removeClass('active'); $(this).addClass('active');
  $('.code-block').removeClass('active'); $('#code-' + tab).addClass('active');
});

/* ════════════════════════════════════
   초기화
════════════════════════════════════ */
$(function () {
  loadPlcList(function () { updateCodeExample(); });
  renderShape();
});
</script>
</body>
</html>
