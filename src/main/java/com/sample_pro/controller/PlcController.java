package com.sample_pro.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/plc")
public class PlcController {

    private static final String CSHARP = "http://localhost:5050";
    private final RestTemplate rest = new RestTemplate();

    // ── 페이지 ────────────────────────────────────────────
    @RequestMapping(value = "/PlcReadWrite", method = RequestMethod.GET)
    public String page(Model model) {
        return "/monitoring/PlcReadWrite.jsp";
    }

    // ════════════════════════════════════════════════════
    //  기존 엔드포인트 (하위호환 – default PLC)
    // ════════════════════════════════════════════════════

    // ── GET /plc/read?start=&count= ───────────────────────
    @RequestMapping(value = "/read", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> read(
            @RequestParam(value = "start", defaultValue = "10000") int start,
            @RequestParam(value = "count", defaultValue = "100")   int count) {

        if (count < 1)   count = 1;
        if (count > 300) count = 300;

        String url = CSHARP + "/api/plc/read?start=" + start + "&count=" + count;
        System.out.println(">>> [READ] " + url);
        try {
            Map<?, ?> res = rest.getForObject(url, Map.class);
            System.out.println(">>> [READ OK] " + res);
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            System.out.println(">>> [READ ERR] " + e.getMessage());
            return err("C# API 연결 실패: " + e.getMessage());
        }
    }

    // ── POST /plc/write ───────────────────────────────────
    @RequestMapping(value = "/write", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<?> write(@RequestBody Map<String, Integer> body) {
        System.out.println(">>> [WRITE] D" + body.get("address") + " <- " + body.get("value"));
        try {
            Map<?, ?> res = rest.postForObject(CSHARP + "/api/plc/write", body, Map.class);
            System.out.println(">>> [WRITE OK] " + res);
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            System.out.println(">>> [WRITE ERR] " + e.getMessage());
            return err("C# API 연결 실패: " + e.getMessage());
        }
    }

    // ── GET /plc/config ───────────────────────────────────
    @RequestMapping(value = "/config", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> getConfig() {
        try {
            return ResponseEntity.ok(rest.getForObject(CSHARP + "/api/plc/config", Map.class));
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── POST /plc/config ──────────────────────────────────
    @RequestMapping(value = "/config", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<?> setConfig(@RequestBody Map<String, Object> body) {
        System.out.println(">>> [CONFIG] " + body);
        try {
            return ResponseEntity.ok(rest.postForObject(CSHARP + "/api/plc/config", body, Map.class));
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── GET /plc/ping ─────────────────────────────────────
    @RequestMapping(value = "/ping", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> ping() {
        try {
            return ResponseEntity.ok(rest.getForObject(CSHARP + "/api/plc/ping", Map.class));
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ════════════════════════════════════════════════════
    //  신규 – 다중 PLC
    // ════════════════════════════════════════════════════

    // ── GET /plc/list ─────────────────────────────────────
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> list() {
        try {
            return ResponseEntity.ok(rest.getForObject(CSHARP + "/api/plc/list", Object.class));
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── POST /plc/add ─────────────────────────────────────
    // Body: { "id":"plc2", "ip":"192.168.1.10", "port":2004, "plcType":"LS", "label":"2호기" }
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<?> add(@RequestBody Map<String, Object> body) {
        System.out.println(">>> [ADD] " + body);
        try {
            return ResponseEntity.ok(rest.postForObject(CSHARP + "/api/plc/add", body, Map.class));
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── DELETE /plc/remove/{id} ───────────────────────────
    @RequestMapping(value = "/remove/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public ResponseEntity<?> remove(@PathVariable String id) {
        System.out.println(">>> [REMOVE] " + id);
        try {
            rest.delete(CSHARP + "/api/plc/remove/" + id);
            Map<String, Object> r = new HashMap<>();
            r.put("success", true);
            return ResponseEntity.ok(r);
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── GET /plc/read/{id}?start=&count= ──────────────────
    @RequestMapping(value = "/read/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> readById(
            @PathVariable String id,
            @RequestParam(value = "start", defaultValue = "10000") int start,
            @RequestParam(value = "count", defaultValue = "100")   int count) {

        if (count < 1)   count = 1;
        if (count > 300) count = 300;

        String url = CSHARP + "/api/plc/read/" + id + "?start=" + start + "&count=" + count;
        System.out.println(">>> [READ/" + id + "] " + url);
        try {
            Map<?, ?> res = rest.getForObject(url, Map.class);
            return ResponseEntity.ok(res);
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── POST /plc/write/{id} ──────────────────────────────
    @RequestMapping(value = "/write/{id}", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<?> writeById(
            @PathVariable String id,
            @RequestBody Map<String, Integer> body) {
        System.out.println(">>> [WRITE/" + id + "] D" + body.get("address") + " <- " + body.get("value"));
        try {
            return ResponseEntity.ok(rest.postForObject(CSHARP + "/api/plc/write/" + id, body, Map.class));
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── GET /plc/ping/{id} ────────────────────────────────
    @RequestMapping(value = "/ping/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> pingById(@PathVariable String id) {
        System.out.println(">>> [PING/" + id + "]");
        try {
            return ResponseEntity.ok(rest.getForObject(CSHARP + "/api/plc/ping/" + id, Map.class));
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── 공통 에러 응답 ────────────────────────────────────
    private ResponseEntity<?> err(String msg) {
        Map<String, Object> m = new HashMap<>();
        m.put("success", false);
        m.put("error", msg);
        return ResponseEntity.ok(m);
    }
}