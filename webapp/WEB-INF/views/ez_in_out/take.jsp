<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="theme-color" content="#0D1B3E">
    <title>EZ Automation - 방문자 안내</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary:      #C8102E;
            --primary-dark: #9E0B24;
            --primary-pale: #FFF0F3;
            --navy:         #0D1B3E;
            --navy-mid:     #1A2F5A;
            --navy-light:   #2A4480;
            --accent:       #4A90D9;
            --green:        #16A34A;
            --green-light:  #22C55E;
            --bg:           #F4F6FB;
            --white:        #FFFFFF;
            --text-main:    #1A1D2E;
            --text-sub:     #5A6380;
            --text-muted:   #9AA3BE;
            --border:       #D8DDED;
            --shadow-lg:    0 20px 60px rgba(13,27,62,0.18);
            --radius-sm:    10px;
            --radius-md:    18px;
            --radius-lg:    28px;
            --transition:   0.28s cubic-bezier(0.4, 0, 0.2, 1);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; -webkit-tap-highlight-color: transparent; }
        html { scroll-behavior: smooth; }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: var(--bg);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            overflow-x: hidden;
        }

        /* 배경 그라디언트 */
        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 320px;
            background: linear-gradient(145deg, var(--navy) 0%, var(--navy-mid) 55%, var(--navy-light) 100%);
            z-index: 0;
            clip-path: ellipse(120% 100% at 50% 0%);
        }

        body::after {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 320px;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.025'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            z-index: 0;
            clip-path: ellipse(120% 100% at 50% 0%);
        }

        .page-wrapper {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 480px;
            padding: 32px 16px 56px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* ── 헤더 ─────────────────────────────────── */
        .header {
            width: 100%;
            text-align: center;
            padding: 12px 0 28px;
            color: var(--white);
        }

        .logo-wrap {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
        }

        .logo-box {
            width: 68px; height: 68px;
            background: var(--white);
            border-radius: 18px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 6px 24px rgba(0,0,0,0.22);
            padding: 8px;
        }

        .header-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(200,16,46,0.22);
            border: 1px solid rgba(200,16,46,0.45);
            border-radius: 100px;
            padding: 5px 14px;
            font-size: 11px;
            font-weight: 600;
            color: rgba(255,255,255,0.92);
            letter-spacing: 0.06em;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .header h1 {
            font-size: 22px;
            font-weight: 700;
            color: var(--white);
            letter-spacing: -0.02em;
            margin-bottom: 5px;
        }

        .header p {
            font-size: 13px;
            color: rgba(255,255,255,0.6);
        }

        /* ── 카드 공통 ────────────────────────────── */
        .card {
            width: 100%;
            background: var(--white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            animation: cardRise 0.5s cubic-bezier(0.22,1,0.36,1) both;
        }

        @keyframes cardRise {
            from { opacity: 0; transform: translateY(24px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ── 방문자 정보 카드 ────────────────────── */
        .visitor-card {
            margin-bottom: 14px;
        }

        /* 카드 상단 컬러 바 */
        .card-topbar {
            height: 6px;
            background: linear-gradient(90deg, var(--primary-dark), var(--primary), #FF6B6B);
        }

        .card-body {
            padding: 24px 24px 28px;
        }

        /* 방문자 아이콘 + 이름 */
        .visitor-hero {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 22px;
            padding-bottom: 20px;
            border-bottom: 1.5px solid var(--border);
        }

        .visitor-avatar {
            width: 58px; height: 58px;
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
            box-shadow: 0 6px 18px rgba(200,16,46,0.3);
        }

        .visitor-meta { flex: 1; min-width: 0; }

        .visitor-name {
            font-size: 20px;
            font-weight: 800;
            color: var(--navy);
            letter-spacing: -0.02em;
            margin-bottom: 3px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .visitor-phone {
            font-family: 'DM Mono', monospace;
            font-size: 13px;
            color: var(--text-sub);
            font-weight: 400;
        }

        /* 정보 행 */
        .info-grid {
            display: flex;
            flex-direction: column;
            gap: 0;
        }

        .info-row {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #F0F2FA;
        }

        .info-row:last-child { border-bottom: none; }

        .info-icon {
            width: 34px; height: 34px;
            background: linear-gradient(135deg, var(--navy-mid), var(--navy-light));
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }

        .info-icon.green { background: linear-gradient(135deg, #15803D, var(--green-light)); }
        .info-icon.blue  { background: linear-gradient(135deg, #1D4ED8, var(--accent)); }

        .info-label {
            font-size: 11px;
            color: var(--text-muted);
            font-weight: 600;
            letter-spacing: 0.04em;
            text-transform: uppercase;
            margin-bottom: 2px;
        }

        .info-value {
            font-size: 14.5px;
            font-weight: 600;
            color: var(--text-main);
            line-height: 1.35;
        }

        .info-content { flex: 1; min-width: 0; }

        /* 시간 배지 */
        .time-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: linear-gradient(135deg, #EFF6FF, #DBEAFE);
            border: 1px solid rgba(74,144,217,0.3);
            border-radius: 100px;
            padding: 4px 10px;
            font-family: 'DM Mono', monospace;
            font-size: 11.5px;
            font-weight: 500;
            color: var(--accent);
        }

        /* ── 문열림 버튼 카드 ────────────────────── */
        .door-card {
            animation: cardRise 0.5s 0.08s cubic-bezier(0.22,1,0.36,1) both;
        }

        .door-card .card-body {
            padding: 26px 24px 28px;
        }

        .door-section-title {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-muted);
            letter-spacing: 0.07em;
            text-transform: uppercase;
            margin-bottom: 16px;
        }

        .door-section-title::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--border);
        }

        /* 문열림 버튼 */
        .btn-door {
            width: 100%;
            height: 72px;
            background: linear-gradient(135deg, var(--green) 0%, var(--green-light) 100%);
            color: var(--white);
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 17px;
            font-weight: 800;
            border: none;
            border-radius: var(--radius-md);
            cursor: pointer;
            letter-spacing: 0.01em;
            box-shadow: 0 8px 28px rgba(22,163,74,0.4);
            transition: all var(--transition);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .btn-door::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, #14532D, var(--green));
            opacity: 0;
            transition: opacity var(--transition);
        }

        .btn-door:hover:not(:disabled)::before { opacity: 1; }
        .btn-door:active:not(:disabled) {
            transform: scale(0.97);
            box-shadow: 0 4px 14px rgba(22,163,74,0.3);
        }

        .btn-door span, .btn-door svg { position: relative; z-index: 1; }

        .btn-door:disabled {
            background: linear-gradient(135deg, #BBF7D0, #D1FAE5);
            color: rgba(22,163,74,0.5);
            cursor: not-allowed;
            box-shadow: none;
        }

        /* 펄스 링 애니메이션 (대기 중) */
        .btn-door.pulse-ring::after {
            content: '';
            position: absolute;
            inset: -3px;
            border-radius: calc(var(--radius-md) + 3px);
            border: 2px solid var(--green-light);
            animation: pulseRing 1.6s ease-out infinite;
        }

        @keyframes pulseRing {
            0%   { transform: scale(1);   opacity: 0.8; }
            100% { transform: scale(1.04); opacity: 0; }
        }

        /* 결과 메시지 */
        .door-result {
            display: none;
            margin-top: 14px;
            padding: 14px 18px;
            border-radius: var(--radius-sm);
            font-size: 13.5px;
            font-weight: 600;
            display: none;
            align-items: center;
            gap: 10px;
        }

        .door-result.show { display: flex; animation: fadeIn 0.3s ease; }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(4px); } to { opacity: 1; transform: translateY(0); } }

        .door-result.success {
            background: linear-gradient(135deg, #F0FDF4, #DCFCE7);
            border: 1.5px solid rgba(22,163,74,0.3);
            color: var(--green);
        }

        .door-result.error {
            background: linear-gradient(135deg, #FFF0F3, #FFE4E8);
            border: 1.5px solid rgba(200,16,46,0.25);
            color: var(--primary-dark);
        }

        .result-icon {
            width: 28px; height: 28px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }

        .door-result.success .result-icon { background: rgba(22,163,74,0.15); }
        .door-result.error   .result-icon { background: rgba(200,16,46,0.12); }

        /* 주의 안내 */
        .door-notice {
            margin-top: 12px;
            display: flex;
            align-items: flex-start;
            gap: 7px;
            font-size: 11.5px;
            color: var(--text-muted);
            line-height: 1.6;
        }

        .door-notice svg { flex-shrink: 0; margin-top: 1px; }

        /* ── 로딩 스켈레톤 ───────────────────────── */
        .skeleton {
            display: none;
            padding: 24px;
        }

        .skeleton.show { display: block; }

        .skel-line {
            height: 14px;
            background: linear-gradient(90deg, #EEF1FB 25%, #F8F9FD 50%, #EEF1FB 75%);
            background-size: 200% 100%;
            animation: shimmer 1.4s infinite;
            border-radius: 8px;
            margin-bottom: 12px;
        }

        .skel-line.wide  { width: 75%; }
        .skel-line.mid   { width: 55%; }
        .skel-line.short { width: 40%; }

        @keyframes shimmer {
            0%   { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }

        /* ── 에러 상태 ───────────────────────────── */
        .error-state {
            display: none;
            text-align: center;
            padding: 36px 24px;
        }

        .error-state.show { display: block; }

        .error-icon-wrap {
            width: 64px; height: 64px;
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 16px;
            box-shadow: 0 6px 20px rgba(200,16,46,0.3);
        }

        .error-state h3 { font-size: 17px; font-weight: 700; color: var(--navy); margin-bottom: 8px; }
        .error-state p  { font-size: 13px; color: var(--text-sub); line-height: 1.6; }

        /* ── 푸터 ────────────────────────────────── */
        .footer {
            margin-top: 28px;
            text-align: center;
            color: rgba(255,255,255,0.38);
            font-size: 11px;
            letter-spacing: 0.02em;
        }

        @media (min-width: 520px) {
            .page-wrapper { padding: 40px 24px 60px; }
            .card-body { padding: 28px 32px 32px; }
        }
    </style>
</head>
<body>

<div class="page-wrapper">

    <!-- 헤더 -->
    <header class="header">
        <div class="logo-wrap">
            <div class="logo-box">
                <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" style="width:100%;height:100%">
                    <rect x="18" y="28" width="52" height="55" fill="#C8102E" rx="2"/>
                    <polygon points="70,55 70,83 42,83" fill="white" opacity="0.18"/>
                    <text x="28" y="74" font-family="Georgia,serif" font-style="italic" font-size="44" fill="white" opacity="0.92">E</text>
                    <polygon points="65,38 85,45 65,52" fill="#C8102E"/>
                </svg>
            </div>
        </div>
        <div class="header-badge">
            <svg width="9" height="11" viewBox="0 0 9 11" fill="none">
                <path d="M1 5.5C1 3.01 2.79 1 5 1C7.21 1 9 3.01 9 5.5" stroke="white" stroke-width="1.2" stroke-linecap="round"/>
                <rect x="0.5" y="5" width="9" height="5.5" rx="1.5" stroke="white" stroke-width="1.2"/>
                <circle cx="5" cy="7.8" r="0.8" fill="white"/>
            </svg>
            방문자 알림
        </div>
        <h1>방문자가 도착했습니다</h1>
        <p>방문 정보를 확인하고 문을 열어주세요</p>
    </header>

    <!-- 로딩 스켈레톤 -->
    <div class="card visitor-card" id="skeletonCard">
        <div class="card-topbar"></div>
        <div class="skeleton show">
            <div class="skel-line wide"></div>
            <div class="skel-line mid"></div>
            <div class="skel-line short"></div>
            <div class="skel-line wide" style="margin-top:8px"></div>
            <div class="skel-line mid"></div>
        </div>
    </div>

    <!-- 방문자 정보 카드 (JS로 채움) -->
    <div class="card visitor-card" id="visitorCard" style="display:none;">
        <div class="card-topbar"></div>
        <div class="card-body">

            <!-- 방문자 히어로 -->
            <div class="visitor-hero">
                <div class="visitor-avatar">
                    <svg width="26" height="26" viewBox="0 0 26 26" fill="none">
                        <circle cx="13" cy="9" r="4.5" stroke="white" stroke-width="1.8"/>
                        <path d="M3.5 23C3.5 18.86 7.86 15.5 13 15.5C18.14 15.5 22.5 18.86 22.5 23" stroke="white" stroke-width="1.8" stroke-linecap="round"/>
                    </svg>
                </div>
                <div class="visitor-meta">
                    <div class="visitor-name" id="displayName">—</div>
                    <div class="visitor-phone" id="displayPhone">—</div>
                </div>
                <div class="time-badge" id="displayTime">
                    <svg width="11" height="11" viewBox="0 0 11 11" fill="none">
                        <circle cx="5.5" cy="5.5" r="4.5" stroke="currentColor" stroke-width="1.2"/>
                        <path d="M5.5 3V5.5L7 7" stroke="currentColor" stroke-width="1.2" stroke-linecap="round"/>
                    </svg>
                    <span id="displayTimeText">—</span>
                </div>
            </div>

            <!-- 정보 그리드 -->
            <div class="info-grid">
                <div class="info-row">
                    <div class="info-icon blue">
                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                            <path d="M2 13C2 10.24 4.69 8 8 8C11.31 8 14 10.24 14 13" stroke="white" stroke-width="1.4" stroke-linecap="round"/>
                            <circle cx="8" cy="5" r="2.5" stroke="white" stroke-width="1.4"/>
                            <path d="M10.5 2.5L13.5 1" stroke="white" stroke-width="1.2" stroke-linecap="round"/>
                            <circle cx="13.5" cy="1" r="1" fill="white"/>
                        </svg>
                    </div>
                    <div class="info-content">
                        <div class="info-label">담당 직원</div>
                        <div class="info-value" id="displayTarget">—</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-icon green">
                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                            <path d="M2.5 4H13.5" stroke="white" stroke-width="1.4" stroke-linecap="round"/>
                            <path d="M2.5 8H13.5" stroke="white" stroke-width="1.4" stroke-linecap="round"/>
                            <path d="M2.5 12H9" stroke="white" stroke-width="1.4" stroke-linecap="round"/>
                        </svg>
                    </div>
                    <div class="info-content">
                        <div class="info-label">방문 사유</div>
                        <div class="info-value" id="displayReason">—</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-icon">
                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                            <rect x="2" y="1" width="12" height="14" rx="2" stroke="white" stroke-width="1.4"/>
                            <path d="M5 5H11M5 8H11M5 11H8" stroke="white" stroke-width="1.3" stroke-linecap="round"/>
                        </svg>
                    </div>
                    <div class="info-content">
                        <div class="info-label">등록 번호</div>
                        <div class="info-value" id="displayId" style="font-family:'DM Mono',monospace; font-size:13px;">—</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 에러 상태 -->
    <div class="card visitor-card" id="errorCard" style="display:none;">
        <div class="card-topbar" style="background: linear-gradient(90deg, var(--primary-dark), var(--primary));"></div>
        <div class="error-state show">
            <div class="error-icon-wrap">
                <svg width="28" height="28" viewBox="0 0 28 28" fill="none">
                    <circle cx="14" cy="14" r="11" stroke="white" stroke-width="1.8"/>
                    <path d="M14 8V15M14 18.5V19" stroke="white" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </div>
            <h3>방문 정보를 찾을 수 없습니다</h3>
            <p id="errorMsg">유효하지 않은 링크이거나<br>이미 처리된 방문입니다.</p>
        </div>
    </div>

    <!-- 문열림 버튼 카드 -->
    <div class="card door-card" id="doorCard" style="display:none;">
        <div class="card-body">
            <div class="door-section-title">
                <svg width="13" height="13" viewBox="0 0 13 13" fill="none">
                    <rect x="0.8" y="5.5" width="11.5" height="7" rx="1.8" stroke="#9AA3BE" stroke-width="1.3"/>
                    <path d="M3.5 5.5V3.5C3.5 2.12 4.84 1 6.5 1C8.16 1 9.5 2.12 9.5 3.5V5.5" stroke="#9AA3BE" stroke-width="1.3" stroke-linecap="round"/>
                </svg>
                출입 제어
            </div>

            <button class="btn-door pulse-ring" id="btnDoor" onclick="openDoor()">
                <svg width="26" height="26" viewBox="0 0 26 26" fill="none">
                    <rect x="2.5" y="8.5" width="21" height="15" rx="3" stroke="white" stroke-width="2"/>
                    <path d="M8 8.5V5.5C8 3.29 10.24 1.5 13 1.5C15.76 1.5 18 3.29 18 5.5V8.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
                    <circle cx="13" cy="16" r="2.5" fill="white"/>
                    <path d="M13 18.5V21" stroke="white" stroke-width="2" stroke-linecap="round"/>
                </svg>
                <span>문 열기</span>
            </button>

            <!-- 결과 메시지 -->
            <div class="door-result" id="doorResult">
                <div class="result-icon" id="resultIcon"></div>
                <span id="resultText"></span>
            </div>

            <div class="door-notice">
                <svg width="13" height="13" viewBox="0 0 13 13" fill="none">
                    <circle cx="6.5" cy="6.5" r="5.5" stroke="#9AA3BE" stroke-width="1.2"/>
                    <path d="M6.5 5.5V9M6.5 3.8V4" stroke="#9AA3BE" stroke-width="1.3" stroke-linecap="round"/>
                </svg>
                버튼을 누르면 출입문이 열립니다. 방문자 확인 후 눌러주세요.
            </div>
        </div>
    </div>

    <footer class="footer">
        &copy; 2026 EZ Automation. All rights reserved.
    </footer>

</div><!-- /.page-wrapper -->

<script>
    var contextPath = '<%=request.getContextPath()%>';

    // ── URL 파라미터에서 visitId 추출 ─────────────────
    function getParam(name) {
        var params = new URLSearchParams(window.location.search);
        return params.get(name) || '';
    }

    var visitId = getParam('id');

    // ── 초기화 ────────────────────────────────────────
    (function init() {
        if (!visitId) {
            showError('방문 ID가 누락되었습니다.<br>카카오 알림톡 링크를 다시 확인해 주세요.');
            return;
        }
        loadVisitInfo(visitId);
    })();

    // ── 방문 정보 조회 ────────────────────────────────
    function loadVisitInfo(id) {
        fetch(contextPath + '/ez_in_out/take/info?id=' + encodeURIComponent(id), {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
        .then(function(res) {
            if (!res.ok) throw new Error('서버 오류 (' + res.status + ')');
            return res.json();
        })
        .then(function(result) {
            document.getElementById('skeletonCard').style.display = 'none';

            if (!result || !result.success) {
                showError(result && result.error ? result.error : '방문 정보를 불러오지 못했습니다.');
                return;
            }

            renderVisitInfo(result.data);
        })
        .catch(function(e) {
            document.getElementById('skeletonCard').style.display = 'none';
            showError('서버와 통신할 수 없습니다.<br>' + (e.message || ''));
        });
    }

    // ── 방문 정보 렌더링 ──────────────────────────────
    function renderVisitInfo(v) {
        // 방문자 히어로
        document.getElementById('displayName').textContent   = v.visitorName  || '—';
        document.getElementById('displayPhone').textContent  = v.visitorPhone || '—';
        document.getElementById('displayTimeText').textContent = v.visitTime  || '—';

        // 담당 직원
        var parts = [];
        if (v.targetDeptName)  parts.push(v.targetDeptName);
        if (v.targetEmpName)   parts.push(v.targetEmpName);
        if (v.targetTitleName) parts.push(v.targetTitleName);
        document.getElementById('displayTarget').textContent = parts.join(' / ') || '—';

        // 방문 사유
        var reason = v.visitReason || '—';
        if (v.visitReasonEtc) reason += ' - ' + v.visitReasonEtc;
        document.getElementById('displayReason').textContent = reason;

        // 등록 번호
        document.getElementById('displayId').textContent = '#' + (v.visitId || '');

        // 카드 표시
        document.getElementById('visitorCard').style.display = 'block';
        document.getElementById('doorCard').style.display    = 'block';
    }

    // ── 에러 표시 ─────────────────────────────────────
    function showError(msg) {
        document.getElementById('errorMsg').innerHTML = msg;
        document.getElementById('errorCard').style.display = 'block';
        document.getElementById('doorCard').style.display  = 'none';
    }

    // ── 문 열기 (D13001 = 1) ──────────────────────────
    function openDoor() {
        var btn = document.getElementById('btnDoor');
        btn.disabled = true;
        btn.classList.remove('pulse-ring');

        // 버튼 로딩 상태
        btn.innerHTML =
            '<svg width="22" height="22" viewBox="0 0 22 22" fill="none" style="animation:spin 0.9s linear infinite">' +
            '<circle cx="11" cy="11" r="9" stroke="rgba(255,255,255,0.3)" stroke-width="2"/>' +
            '<path d="M11 2A9 9 0 0 1 20 11" stroke="white" stroke-width="2" stroke-linecap="round"/>' +
            '</svg>' +
            '<span>처리 중...</span>';

        fetch(contextPath + '/ez_in_out/take/open-door', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify({ visitId: visitId })
        })
        .then(function(res) {
            if (!res.ok) throw new Error('서버 오류 (' + res.status + ')');
            return res.json();
        })
        .then(function(result) {
            if (result && result.success) {
                showDoorResult(true, '문이 열렸습니다. 방문자를 안내해 주세요.');
                btn.innerHTML =
                    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none">' +
                    '<path d="M5 12L10 17L19 7" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>' +
                    '</svg><span>열림 완료</span>';
                btn.style.background = 'linear-gradient(135deg, #14532D, #15803D)';
                btn.style.boxShadow  = '0 6px 20px rgba(22,163,74,0.25)';
            } else {
                var msg = result && result.error ? result.error : 'PLC 통신 오류가 발생했습니다.';
                showDoorResult(false, msg);
                restoreBtn(btn);
            }
        })
        .catch(function(e) {
            showDoorResult(false, '서버와 통신할 수 없습니다. (' + (e.message || '') + ')');
            restoreBtn(btn);
        });
    }

    function restoreBtn(btn) {
        btn.disabled = false;
        btn.classList.add('pulse-ring');
        btn.innerHTML =
            '<svg width="26" height="26" viewBox="0 0 26 26" fill="none">' +
            '<rect x="2.5" y="8.5" width="21" height="15" rx="3" stroke="white" stroke-width="2"/>' +
            '<path d="M8 8.5V5.5C8 3.29 10.24 1.5 13 1.5C15.76 1.5 18 3.29 18 5.5V8.5" stroke="white" stroke-width="2" stroke-linecap="round"/>' +
            '<circle cx="13" cy="16" r="2.5" fill="white"/>' +
            '<path d="M13 18.5V21" stroke="white" stroke-width="2" stroke-linecap="round"/>' +
            '</svg><span>문 열기</span>';
    }

    function showDoorResult(success, msg) {
        var el   = document.getElementById('doorResult');
        var icon = document.getElementById('resultIcon');
        var text = document.getElementById('resultText');

        el.className = 'door-result show ' + (success ? 'success' : 'error');
        text.textContent = msg;

        icon.innerHTML = success
            ? '<svg width="14" height="14" viewBox="0 0 14 14" fill="none"><path d="M2.5 7L5.5 10L11.5 4" stroke="#16A34A" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>'
            : '<svg width="14" height="14" viewBox="0 0 14 14" fill="none"><path d="M3 3L11 11M11 3L3 11" stroke="#C8102E" stroke-width="2" stroke-linecap="round"/></svg>';
    }

    // 스핀 애니메이션 keyframe 동적 추가
    var style = document.createElement('style');
    style.textContent = '@keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }';
    document.head.appendChild(style);
</script>

</body>
</html>
