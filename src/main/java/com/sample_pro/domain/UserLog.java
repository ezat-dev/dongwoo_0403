package com.sample_pro.domain;

import java.sql.Timestamp;

public class UserLog {

    private Integer id;
    private String pageCode;
    private Integer userCode;
    private String fileName;
    private String workDesc;
    private String workUrl;
    private Timestamp startDay;

 
    public String getPageCode() {
		return pageCode;
	}


	public void setPageCode(String pageCode) {
		this.pageCode = pageCode;
	}


	public UserLog() {
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

   




	public Integer getUserCode() {
		return userCode;
	}


	public void setUserCode(Integer userCode) {
		this.userCode = userCode;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getWorkDesc() {
        return workDesc;
    }

    public void setWorkDesc(String workDesc) {
        this.workDesc = workDesc;
    }

    public String getWorkUrl() {
        return workUrl;
    }

    public void setWorkUrl(String workUrl) {
        this.workUrl = workUrl;
    }

    public Timestamp getStartDay() {
        return startDay;
    }

    public void setStartDay(Timestamp startDay) {
        this.startDay = startDay;
    }
}
