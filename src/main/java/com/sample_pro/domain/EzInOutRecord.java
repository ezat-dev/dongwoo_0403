package com.sample_pro.domain;

public class EzInOutRecord {

    private int    id;
    private int    inOutGubun;   // 1=출근, 2=외근, 3=퇴근
    private String inOutName;    // 출근 / 외근 / 퇴근
    private int    plcD45Value;
    private int    plcD46Value;
    private String d61Value;
    private String d62Value;
    private String d63Value;
    private String d64Value;
    private String cardCode;
    private String empName;
    private String regDate;
    private String saveYn;
    private String remark;
    private String createdAt;
    private String updatedAt;

    public int    getId()                  { return id; }
    public void   setId(int v)             { this.id = v; }

    public int    getInOutGubun()          { return inOutGubun; }
    public void   setInOutGubun(int v)     { this.inOutGubun = v; }

    public String getInOutName()           { return inOutName; }
    public void   setInOutName(String v)   { this.inOutName = v; }

    public int    getPlcD45Value()         { return plcD45Value; }
    public void   setPlcD45Value(int v)    { this.plcD45Value = v; }

    public int    getPlcD46Value()         { return plcD46Value; }
    public void   setPlcD46Value(int v)    { this.plcD46Value = v; }

    public String getD61Value()            { return d61Value; }
    public void   setD61Value(String v)    { this.d61Value = v; }

    public String getD62Value()            { return d62Value; }
    public void   setD62Value(String v)    { this.d62Value = v; }

    public String getD63Value()            { return d63Value; }
    public void   setD63Value(String v)    { this.d63Value = v; }

    public String getD64Value()            { return d64Value; }
    public void   setD64Value(String v)    { this.d64Value = v; }

    public String getCardCode()            { return cardCode; }
    public void   setCardCode(String v)    { this.cardCode = v; }

    public String getEmpName()             { return empName; }
    public void   setEmpName(String v)     { this.empName = v; }

    public String getRegDate()             { return regDate; }
    public void   setRegDate(String v)     { this.regDate = v; }

    public String getSaveYn()              { return saveYn; }
    public void   setSaveYn(String v)      { this.saveYn = v; }

    public String getRemark()              { return remark; }
    public void   setRemark(String v)      { this.remark = v; }

    public String getCreatedAt()           { return createdAt; }
    public void   setCreatedAt(String v)   { this.createdAt = v; }

    public String getUpdatedAt()           { return updatedAt; }
    public void   setUpdatedAt(String v)   { this.updatedAt = v; }
}
