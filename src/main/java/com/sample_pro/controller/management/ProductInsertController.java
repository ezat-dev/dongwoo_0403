package com.sample_pro.controller.management;

import com.sample_pro.domain.Product;
import com.sample_pro.service.management.ProductInsertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/product")
public class ProductInsertController {

    @Autowired
    private ProductInsertService productInsertService;

    @RequestMapping(value = "/list", method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> list(
            @RequestParam(defaultValue = "") String kwProdName,
            @RequestParam(defaultValue = "") String kwProdNo,
            @RequestParam(defaultValue = "") String kwCorpName,
            @RequestParam(defaultValue = "1")  int page,
            @RequestParam(defaultValue = "20") int pageSize) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("kwProdName", kwProdName.trim());
            params.put("kwProdNo",   kwProdNo.trim());
            params.put("kwCorpName", kwCorpName.trim());
            params.put("page",       page);
            params.put("pageSize",   pageSize);
            return ResponseEntity.ok(productInsertService.getList(params));
        } catch (Exception e) {
            return ResponseEntity.ok(err("조회 실패: " + e.getMessage()));
        }
    }

    @RequestMapping(value = "/detail", method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> detail(@RequestParam String prodCode) {
        try {
            Product p = productInsertService.getOne(prodCode);
            if (p == null) return ResponseEntity.ok(err("제품을 찾을 수 없습니다."));
            return ResponseEntity.ok(p);
        } catch (Exception e) {
            return ResponseEntity.ok(err("조회 실패: " + e.getMessage()));
        }
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> save(@RequestBody Product product) {
        try {
            productInsertService.save(product);
            Map<String, Object> result = ok();
            result.put("prodCode", product.getProd_code());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.ok(err("저장 실패: " + e.getMessage()));
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> delete(@RequestBody Map<String, Object> body) {
        try {
            String prodCode = body.get("prodCode").toString();
            productInsertService.delete(prodCode);
            return ResponseEntity.ok(ok());
        } catch (Exception e) {
            return ResponseEntity.ok(err("삭제 실패: " + e.getMessage()));
        }
    }

    private static final String PROD_IMG_DIR = "D:/save/Product";

    @RequestMapping(value = "/image/upload", method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> imageUpload(@RequestParam("file") MultipartFile file) {
        try {
            File dir = new File(PROD_IMG_DIR);
            if (!dir.exists()) dir.mkdirs();
            String orig = file.getOriginalFilename();
            String ext = (orig != null && orig.contains(".")) ? orig.substring(orig.lastIndexOf(".")) : "";
            String saved = UUID.randomUUID().toString().replace("-", "") + ext;
            file.transferTo(new File(dir, saved));
            Map<String, Object> m = ok();
            m.put("fileName", saved);
            return ResponseEntity.ok(m);
        } catch (Exception e) {
            return ResponseEntity.ok(err("업로드 실패: " + e.getMessage()));
        }
    }

    @RequestMapping(value = "/image/{filename:.+}", method = RequestMethod.GET)
    public void imageServe(@PathVariable String filename, HttpServletResponse response) {
        try {
            File f = new File(PROD_IMG_DIR, filename);
            if (!f.exists()) { response.sendError(404); return; }
            String mime = Files.probeContentType(f.toPath());
            if (mime == null) mime = "application/octet-stream";
            response.setContentType(mime);
            response.setContentLength((int) f.length());
            String enc = URLEncoder.encode(filename, "UTF-8");
            if (mime.startsWith("image/") || mime.equals("application/pdf")) {
                response.setHeader("Content-Disposition", "inline; filename*=UTF-8''" + enc);
            } else {
                response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + enc);
            }
            try (FileInputStream fis = new FileInputStream(f)) {
                byte[] buf = new byte[8192]; int len;
                while ((len = fis.read(buf)) != -1) response.getOutputStream().write(buf, 0, len);
            }
        } catch (Exception e) {
            try { response.sendError(500); } catch (Exception ignored) {}
        }
    }

    private Map<String, Object> ok()  { Map<String,Object> m=new HashMap<>(); m.put("success",true);  return m; }
    private Map<String, Object> err(String msg) { Map<String,Object> m=new HashMap<>(); m.put("success",false); m.put("error",msg); return m; }
}
