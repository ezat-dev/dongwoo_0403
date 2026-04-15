package com.sample_pro.domain;

public class EzInOutCardMaster {

    private int    id;
    private String cardCode;
    private String empName;
    private String useYn;
    private String remark;
    private String createdAt;
    private String updatedAt;

    public int    getId()          { return id; }
    public void   setId(int id)    { this.id = id; }

    public String getCardCode()              { return cardCode; }
    public void   setCardCode(String v)      { this.cardCode = v; }

    public String getEmpName()               { return empName; }
    public void   setEmpName(String v)       { this.empName = v; }

    public String getUseYn()                 { return useYn; }
    public void   setUseYn(String v)         { this.useYn = v; }

    public String getRemark()                { return remark; }
    public void   setRemark(String v)        { this.remark = v; }

    public String getCreatedAt()             { return createdAt; }
    public void   setCreatedAt(String v)     { this.createdAt = v; }

    public String getUpdatedAt()             { return updatedAt; }
    public void   setUpdatedAt(String v)     { this.updatedAt = v; }
}
