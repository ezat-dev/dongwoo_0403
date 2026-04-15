package com.sample_pro.domain;

public class InspectHeader {
    private int    headerId;
    private String equipId;
    private String inspectYm;
    private String inspectorName;
    private String confirmerName;
    private String status;

    public int    getHeaderId()       { return headerId; }
    public String getEquipId()        { return equipId; }
    public String getInspectYm()      { return inspectYm; }
    public String getInspectorName()  { return inspectorName; }
    public String getConfirmerName()  { return confirmerName; }
    public String getStatus()         { return status; }

    public void setHeaderId(int v)           { this.headerId = v; }
    public void setEquipId(String v)         { this.equipId = v; }
    public void setInspectYm(String v)       { this.inspectYm = v; }
    public void setInspectorName(String v)   { this.inspectorName = v; }
    public void setConfirmerName(String v)   { this.confirmerName = v; }
    public void setStatus(String v)          { this.status = v; }
}
