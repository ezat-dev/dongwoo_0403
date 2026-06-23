package com.sample_pro.domain;

public final class SecurityMonitorAddress {

    private SecurityMonitorAddress() {}

    // 경비 제어 (D499: 1=시작, 0=종료)
    public static final int D_SECURITY         = 499;
    public static final int D_SECURITY_ON      = 1;
    public static final int D_SECURITY_OFF     = 0;

    // 상태 모니터 센서 (D500 순서대로, 읽기 전용)
    public static final int[]    SENSOR_ADDRESSES = { 500, 501, 502, 503, 504, 505, 506 };
    public static final String[] SENSOR_NAMES     = {
        "냉난방-공장입구",
        "냉난방-공장내부",
        "냉난방-접견실",
        "냉난방-회의실",
        "냉난방-2층",
        "냉난방-3층",
        "후문(공장)"
    };

    public static final int SENSOR_COUNT       = SENSOR_ADDRESSES.length;
    public static final int READ_START_ADDRESS = D_SECURITY;                 // 499
    public static final int READ_TOTAL_COUNT   = 1 + SENSOR_COUNT;          // D499~D506 = 8
}
