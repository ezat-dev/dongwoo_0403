package com.sample_pro.controller;

import com.sample_pro.dao.PlcConfigDao;
import com.sample_pro.domain.PlcConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.MediaType;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/plc")
public class PlcController {

    private static final String CSHARP = "http://localhost:5050";
    private final RestTemplate rest = new RestTemplate();

    @Autowired
    private PlcConfigDao plcConfigDao;

    // â”€â”€ íŽ˜ì´ì§€ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/PlcReadWrite", method = RequestMethod.GET)
    public String page(Model model) {
        return "/monitoring/PlcReadWrite.jsp";
    }

    // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
    //  ê¸°ì¡´ ì—”ë“œí¬ì¸íŠ¸ (í•˜ìœ„í˜¸í™˜ â€“ default PLC)
    // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

    // â”€â”€ GET /plc/read?start=&count= â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/read", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
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
            return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage());
        }
    }

    // â”€â”€ POST /plc/write â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/write", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> write(@RequestBody Map<String, Integer> body) {
        System.out.println(">>> [WRITE] addr=" + body.get("address") + " <- " + body.get("value"));
        try {
            Map<?, ?> res = postJson(CSHARP + "/api/plc/write", body);
            System.out.println(">>> [WRITE OK] " + res);
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            System.out.println(">>> [WRITE ERR] " + e.getMessage());
            return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage());
        }
    }

    // â”€â”€ GET /plc/config â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/config", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> getConfig() {
        try {
            return ResponseEntity.ok(rest.getForObject(CSHARP + "/api/plc/config", Map.class));
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â”€â”€ POST /plc/config â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/config", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> setConfig(@RequestBody Map<String, Object> body) {
        System.out.println(">>> [CONFIG] " + body);
        try {
            return ResponseEntity.ok(postJson(CSHARP + "/api/plc/config", body));
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â”€â”€ GET /plc/ping â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/ping", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> ping() {
        try {
            return ResponseEntity.ok(rest.getForObject(CSHARP + "/api/plc/ping", Map.class));
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
    //  ì‹ ê·œ â€“ ë‹¤ì¤‘ PLC
    // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

    // â”€â”€ GET /plc/list â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    // ── GET /plc/dblist  (MariaDB tb_plc) ──────────────────────────────────
    @RequestMapping(value = "/dblist", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> dbList() {
        try {
            List<PlcConfig> list = plcConfigDao.selectAll();
            Map<String, Object> r = new HashMap<>();
            r.put("success", true);
            r.put("data", list);
            return ResponseEntity.ok(r);
        } catch (Exception e) {
            return err("DB 조회 실패: " + e.getMessage());
        }
    }

    // ── GET /plc/list ───────────────────────────────────────────────────────
    @RequestMapping(value = "/list", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> list() {
        try {
            return ResponseEntity.ok(rest.getForObject(CSHARP + "/api/plc/list", Object.class));
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â”€â”€ POST /plc/add â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    // Body: { "id":"plc2", "ip":"192.168.1.10", "port":2004, "plcType":"LS", "label":"2í˜¸ê¸°" }
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> add(@RequestBody Map<String, Object> body) {
        System.out.println(">>> [ADD] " + body);
        try {
            return ResponseEntity.ok(postJson(CSHARP + "/api/plc/add", body));
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â”€â”€ DELETE /plc/remove/{id} â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/remove/{id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> remove(@PathVariable String id) {
        System.out.println(">>> [REMOVE] " + id);
        try {
            rest.delete(CSHARP + "/api/plc/remove/" + id);
            Map<String, Object> r = new HashMap<>();
            r.put("success", true);
            return ResponseEntity.ok(r);
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â”€â”€ GET /plc/read/{id}?start=&count= â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/read/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
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
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â”€â”€ POST /plc/write/{id} â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/write/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> writeById(
            @PathVariable String id,
            @RequestBody Map<String, Integer> body) {
        System.out.println(">>> [WRITE/" + id + "] addr=" + body.get("address") + " <- " + body.get("value"));
        try {
            return ResponseEntity.ok(postJson(CSHARP + "/api/plc/write/" + id, body));
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â”€â”€ GET /plc/ping/{id} â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    @RequestMapping(value = "/ping/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> pingById(@PathVariable String id) {
        System.out.println(">>> [PING/" + id + "]");
        try {
            return ResponseEntity.ok(rest.getForObject(CSHARP + "/api/plc/ping/" + id, Map.class));
        } catch (Exception e) { return err("C# API ì—°ê²° ì‹¤íŒ¨: " + e.getMessage()); }
    }

    // â”€â”€ ê³µí†µ ì—ëŸ¬ ì‘ë‹µ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
    // ══════════════════════════════════════════════════════════════
    //  비트 (Coil / Discrete Input) — MODBUS_TCP 전용
    // ══════════════════════════════════════════════════════════════

    // ── GET /plc/readBits?start=&count= ─────────────────────────
    @RequestMapping(value = "/readBits", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> readBits(
            @RequestParam(value = "start", defaultValue = "10001") int start,
            @RequestParam(value = "count", defaultValue = "100")   int count) {

        if (count < 1)    count = 1;
        if (count > 2000) count = 2000;

        String url = CSHARP + "/api/plc/readBits?start=" + start + "&count=" + count;
        System.out.println(">>> [READ_BITS] " + url);
        try {
            Map<?, ?> res = rest.getForObject(url, Map.class);
            System.out.println(">>> [READ_BITS OK] " + res);
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            System.out.println(">>> [READ_BITS ERR] " + e.getMessage());
            return err("C# API 연결 실패: " + e.getMessage());
        }
    }

    // ── POST /plc/writeBit ──────────────────────────────────────
    // Body: { "address": 10001, "value": true }
    @RequestMapping(value = "/writeBit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> writeBit(@RequestBody Map<String, Object> body) {
        System.out.println(">>> [WRITE_BIT] addr=" + body.get("address") + " <- " + body.get("value"));
        try {
            Map<?, ?> res = postJson(CSHARP + "/api/plc/writeBit", body);
            System.out.println(">>> [WRITE_BIT OK] " + res);
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            System.out.println(">>> [WRITE_BIT ERR] " + e.getMessage());
            return err("C# API 연결 실패: " + e.getMessage());
        }
    }

    // ── GET /plc/readBits/{id}?start=&count= ────────────────────
    @RequestMapping(value = "/readBits/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> readBitsById(
            @PathVariable String id,
            @RequestParam(value = "start", defaultValue = "10001") int start,
            @RequestParam(value = "count", defaultValue = "100")   int count) {

        if (count < 1)    count = 1;
        if (count > 2000) count = 2000;

        String url = CSHARP + "/api/plc/readBits/" + id + "?start=" + start + "&count=" + count;
        System.out.println(">>> [READ_BITS/" + id + "] " + url);
        try {
            Map<?, ?> res = rest.getForObject(url, Map.class);
            return ResponseEntity.ok(res);
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    // ── POST /plc/writeBit/{id} ─────────────────────────────────
    @RequestMapping(value = "/writeBit/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> writeBitById(
            @PathVariable String id,
            @RequestBody Map<String, Object> body) {
        System.out.println(">>> [WRITE_BIT/" + id + "] addr=" + body.get("address") + " <- " + body.get("value"));
        try {
            return ResponseEntity.ok(postJson(CSHARP + "/api/plc/writeBit/" + id, body));
        } catch (Exception e) { return err("C# API 연결 실패: " + e.getMessage()); }
    }

    private ResponseEntity<?> err(String msg) {
        Map<String, Object> m = new HashMap<>();
        m.put("success", false);
        m.put("error", msg);
        return ResponseEntity.ok(m);
    }

    private Map<?, ?> postJson(String url, Object body) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Object> entity = new HttpEntity<>(body, headers);
        return rest.exchange(url, HttpMethod.POST, entity, Map.class).getBody();
    }
}

