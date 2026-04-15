package com.sample_pro.domain;

public class Parts {
    private String partNo;
    private String partName;
    private String category;
    private String equipment;
    private String unit;
    private int    minStock;
    private int    replaceCycle;
    private String createdAt;

    // 조회 시 계산 필드 (tb_stock_history JOIN)
    private int    totalIn;
    private int    totalOut;
    private int    currentStock;
    private String stockStatus;

    public String getPartNo()           { return partNo; }
    public void   setPartNo(String v)   { partNo = v; }
    public String getPartName()         { return partName; }
    public void   setPartName(String v) { partName = v; }
    public String getCategory()         { return category; }
    public void   setCategory(String v) { category = v; }
    public String getEquipment()        { return equipment; }
    public void   setEquipment(String v){ equipment = v; }
    public String getUnit()             { return unit; }
    public void   setUnit(String v)     { unit = v; }
    public int    getMinStock()         { return minStock; }
    public void   setMinStock(int v)    { minStock = v; }
    public int    getReplaceCycle()     { return replaceCycle; }
    public void   setReplaceCycle(int v){ replaceCycle = v; }
    public String getCreatedAt()        { return createdAt; }
    public void   setCreatedAt(String v){ createdAt = v; }

    public int    getTotalIn()           { return totalIn; }
    public void   setTotalIn(int v)      { totalIn = v; }
    public int    getTotalOut()          { return totalOut; }
    public void   setTotalOut(int v)     { totalOut = v; }
    public int    getCurrentStock()      { return currentStock; }
    public void   setCurrentStock(int v) { currentStock = v; }
    public String getStockStatus()       { return stockStatus; }
    public void   setStockStatus(String v){ stockStatus = v; }
}
