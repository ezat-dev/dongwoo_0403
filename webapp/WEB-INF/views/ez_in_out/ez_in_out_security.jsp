<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="theme-color" content="#1B5E52">
    <title>EZ Automation - 경비 모니터링</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary:      #2E7D6F;
            --primary-dark: #1B5E52;
            --primary-mid:  #245F55;
            --primary-light:#3D9B8A;
            --accent:       #4ABFAE;
            --accent-glow:  rgba(74,191,174,0.22);
            --danger:       #EF4444;
            --danger-glow:  rgba(239,68,68,0.22);
            --success:      #22C55E;
            --bg:           #F0F4F3;
            --white:        #FFFFFF;
            --text-main:    #1A2E2B;
            --text-sub:     #4A6360;
            --text-muted:   #8AA3A0;
            --border:       #CDDEDA;
            --card-header:  #E4EDEB;
            --shadow-sm:    0 2px 8px rgba(27,94,82,0.08);
            --shadow-md:    0 8px 32px rgba(27,94,82,0.13);
            --shadow-lg:    0 20px 60px rgba(27,94,82,0.18);
            --radius-sm:    10px;
            --radius-md:    18px;
            --radius-lg:    28px;
            --transition:   0.28s cubic-bezier(0.4, 0, 0.2, 1);
        }

        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            -webkit-tap-highlight-color: transparent;
        }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: var(--bg);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px 16px 40px;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 340px;
            background: linear-gradient(145deg, var(--primary-dark) 0%, var(--primary-mid) 55%, var(--primary) 100%);
            z-index: 0;
            clip-path: ellipse(120% 100% at 50% 0%);
        }

        body::after {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 340px;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.025'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            z-index: 0;
            clip-path: ellipse(120% 100% at 50% 0%);
        }

        .page-wrapper {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0;
        }

        /* ── 헤더 ── */
        .header {
            width: 100%;
            text-align: center;
            padding: 0 0 28px;
            color: var(--white);
        }

        .logo-wrap {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 18px;
        }

        .logo-svg-container {
            width: 68px;
            height: 68px;
            background: var(--white);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 6px 24px rgba(0,0,0,0.22);
            padding: 8px;
        }

        .header-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(74,191,174,0.22);
            border: 1px solid rgba(74,191,174,0.4);
            border-radius: 100px;
            padding: 5px 14px;
            font-size: 11px;
            font-weight: 600;
            color: rgba(255,255,255,0.9);
            letter-spacing: 0.06em;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .header h1 {
            font-size: 22px;
            font-weight: 700;
            color: var(--white);
            letter-spacing: -0.02em;
            margin-bottom: 6px;
        }

        .header p {
            font-size: 13.5px;
            color: rgba(255,255,255,0.6);
            font-weight: 400;
        }

        /* ── 메인 카드 ── */
        .main-card {
            width: 100%;
            background: var(--white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            padding: 28px 20px 32px;
            animation: cardRise 0.55s cubic-bezier(0.22, 1, 0.36, 1) both;
        }

        @keyframes cardRise {
            from { opacity: 0; transform: translateY(28px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ── 경비 제어 버튼 ── */
        .section-title {
            font-size: 12px;
            font-weight: 700;
            color: var(--text-muted);
            letter-spacing: 0.08em;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .control-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 24px;
        }

        .btn-ctrl {
            height: 56px;
            border: none;
            border-radius: var(--radius-md);
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            transition: all var(--transition);
            position: relative;
            overflow: hidden;
        }

        .btn-ctrl:active { transform: scale(0.96); }

        .btn-start {
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            color: var(--white);
            box-shadow: 0 6px 20px rgba(27,94,82,0.32);
        }

        .btn-start:hover { box-shadow: 0 8px 28px rgba(27,94,82,0.45); }

        .btn-stop {
            background: linear-gradient(135deg, #B91C1C, var(--danger));
            color: var(--white);
            box-shadow: 0 6px 20px rgba(239,68,68,0.28);
        }

        .btn-stop:hover { box-shadow: 0 8px 28px rgba(239,68,68,0.4); }

        .btn-ctrl:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        /* 피드백 메시지 */
        .ctrl-feedback {
            text-align: center;
            font-size: 12px;
            font-weight: 600;
            min-height: 18px;
            margin-bottom: 20px;
            margin-top: -8px;
            color: var(--text-muted);
            transition: all 0.3s ease;
        }

        .ctrl-feedback.ok  { color: var(--success); }
        .ctrl-feedback.err { color: var(--danger);  }

        /* ── 구분선 ── */
        .divider {
            height: 1px;
            background: var(--border);
            margin-bottom: 20px;
        }

        /* ── 상태 그리드 ── */
        .monitor-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 8px;
        }

        .monitor-card {
            background: var(--white);
            border: 1.5px solid var(--border);
            border-radius: var(--radius-sm);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            transition: box-shadow var(--transition);
        }

        .monitor-card:hover { box-shadow: var(--shadow-md); }

        .card-label {
            background: var(--card-header);
            padding: 9px 10px;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-main);
            text-align: center;
            border-bottom: 1px solid var(--border);
            line-height: 1.3;
            min-height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-body {
            background: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 18px 10px;
        }

        @keyframes breatheOff {
            0%, 100% { box-shadow: 0 4px 14px rgba(239,68,68,0.35); transform: scale(1); }
            50%       { box-shadow: 0 6px 26px rgba(239,68,68,0.65); transform: scale(1.05); }
        }

        @keyframes breatheOn {
            0%, 100% { box-shadow: 0 4px 14px rgba(34,197,94,0.35); transform: scale(1); }
            50%       { box-shadow: 0 6px 26px rgba(34,197,94,0.70); transform: scale(1.05); }
        }

        @keyframes stateFlip {
            0%   { transform: scale(1); }
            35%  { transform: scale(1.22); }
            70%  { transform: scale(0.92); }
            100% { transform: scale(1); }
        }

        .status-circle {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            border: 3px solid rgba(255,255,255,0.85);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
            color: var(--white);
            cursor: default;
            user-select: none;
            transition: background 0.35s ease;
            /* OFF (0) = 빨강 + 잔잔한 호흡 */
            background: var(--danger);
            animation: breatheOff 2.8s ease-in-out infinite;
        }

        /* ON (1) = 초록 + 잔잔한 호흡 */
        .status-circle.on {
            background: var(--success);
            animation: breatheOn 2.8s ease-in-out infinite;
        }

        /* 상태 변경 시 튀는 애니메이션 (호흡 애니메이션 덮어씀) */
        .status-circle.flip {
            animation: stateFlip 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) !important;
        }

        /* ── 폴링 인디케이터 ── */
        .poll-bar {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            margin-top: 20px;
            font-size: 11px;
            color: var(--text-muted);
        }

        .poll-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--primary-light);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 0.3; transform: scale(0.8); }
            50%       { opacity: 1;   transform: scale(1.2); }
        }

        /* ── 돌아가기 ── */
        .btn-back {
            width: 100%;
            height: 48px;
            margin-top: 16px;
            background: transparent;
            border: 1.5px solid var(--border);
            border-radius: var(--radius-md);
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-sub);
            cursor: pointer;
            transition: all var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            text-decoration: none;
        }

        .btn-back:hover {
            border-color: var(--accent);
            color: var(--primary);
            background: rgba(74,191,174,0.05);
        }

        /* ── 푸터 ── */
        .footer {
            margin-top: 28px;
            text-align: center;
            color: rgba(255,255,255,0.38);
            font-size: 11px;
            letter-spacing: 0.02em;
        }

        @media (min-width: 440px) {
            .main-card { padding: 32px 28px 36px; }
            .status-circle { width: 76px; height: 76px; font-size: 14px; }
        }

        /* ── 냉난방 경고 모달 ── */
        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.52);
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            animation: fadeIn 0.2s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        .modal-box {
            background: var(--white);
            border-radius: var(--radius-lg);
            padding: 32px 24px 28px;
            width: 100%;
            max-width: 340px;
            text-align: center;
            box-shadow: 0 24px 64px rgba(0,0,0,0.28);
            animation: popIn 0.28s cubic-bezier(0.22,1,0.36,1) both;
        }

        @keyframes popIn {
            from { transform: scale(0.88); opacity: 0; }
            to   { transform: scale(1);    opacity: 1; }
        }

        .modal-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #F59E0B, #EF4444);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
            box-shadow: 0 8px 24px rgba(239,68,68,0.28);
        }

        .modal-box h3 {
            font-size: 17px;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 10px;
        }

        .modal-box p {
            font-size: 13.5px;
            color: var(--text-sub);
            line-height: 1.7;
            margin-bottom: 24px;
        }

        .modal-hvac-list {
            background: #FFF8F0;
            border: 1px solid #FDE68A;
            border-radius: var(--radius-sm);
            padding: 10px 14px;
            margin-bottom: 20px;
            text-align: left;
            font-size: 12.5px;
            color: #92400E;
            font-weight: 500;
            line-height: 1.8;
        }

        .modal-btns {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .modal-btn-cancel {
            height: 48px;
            background: transparent;
            border: 1.5px solid var(--border);
            border-radius: var(--radius-md);
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-sub);
            cursor: pointer;
            transition: all var(--transition);
        }

        .modal-btn-cancel:hover {
            border-color: var(--accent);
            color: var(--primary);
        }

        .modal-btn-confirm {
            height: 48px;
            background: linear-gradient(135deg, #B91C1C, var(--danger));
            border: none;
            border-radius: var(--radius-md);
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 14px;
            font-weight: 700;
            color: white;
            cursor: pointer;
            box-shadow: 0 4px 16px rgba(239,68,68,0.3);
            transition: all var(--transition);
        }

        .modal-btn-confirm:hover {
            box-shadow: 0 6px 22px rgba(239,68,68,0.45);
        }
    </style>
</head>
<body>

<div class="page-wrapper">

    <!-- 헤더 -->
    <header class="header">
        <div class="logo-wrap">
            <div class="logo-svg-container">
                <img src="${pageContext.request.contextPath}/img/company_logo.png" alt="Company Logo"
                     style="width:100%;height:100%;object-fit:contain;">
            </div>
        </div>
        <div class="header-badge">
            <svg width="10" height="12" viewBox="0 0 10 12" fill="none">
                <path d="M5 1L1 3.5V8.5L5 11L9 8.5V3.5L5 1Z" stroke="white" stroke-width="1.3" stroke-linejoin="round"/>
                <circle cx="5" cy="6" r="1.5" fill="white"/>
            </svg>
            경비 구역
        </div>
        <h1>경비 모니터링</h1>
        <p>실시간 센서 상태를 확인합니다</p>
    </header>

    <!-- 메인 카드 -->
    <div class="main-card">

        <!-- 경비 제어 -->
        <div class="section-title">경비 제어</div>
        <div class="control-row">
            <button class="btn-ctrl btn-start" id="btnStart" onclick="checkAndStart()">
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none">
                    <circle cx="9" cy="9" r="7.5" stroke="white" stroke-width="1.5"/>
                    <path d="M7 6L13 9L7 12V6Z" fill="white"/>
                </svg>
                경비 시작
            </button>
            <button class="btn-ctrl btn-stop" id="btnStop" onclick="securityAction('stop')">
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none">
                    <circle cx="9" cy="9" r="7.5" stroke="white" stroke-width="1.5"/>
                    <rect x="6" y="6" width="6" height="6" rx="1" fill="white"/>
                </svg>
                경비 종료
            </button>
        </div>
        <div class="ctrl-feedback" id="ctrlFeedback"></div>

        <div class="divider"></div>

        <!-- 상태 모니터 -->
        <div class="section-title">상태 모니터링</div>
        <div class="monitor-grid" id="monitorGrid">
            <!-- JS로 카드 생성 -->
        </div>

        <!-- 폴링 인디케이터 -->
        <div class="poll-bar">
            <div class="poll-dot"></div>
            <span id="pollStatus">실시간 갱신 중…</span>
        </div>

        <!-- 돌아가기 -->
        <a href="<%=request.getContextPath()%>/ez_in_out/pin" class="btn-back" style="margin-top:20px;">
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <path d="M10 3L5 8L10 13" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            PIN 화면으로 돌아가기
        </a>

    </div>

    <footer class="footer">&copy; 2026 EZ Automation. All rights reserved.</footer>

</div>

<!-- 냉난방 경고 모달 -->
<div class="modal-overlay" id="hvacModal" style="display:none;">
    <div class="modal-box">
        <div class="modal-icon">
            <svg width="28" height="28" viewBox="0 0 28 28" fill="none">
                <path d="M14 4L25 23H3L14 4Z" stroke="white" stroke-width="2" stroke-linejoin="round"/>
                <path d="M14 12V17" stroke="white" stroke-width="2" stroke-linecap="round"/>
                <circle cx="14" cy="20.5" r="1.2" fill="white"/>
            </svg>
        </div>
        <h3>냉난방 가동 중</h3>
        <p>PLC 조건에 의하여 냉난방 전부 OFF여야<br>경비 시작이 가능합니다.</p>
        <div class="modal-hvac-list" id="hvacOnList"></div>
        <div class="modal-btns" style="grid-template-columns: 1fr;">
            <button class="modal-btn-cancel" onclick="closeHvacModal()">확인</button>
        </div>
    </div>
</div>

<script>
    var ctx = '<%=request.getContextPath()%>';

    // D500 순서대로 맵핑 (prev: 이전 상태 추적)
    var SENSORS = [
        { name: '냉난방-공장입구', addr: 500, offText: 'OFF',  onText: 'ON',   prev: null },
        { name: '냉난방-공장내부', addr: 501, offText: 'OFF',  onText: 'ON',   prev: null },
        { name: '냉난방-접견실',   addr: 502, offText: 'OFF',  onText: 'ON',   prev: null },
        { name: '냉난방-회의실',   addr: 503, offText: 'OFF',  onText: 'ON',   prev: null },
        { name: '냉난방-2층',      addr: 504, offText: 'OFF',  onText: 'ON',   prev: null },
        { name: '냉난방-3층',      addr: 505, offText: 'OFF',  onText: 'ON',   prev: null },
        { name: '후문(공장)',       addr: 506, offText: '닫힘', onText: '열림', prev: null },
        { name: '정문',             addr: 507, offText: '닫힘', onText: '열림', prev: null }
    ];

    var pollTimer = null;
    var POLL_MS   = 3000;

    // ── 카드 초기 렌더링 ──────────────────────────────
    (function buildGrid() {
        var grid = document.getElementById('monitorGrid');
        SENSORS.forEach(function(s, i) {
            var card = document.createElement('div');
            card.className = 'monitor-card';
            card.innerHTML =
                '<div class="card-label">' +
                '  <div>' + s.name + '</div>' +
                '  <div style="font-size:10px;font-weight:500;color:var(--text-muted);margin-top:2px;">D' + s.addr + '</div>' +
                '</div>' +
                '<div class="card-body">' +
                '  <div class="status-circle" id="circle-' + i + '">' + s.offText + '</div>' +
                '</div>';
            grid.appendChild(card);
        });
    })();

    // ── 폴링 ─────────────────────────────────────────
    function pollStatus() {
        fetch(ctx + '/ez_in_out/security-monitor/status')
            .then(function(r) { return r.json(); })
            .then(function(data) {
                if (!data.success || !data.sensors) return;
                data.sensors.forEach(function(sensor, i) {
                    var circle = document.getElementById('circle-' + i);
                    if (!circle) return;
                    var s = SENSORS[i];

                    // 상태 변경 감지 → 애니메이션
                    var changed = (s.prev !== null && s.prev !== sensor.on);
                    s.prev = sensor.on;

                    circle.className = sensor.on ? 'status-circle on' : 'status-circle';
                    circle.textContent = sensor.on ? s.onText : s.offText;

                    if (changed) {
                        circle.classList.add('flip');
                        var el = circle;
                        setTimeout(function() { el.classList.remove('flip'); }, 400);
                    }
                });
                document.getElementById('pollStatus').textContent =
                    '실시간 갱신 중… ' + new Date().toLocaleTimeString('ko-KR');
            })
            .catch(function() {
                document.getElementById('pollStatus').textContent = '통신 오류 — 재시도 중';
            });
    }

    pollStatus();
    pollTimer = setInterval(pollStatus, POLL_MS);

    // ── 경비 시작 / 종료 ──────────────────────────────
    function securityAction(type) {
        var url     = ctx + '/ez_in_out/security-monitor/' + type;
        var btnId   = type === 'start' ? 'btnStart' : 'btnStop';
        var btn     = document.getElementById(btnId);
        var fb      = document.getElementById('ctrlFeedback');
        var label   = type === 'start' ? '경비 시작' : '경비 종료';

        btn.disabled = true;
        fb.className = 'ctrl-feedback';
        fb.textContent = label + ' 신호 전송 중…';

        fetch(url, { method: 'POST', headers: { 'Content-Type': 'application/json' } })
            .then(function(r) { return r.json(); })
            .then(function(data) {
                if (data.success) {
                    fb.className = 'ctrl-feedback ok';
                    fb.textContent = '✓ ' + label + ' 신호가 전송되었습니다.';
                    if (navigator.vibrate) navigator.vibrate(40);
                } else {
                    fb.className = 'ctrl-feedback err';
                    fb.textContent = '✗ PLC 오류: ' + (data.plc || '통신 실패');
                }
            })
            .catch(function() {
                fb.className = 'ctrl-feedback err';
                fb.textContent = '✗ 서버 통신 오류';
            })
            .finally(function() {
                setTimeout(function() { btn.disabled = false; }, 2000);
                setTimeout(function() {
                    fb.className = 'ctrl-feedback';
                    fb.textContent = '';
                }, 5000);
            });
    }

    // ── 경비 시작 전 냉난방 체크 ─────────────────────
    function checkAndStart() {
        var onList = SENSORS.slice(0, 6).filter(function(s) { return s.prev === true; });

        if (onList.length === 0) {
            securityAction('start');
            return;
        }

        var listHtml = onList.map(function(s) { return '· ' + s.name; }).join('<br>');
        document.getElementById('hvacOnList').innerHTML = listHtml;
        document.getElementById('hvacModal').style.display = 'flex';
    }

    function closeHvacModal() {
        document.getElementById('hvacModal').style.display = 'none';
    }

    // 물리 키보드: Escape → 모달 닫기 or 뒤로
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            var modal = document.getElementById('hvacModal');
            if (modal.style.display !== 'none') {
                closeHvacModal();
            } else {
                history.back();
            }
        }
    });
</script>

</body>
</html>
