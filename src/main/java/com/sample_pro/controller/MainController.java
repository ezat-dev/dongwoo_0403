package com.sample_pro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/main_1")
public class MainController {

    @RequestMapping(value = "/main",           method = RequestMethod.GET) public String main()          { return "/main_1/main.jsp"; }
    @RequestMapping(value = "/login",          method = RequestMethod.GET) public String login()         { return "/main_1/login.jsp"; }

    // 설비
    @RequestMapping(value = "/equip/monitor",  method = RequestMethod.GET) public String equipMonitor()  { return "/main_1/equip_monitor.jsp"; }
    @RequestMapping(value = "/equip/detail",   method = RequestMethod.GET) public String equipDetail()   { return "/main_1/equip_detail.jsp"; }

    // 알람
    @RequestMapping(value = "/alarm/history",  method = RequestMethod.GET) public String alarmHistory()  { return "/main_1/alarm_history.jsp"; }
    @RequestMapping(value = "/alarm/ranking",  method = RequestMethod.GET) public String alarmRanking()  { return "/main_1/alarm_ranking.jsp"; }

    // 트렌드
    @RequestMapping(value = "/trend",          method = RequestMethod.GET) public String trend()         { return "/main_1/trend.jsp"; }

    // 보정현황
    @RequestMapping(value = "/calib/status",   method = RequestMethod.GET) public String calibStatus()   { return "/main_1/calib_status.jsp"; }

    // 점검
    @RequestMapping(value = "/inspect/daily",  method = RequestMethod.GET) public String inspectDaily()  { return "/main_1/daily_inspect.jsp"; }
    @RequestMapping(value = "/inspect/fproof", method = RequestMethod.GET) public String inspectFproof() { return "/main_1/fproof.jsp"; }

    // 자재
    @RequestMapping(value = "/spare/parts",    method = RequestMethod.GET) public String spareParts()    { return "/main_1/spare_parts.jsp"; }

    // 시스템
    @RequestMapping(value = "/user/manage",    method = RequestMethod.GET) public String userManage()    { return "/main_1/user_manage.jsp"; }
    @RequestMapping(value = "/user/permission",method = RequestMethod.GET) public String userPermission(){ return "/main_1/user_permission.jsp"; }
}
