package com.sample_pro.domain;

public class CalibThermocouple {
    private int    calibId;
    private String equipType;
    private String equipName;
    private String zoneLocation;
    private String measLocation;
    private String attachFile;
    private String lastCalibDt;
    private String nextCalibDt;
    private Double stdTemp;
    private Double measTemp;
    private Double deviation;
    private String judgment;
    private String status;
    private String handler;
    private String remark;
    private String regDt;
    private String updDt;
    private String delYn;

    public int    getCalibId()      { return calibId; }
    public void   setCalibId(int v) { calibId = v; }

    public String getEquipType()         { return equipType; }
    public void   setEquipType(String v) { equipType = v; }

    public String getEquipName()         { return equipName; }
    public void   setEquipName(String v) { equipName = v; }

    public String getZoneLocation()         { return zoneLocation; }
    public void   setZoneLocation(String v) { zoneLocation = v; }

    public String getMeasLocation()         { return measLocation; }
    public void   setMeasLocation(String v) { measLocation = v; }

    public String getAttachFile()         { return attachFile; }
    public void   setAttachFile(String v) { attachFile = v; }

    public String getLastCalibDt()         { return lastCalibDt; }
    public void   setLastCalibDt(String v) { lastCalibDt = v; }

    public String getNextCalibDt()         { return nextCalibDt; }
    public void   setNextCalibDt(String v) { nextCalibDt = v; }

    public Double getStdTemp()         { return stdTemp; }
    public void   setStdTemp(Double v) { stdTemp = v; }

    public Double getMeasTemp()         { return measTemp; }
    public void   setMeasTemp(Double v) { measTemp = v; }

    public Double getDeviation()         { return deviation; }
    public void   setDeviation(Double v) { deviation = v; }

    public String getJudgment()         { return judgment; }
    public void   setJudgment(String v) { judgment = v; }

    public String getStatus()         { return status; }
    public void   setStatus(String v) { status = v; }

    public String getHandler()         { return handler; }
    public void   setHandler(String v) { handler = v; }

    public String getRemark()         { return remark; }
    public void   setRemark(String v) { remark = v; }

    public String getRegDt()         { return regDt; }
    public void   setRegDt(String v) { regDt = v; }

    public String getUpdDt()         { return updDt; }
    public void   setUpdDt(String v) { updDt = v; }

    public String getDelYn()         { return delYn; }
    public void   setDelYn(String v) { delYn = v; }
}
