package com.sample_pro.domain;

public class StockHistory {
    private int    id;
    private String partNo;
    private String partName;   // JOIN용
    private String category;   // JOIN용
    private String type;       // IN / OUT
    private int    qty;
    private String equipment;
    private String workDesc;
    private String userName;
    private String createdAt;

    public int    getId()             { return id; }
    public void   setId(int v)        { id = v; }
    public String getPartNo()         { return partNo; }
    public void   setPartNo(String v) { partNo = v; }
    public String getPartName()       { return partName; }
    public void   setPartName(String v){ partName = v; }
    public String getCategory()       { return category; }
    public void   setCategory(String v){ category = v; }
    public String getType()           { return type; }
    public void   setType(String v)   { type = v; }
    public int    getQty()            { return qty; }
    public void   setQty(int v)       { qty = v; }
    public String getEquipment()      { return equipment; }
    public void   setEquipment(String v){ equipment = v; }
    public String getWorkDesc()       { return workDesc; }
    public void   setWorkDesc(String v){ workDesc = v; }
    public String getUserName()       { return userName; }
    public void   setUserName(String v){ userName = v; }
    public String getCreatedAt()      { return createdAt; }
    public void   setCreatedAt(String v){ createdAt = v; }
}
