package com.sample_pro.domain;

public class Tag {

    private int    id;
    private int    folderId;
    private String name;
    private String address;
    private String type;
    private String plcType;    // LS | MITSUBISHI
    private String value;
    private String quality;
    private String timestamp;

    public int    getId()        { return id; }
    public int    getFolderId()  { return folderId; }
    public String getName()      { return name; }
    public String getAddress()   { return address; }
    public String getType()      { return type; }
    public String getPlcType()   { return plcType; }
    public String getValue()     { return value; }
    public String getQuality()   { return quality; }
    public String getTimestamp() { return timestamp; }

    public void setId(int id)               { this.id = id; }
    public void setFolderId(int folderId)   { this.folderId = folderId; }
    public void setName(String name)        { this.name = name; }
    public void setAddress(String address)  { this.address = address; }
    public void setType(String type)        { this.type = type; }
    public void setPlcType(String plcType)  { this.plcType = plcType; }
    public void setValue(String value)      { this.value = value; }
    public void setQuality(String quality)  { this.quality = quality; }
    public void setTimestamp(String ts)     { this.timestamp = ts; }
}