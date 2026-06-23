package com.sample_pro.controller.management;

import com.sample_pro.domain.Corp;
import com.sample_pro.service.management.CorpInsertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/corp")
public class CorpInsertController {

    @Autowired
    private CorpInsertService corpInsertService;

    @RequestMapping(value = "/list", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> list(
            @RequestParam(defaultValue = "") String kwCorpName,
            @RequestParam(defaultValue = "1")  int page,
            @RequestParam(defaultValue = "20") int pageSize) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("kwCorpName", kwCorpName.trim());
            params.put("page",       page);
            params.put("pageSize",   pageSize);
            return ResponseEntity.ok(corpInsertService.getList(params));
        } catch (Exception e) {
            return ResponseEntity.ok(err("조회 실패: " + e.getMessage()));
        }
    }

    @RequestMapping(value = "/detail", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> detail(@RequestParam String corpCode) {
        try {
            Corp c = corpInsertService.getOne(corpCode);
            if (c == null) return ResponseEntity.ok(err("거래처를 찾을 수 없습니다."));
            return ResponseEntity.ok(c);
        } catch (Exception e) {
            return ResponseEntity.ok(err("조회 실패: " + e.getMessage()));
        }
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> save(@RequestBody Corp corp) {
        try {
            corpInsertService.save(corp);
            Map<String, Object> result = ok();
            result.put("corpCode", corp.getCorp_code());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.ok(err("저장 실패: " + e.getMessage()));
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> delete(@RequestBody Map<String, Object> body) {
        try {
            String corpCode = body.get("corpCode").toString();
            corpInsertService.delete(corpCode);
            return ResponseEntity.ok(ok());
        } catch (Exception e) {
            return ResponseEntity.ok(err("삭제 실패: " + e.getMessage()));
        }
    }

    private Map<String, Object> ok()  { Map<String,Object> m=new HashMap<>(); m.put("success",true);  return m; }
    private Map<String, Object> err(String msg) { Map<String,Object> m=new HashMap<>(); m.put("success",false); m.put("error",msg); return m; }
}
