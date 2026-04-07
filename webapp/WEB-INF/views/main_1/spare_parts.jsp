<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common_style.jsp" %>
<style>
.stock-bar-bg   { display:inline-block;width:70px;height:8px;background:var(--bg);border-radius:4px;overflow:hidden;vertical-align:middle;margin-right:5px; }
.stock-bar-fill { height:100%;border-radius:4px; }
.qty-low    { color:var(--red);   font-weight:700; }
.qty-mid    { color:var(--orange);font-weight:700; }
.qty-ok     { color:var(--green); font-weight:700; }
.modal-overlay { display:none;position:fixed;inset:0;background:rgba(0,0,0,.35);z-index:100;align-items:center;justify-content:center; }
.modal-overlay.show { display:flex; }
.modal-box { background:var(--white);border-radius:14px;padding:28px 32px;width:420px;box-shadow:0 8px 40px rgba(0,0,0,.18); }
.modal-title { font-size:16px;font-weight:700;margin-bottom:20px;color:var(--text); }
.modal-actions { display:flex;justify-content:flex-end;gap:8px;margin-top:20px; }
</style>
<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">스페어파트</div>
      <div class="page-sub">설비 예비 부품 재고 관리</div>
    </div>
    <div style="display:flex;gap:8px">
      <button class="btn-outline" onclick="openModal()">➕ 입고 등록</button>
      <button class="btn-primary">📥 엑셀 다운로드</button>
    </div>
  </div>

  <!-- 요약 -->
  <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:16px">
    <div class="card" style="text-align:center;padding:14px 16px">
      <div style="font-size:11px;color:var(--muted);margin-bottom:4px">전체 품목</div>
      <div style="font-size:26px;font-weight:800;color:var(--primary)" id="totalItems">0</div>
    </div>
    <div class="card" style="text-align:center;padding:14px 16px">
      <div style="font-size:11px;color:var(--muted);margin-bottom:4px">재고 부족</div>
      <div style="font-size:26px;font-weight:800;color:var(--red)" id="lowItems">0</div>
    </div>
    <div class="card" style="text-align:center;padding:14px 16px">
      <div style="font-size:11px;color:var(--muted);margin-bottom:4px">교체 임박</div>
      <div style="font-size:26px;font-weight:800;color:var(--orange)" id="nearItems">0</div>
    </div>
    <div class="card" style="text-align:center;padding:14px 16px">
      <div style="font-size:11px;color:var(--muted);margin-bottom:4px">정상</div>
      <div style="font-size:26px;font-weight:800;color:var(--green)" id="okItems">0</div>
    </div>
  </div>

  <div class="card">
    <div style="display:flex;align-items:center;gap:10px;margin-bottom:14px;flex-wrap:wrap">
      <div class="card-title" style="margin:0">부품 목록</div>
      <input class="form-input" type="text" placeholder="품명·부품번호 검색" style="width:200px;margin-left:auto" oninput="filterParts(this.value)">
      <select class="form-select" style="width:140px" onchange="filterCategory(this.value)">
        <option value="">전체 카테고리</option>
        <option>히터</option><option>열전대</option><option>O2센서</option>
        <option>팬/모터</option><option>밸브</option><option>필터</option><option>기타</option>
      </select>
    </div>
    <table class="data-table" id="partsTable">
      <thead>
        <tr>
          <th>No</th><th>부품번호</th><th>품명</th><th>카테고리</th><th>적용 설비</th>
          <th>재고수량</th><th>최소재고</th><th>재고현황</th><th>단위</th>
          <th>최근 교체일</th><th>교체 주기</th><th>상태</th>
        </tr>
      </thead>
      <tbody id="partsBody"></tbody>
    </table>
  </div>
</div>

<!-- 입고 모달 -->
<div class="modal-overlay" id="inModal">
  <div class="modal-box">
    <div class="modal-title">📦 부품 입고 등록</div>
    <div style="display:flex;flex-direction:column;gap:12px">
      <div class="form-field">
        <label class="form-label">부품 선택</label>
        <select class="form-select" id="modalPart" style="width:100%"></select>
      </div>
      <div class="form-field">
        <label class="form-label">입고 수량</label>
        <input class="form-input" type="number" id="modalQty" min="1" value="1" style="width:100%">
      </div>
      <div class="form-field">
        <label class="form-label">입고일</label>
        <input class="form-input" type="date" id="modalDate" style="width:100%">
      </div>
      <div class="form-field">
        <label class="form-label">비고</label>
        <input class="form-input" type="text" id="modalNote" placeholder="비고" style="width:100%">
      </div>
    </div>
    <div class="modal-actions">
      <button class="btn-outline" onclick="closeModal()">취소</button>
      <button class="btn-primary" onclick="saveIn()">저장</button>
    </div>
  </div>
</div>

<script>
var partsData = [
  {no:1,code:'HT-001',name:'히터 엘리먼트 (3kW)',cat:'히터',  equip:'열처리로 전계열',qty:4,  min:2,unit:'EA',lastChg:'2026-02-10',cycle:'6개월'},
  {no:2,code:'HT-002',name:'히터 엘리먼트 (5kW)',cat:'히터',  equip:'열처리로 3·4호기', qty:1,  min:2,unit:'EA',lastChg:'2025-12-01',cycle:'6개월'},
  {no:3,code:'TC-001',name:'K형 열전대 (1100°C)', cat:'열전대',equip:'열처리로 전계열',qty:8,  min:4,unit:'EA',lastChg:'2026-01-15',cycle:'12개월'},
  {no:4,code:'TC-002',name:'K형 열전대 (600°C)',  cat:'열전대',equip:'세척기 계열',     qty:3,  min:2,unit:'EA',lastChg:'2026-03-01',cycle:'12개월'},
  {no:5,code:'O2-001',name:'지르코니아 O2 셀',   cat:'O2센서',equip:'열처리로 전계열',qty:2,  min:2,unit:'EA',lastChg:'2025-11-20',cycle:'24개월'},
  {no:6,code:'FN-001',name:'순환팬 모터',         cat:'팬/모터',equip:'열처리로 1·2호기',qty:1, min:1,unit:'EA',lastChg:'2025-08-10',cycle:'36개월'},
  {no:7,code:'VV-001',name:'가스 조절 밸브',      cat:'밸브',  equip:'열처리로 전계열',qty:2,  min:1,unit:'EA',lastChg:'2026-01-05',cycle:'24개월'},
  {no:8,code:'FL-001',name:'오일 필터 (세척기)',  cat:'필터',  equip:'세척기 계열',     qty:0,  min:2,unit:'EA',lastChg:'2026-03-10',cycle:'3개월'},
  {no:9,code:'FL-002',name:'에어 필터 (냉각)',    cat:'필터',  equip:'냉각장치 계열',   qty:5,  min:2,unit:'EA',lastChg:'2026-02-20',cycle:'3개월'},
  {no:10,code:'ETC-001',name:'퓨즈 세트',         cat:'기타',  equip:'전체',            qty:20, min:5,unit:'EA',lastChg:'2026-01-01',cycle:'-'},
];

function renderParts(data){
  var low=0,near=0,ok=0;
  var html='';
  data.forEach(function(r){
    var pct = r.min>0 ? Math.min(100, Math.round(r.qty/r.min/2*100)) : 100;
    var stockCls, barColor, statusBadge;
    if(r.qty === 0){ stockCls='qty-low'; barColor='var(--red)'; statusBadge='badge-alarm'; low++; }
    else if(r.qty <= r.min){ stockCls='qty-mid'; barColor='var(--orange)'; statusBadge='badge-warn'; near++; }
    else { stockCls='qty-ok'; barColor='var(--green)'; statusBadge='badge-ok'; ok++; }

    html+='<tr>'
        +'<td>'+r.no+'</td><td style="font-family:monospace;font-size:12px">'+r.code+'</td>'
        +'<td style="font-weight:600">'+r.name+'</td><td>'+r.cat+'</td><td>'+r.equip+'</td>'
        +'<td class="'+stockCls+'">'+r.qty+'</td><td style="color:var(--muted)">'+r.min+'</td>'
        +'<td><span class="stock-bar-bg"><span class="stock-bar-fill" style="width:'+pct+'%;background:'+barColor+'"></span></span></td>'
        +'<td>'+r.unit+'</td><td>'+r.lastChg+'</td><td>'+r.cycle+'</td>'
        +'<td><span class="badge '+statusBadge+'">'+(r.qty===0?'재고없음':r.qty<=r.min?'부족':'정상')+'</span></td>'
        +'</tr>';
  });
  document.getElementById('partsBody').innerHTML = html;
  document.getElementById('totalItems').textContent = data.length;
  document.getElementById('lowItems').textContent  = low;
  document.getElementById('nearItems').textContent = near;
  document.getElementById('okItems').textContent   = ok;
}

function filterParts(q){ renderParts(partsData.filter(function(r){ return r.name.includes(q)||r.code.includes(q); })); }
function filterCategory(c){ renderParts(c?partsData.filter(function(r){ return r.cat===c; }):partsData); }

function openModal(){
  var opts = partsData.map(function(r){ return '<option value="'+r.no+'">'+r.code+' — '+r.name+'</option>'; }).join('');
  document.getElementById('modalPart').innerHTML = opts;
  var today = new Date(); document.getElementById('modalDate').value = today.toISOString().slice(0,10);
  document.getElementById('inModal').classList.add('show');
}
function closeModal(){ document.getElementById('inModal').classList.remove('show'); }
function saveIn(){ alert('입고 저장 기능은 서버 연동 후 구현됩니다.'); closeModal(); }

renderParts(partsData);
</script>
</body></html>
