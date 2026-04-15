package com.sample_pro.domain;

public class InspectResult {
    private int    resultId;
    private String equipId;
    private String inspectYm;
    private int    inspectDay;
    private int    itemId;
    private String result;   // Y / N / -

    public int    getResultId()   { return resultId; }
    public String getEquipId()    { return equipId; }
    public String getInspectYm()  { return inspectYm; }
    public int    getInspectDay() { return inspectDay; }
    public int    getItemId()     { return itemId; }
    public String getResult()     { return result; }

    public void setResultId(int v)      { this.resultId = v; }
    public void setEquipId(String v)    { this.equipId = v; }
    public void setInspectYm(String v)  { this.inspectYm = v; }
    public void setInspectDay(int v)    { this.inspectDay = v; }
    public void setItemId(int v)        { this.itemId = v; }
    public void setResult(String v)     { this.result = v; }
}
