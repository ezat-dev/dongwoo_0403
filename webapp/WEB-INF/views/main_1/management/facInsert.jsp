<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common_style.jsp" %>
<style>
.toast-wrap { position:fixed; top:20px; left:50%; transform:translateX(-50%); z-index:9999; pointer-events:none; }
.toast { background:#2D3748; color:#fff; padding:10px 22px; border-radius:8px; font-size:13px; font-weight:600;
  box-shadow:0 4px 16px rgba(0,0,0,.2); opacity:0; transform:translateY(-12px);
  transition:opacity .25s, transform .25s; white-space:nowrap; }
.toast.toast-success { background:#38A169; }
.toast.toast-error   { background:#E53E3E; }
.toast.show { opacity:1; transform:translateY(0); }

.list-panel { display:flex; flex-direction:column; gap:10px; height:calc(100vh - 130px); }
.search-bar { display:flex; gap:6px; align-items:center; flex-wrap:wrap; }
.search-bar label { font-size:11px; color:var(--muted); font-weight:600; white-space:nowrap; }
.fac-table-wrap { flex:1; overflow-y:auto; border:1px solid var(--border); border-radius:8px; }
.fac-table { width:100%; border-collapse:collapse; font-size:12px; }
.fac-table th { background:var(--bg); color:var(--muted); font-size:11px; font-weight:600;
  padding:8px 10px; border-bottom:2px solid var(--border); position:sticky; top:0; z-index:1; text-align:left; }
.fac-table td { padding:8px 10px; border-bottom:1px solid var(--border); cursor:pointer;
  white-space:nowrap; overflow:hidden; text-overflow:ellipsis; max-width:150px; }
.fac-table tr:last-child td { border-bottom:none; }
.fac-table tbody tr:hover { background:var(--primary-l); }
.fac-table tbody tr.selected { background:#EBF8FF; font-weight:600; }
.pagination-wrap { display:flex; align-items:center; justify-content:center; gap:4px; padding-top:4px; }
.pg-btn { width:28px; height:28px; border-radius:5px; border:1px solid var(--border);
  background:var(--white); cursor:pointer; font-size:12px; }
.pg-btn:hover,.pg-btn.active { background:var(--primary); color:#fff; border-color:var(--primary); }

.modal-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,.45); z-index:1000; align-items:center; justify-content:center; }
.modal-overlay.open { display:flex; }
.modal-box { background:var(--white); border-radius:12px; width:800px; max-width:96vw;
  max-height:90vh; display:flex; flex-direction:column; box-shadow:0 8px 40px rgba(0,0,0,.2); }
.modal-header { display:flex; align-items:center; gap:10px; padding:14px 18px; border-bottom:1px solid var(--border); }
.modal-header .modal-title { font-size:14px; font-weight:700; flex:1; }
.modal-header .btn-icon { background:none; border:none; cursor:pointer; font-size:18px; color:var(--muted); padding:2px 6px; }
.modal-header .btn-icon:hover { color:var(--text); }
.modal-body { flex:1; overflow-y:auto; padding:18px; }
.modal-footer { display:flex; gap:8px; justify-content:flex-end; padding:12px 18px; border-top:1px solid var(--border); }

.field-grid   { display:grid; grid-template-columns:1fr 1fr; gap:10px 14px; }
.field-full   { grid-column:1/-1; }
.field-group  { margin-bottom:18px; }
.field-group-title { font-size:11px; font-weight:700; color:var(--primary); letter-spacing:.3px;
  padding-bottom:6px; border-bottom:1px solid var(--border); margin-bottom:10px; }
.f-label  { font-size:11px; color:var(--muted); font-weight:600; margin-bottom:3px; }
.f-input  { width:100%; padding:6px 9px; border:1px solid var(--border); border-radius:6px;
  font-size:12px; color:var(--text); background:var(--white); outline:none; box-sizing:border-box; }
.f-input:focus { border-color:var(--primary); }
.f-input[readonly] { background:var(--bg); }
.f-select { width:100%; padding:6px 9px; border:1px solid var(--border); border-radius:6px;
  font-size:12px; color:var(--text); background:var(--white); outline:none; box-sizing:border-box; }
.badge-new  { background:#EBF8FF; color:var(--primary); border:1px solid var(--primary-m);
  padding:2px 8px; border-radius:10px; font-size:11px; font-weight:600; }
.badge-edit { background:#FFFAF0; color:var(--orange); border:1px solid #FBD38D;
  padding:2px 8px; border-radius:10px; font-size:11px; font-weight:600; }
.state-badge { display:inline-block; padding:2px 8px; border-radius:10px; font-size:11px; font-weight:600; }
.state-정상  { background:#F0FFF4; color:var(--green); border:1px solid #9AE6B4; }
.state-수리중 { background:#FFFAF0; color:var(--orange); border:1px solid #FBD38D; }
.state-불용  { background:#FFF5F5; color:var(--red);   border:1px solid #FEB2B2; }
.dblclick-hint { font-size:10px; color:var(--muted); margin-left:6px; font-style:italic; }

/* ── 리스트 사진 썸네일 ── */
.thumb-cell { width:56px; padding:3px 6px !important; }
.thumb-img  { width:46px; height:34px; object-fit:cover; border-radius:4px;
  border:1px solid var(--border); display:block; background:var(--bg); cursor:zoom-in; }
.thumb-none { width:46px; height:34px; background:var(--bg); border-radius:4px;
  border:1px dashed var(--border); display:flex; align-items:center; justify-content:center;
  font-size:14px; opacity:.25; }

/* ── 이미지 패널 ── */
.img-panel { display:flex; gap:16px; padding:12px 18px; border-bottom:1px solid var(--border); background:var(--bg); align-items:center; }
.img-slot { display:flex; flex-direction:column; align-items:center; gap:5px; }
.img-slot-label { font-size:10px; color:var(--muted); font-weight:700; letter-spacing:.3px; text-align:center; }
.img-box { width:140px; height:100px; border:2px dashed var(--border); border-radius:8px;
  display:flex; align-items:center; justify-content:center; overflow:hidden;
  cursor:pointer; transition:border-color .2s, box-shadow .2s; background:var(--white); }
.img-box:hover { border-color:var(--primary); box-shadow:0 2px 8px rgba(0,0,0,.08); }
.img-box img { width:100%; height:100%; object-fit:cover; display:none; }
.img-empty { display:flex; flex-direction:column; align-items:center; gap:3px; pointer-events:none; }
.img-empty-icon { font-size:26px; opacity:.3; }
.img-empty-text { font-size:9px; color:var(--muted); }
.img-slot-btns { display:flex; gap:4px; }
.img-slot-btns button { font-size:10px; padding:2px 7px; line-height:1.4; }
</style>

<div class="toast-wrap"><div class="toast" id="toast"></div></div>

<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">설비 기준 정보</div>
      <div class="page-sub">설비 등록 · 수정 · 조회</div>
    </div>
    <button class="btn-primary btn-sm" onclick="newForm()" data-perm="add">＋ 신규 등록</button>
  </div>

  <div class="list-panel card" style="padding:14px">
    <div class="search-bar">
      <label>설비명</label>
      <input class="f-input" id="kwFacName" style="width:140px" placeholder="설비명 검색" onkeydown="if(event.key==='Enter')searchList()">
      <label>설비번호</label>
      <input class="f-input" id="kwFacNo" style="width:120px" placeholder="설비번호 검색" onkeydown="if(event.key==='Enter')searchList()">
      <label>구분</label>
      <select class="f-select" id="kwFacGubn" style="width:80px" onchange="searchList()">
        <option value="">전체</option>
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
      </select>
      <button class="btn-primary btn-sm" onclick="searchList()">조회</button>
      <span class="dblclick-hint">※ 더블클릭으로 수정</span>
    </div>

    <div class="fac-table-wrap">
      <table class="fac-table">
        <thead>
          <tr>
            <th class="thumb-cell">사진</th>
            <th style="width:90px">설비코드</th>
            <th style="width:160px">설비명</th>
            <th style="width:100px">설비번호</th>
            <th style="width:60px">구분</th>
            <th style="width:100px">위치</th>
            <th style="width:120px">제조사</th>
            <th style="width:80px">가동여부</th>
            <th style="width:80px">상태</th>
            <th>담당자</th>
          </tr>
        </thead>
        <tbody id="facTableBody">
          <tr><td colspan="10" style="text-align:center;padding:40px;color:var(--muted)">조회 버튼을 누르세요</td></tr>
        </tbody>
      </table>
    </div>

    <div style="display:flex;align-items:center;justify-content:space-between">
      <span style="font-size:11px;color:var(--muted)" id="totalCount">총 0건</span>
      <div class="pagination-wrap" id="pagination"></div>
    </div>
  </div>
</div>

<!-- 등록/수정 모달 -->
<div class="modal-overlay" id="modalOverlay" onclick="if(event.target===this)closeModal()">
  <div class="modal-box">
    <div class="modal-header">
      <span id="formModeBadge" class="badge-new">신규</span>
      <span class="modal-title" id="modalTitle">설비 등록</span>
      <button class="btn-icon" onclick="closeModal()">✕</button>
    </div>

    <!-- 이미지 패널 -->
    <div class="img-panel">
      <div class="img-slot">
        <div class="img-slot-label">설비 사진</div>
        <div class="img-box" id="imgBox_fac">
          <img id="imgPrev_fac" alt="설비사진">
          <div class="img-empty" id="imgEmpty_fac"><span class="img-empty-icon">🖼</span><span class="img-empty-text">클릭하여 업로드</span></div>
        </div>
        <div class="img-slot-btns">
          <input type="file" id="imgFile_fac" accept="image/*,.pdf" style="display:none" onchange="uploadFacImage(this)">
          <button class="btn-outline btn-sm" onclick="triggerImgInput('imgFile_fac')" type="button">업로드</button>
          <button class="btn-outline btn-sm" onclick="setFacImage('')" type="button" style="color:var(--red);border-color:var(--red)">✕</button>
        </div>
      </div>
      <div style="font-size:11px;color:var(--muted);line-height:1.8;padding-left:4px">
        설비 사진 또는 도면을 등록합니다.<br>
        이미지(JPG, PNG 등) / PDF 지원<br>
        <span style="font-size:10px;opacity:.7">※ 이미지 클릭 시 원본 보기</span>
      </div>
    </div>

    <div class="modal-body">

      <div class="field-group">
        <div class="field-group-title">기본정보</div>
        <div class="field-grid">
          <div>
            <div class="f-label">설비코드</div>
            <input class="f-input" id="f_fac_code" readonly placeholder="자동 생성" style="background:var(--bg);color:var(--muted)">
          </div>
          <div>
            <div class="f-label">구분 <span style="color:var(--red)">*</span></div>
            <select class="f-select" id="f_fac_gubn">
              <option value="">선택</option>
              <option value="A">A</option>
              <option value="B">B</option>
              <option value="C">C</option>
            </select>
          </div>
          <div>
            <div class="f-label">설비명 <span style="color:var(--red)">*</span></div>
            <input class="f-input" id="f_fac_name" maxlength="100">
          </div>
          <div>
            <div class="f-label">설비번호</div>
            <input class="f-input" id="f_fac_no" maxlength="50">
          </div>
          <div>
            <div class="f-label">규격</div>
            <input class="f-input" id="f_fac_gyu" maxlength="50">
          </div>
          <div>
            <div class="f-label">모델번호 (MON)</div>
            <input class="f-input" id="f_fac_mon" maxlength="18">
          </div>
          <div>
            <div class="f-label">제조사</div>
            <input class="f-input" id="f_fac_make" maxlength="50">
          </div>
          <div>
            <div class="f-label">구매처</div>
            <input class="f-input" id="f_fac_cbuy" maxlength="50">
          </div>
          <div>
            <div class="f-label">구매일</div>
            <input class="f-input" id="f_fac_buy" type="date">
          </div>
          <div>
            <div class="f-label">제조일</div>
            <input class="f-input" id="f_fac_mday" type="date">
          </div>
          <div>
            <div class="f-label">위치</div>
            <input class="f-input" id="f_fac_plc" maxlength="50">
          </div>
          <div>
            <div class="f-label">용도</div>
            <input class="f-input" id="f_fac_yong" maxlength="50">
          </div>
        </div>
      </div>

      <div class="field-group">
        <div class="field-group-title">운영정보</div>
        <div class="field-grid">
          <div>
            <div class="f-label">가동여부</div>
            <select class="f-select" id="f_fac_able">
              <option value="">선택</option>
              <option value="가동">가동</option>
              <option value="정지">정지</option>
              <option value="대기">대기</option>
            </select>
          </div>
          <div>
            <div class="f-label">상태</div>
            <select class="f-select" id="f_fac_state">
              <option value="">선택</option>
              <option value="정상">정상</option>
              <option value="수리중">수리중</option>
              <option value="불용">불용</option>
            </select>
          </div>
          <div>
            <div class="f-label">현황</div>
            <input class="f-input" id="f_fac_hyun" maxlength="50">
          </div>
          <div>
            <div class="f-label">가동시간</div>
            <input class="f-input" id="f_fac_time" maxlength="50">
          </div>
          <div>
            <div class="f-label">점검주기</div>
            <input class="f-input" id="f_fac_test" maxlength="50">
          </div>
          <div>
            <div class="f-label">공정번호 (TECH_NO)</div>
            <input class="f-input" id="f_tech_no" maxlength="10">
          </div>
          <div>
            <div class="f-label">담당자1</div>
            <input class="f-input" id="f_fac_man1" maxlength="30">
          </div>
          <div>
            <div class="f-label">담당자2</div>
            <input class="f-input" id="f_fac_man2" maxlength="30">
          </div>
          <div>
            <div class="f-label">PDA 사용여부</div>
            <select class="f-select" id="f_fac_pda_use">
              <option value="">선택</option>
              <option value="Y">Y (사용)</option>
              <option value="N">N (미사용)</option>
            </select>
          </div>
          <div>
            <div class="f-label">LOT</div>
            <input class="f-input" id="f_fac_lot" maxlength="40">
          </div>
          <div>
            <div class="f-label">단위 (DAN)</div>
            <input class="f-input" id="f_fac_dan" maxlength="10">
          </div>
        </div>
      </div>

      <div class="field-group">
        <div class="field-group-title">기타 항목</div>
        <div class="field-grid">
          <div><div class="f-label">E1</div><input class="f-input" id="f_fac_e1" maxlength="50"></div>
          <div><div class="f-label">E2</div><input class="f-input" id="f_fac_e2" maxlength="50"></div>
          <div><div class="f-label">E3</div><input class="f-input" id="f_fac_e3" maxlength="50"></div>
          <div><div class="f-label">E4</div><input class="f-input" id="f_fac_e4" maxlength="30"></div>
          <div><div class="f-label">첨부파일명</div><input class="f-input" id="f_fac_file_name" readonly style="background:var(--bg);color:var(--muted);font-size:10px"></div>
        </div>
      </div>

      <div class="field-group">
        <div class="field-group-title">특이사항</div>
        <div style="display:flex;flex-direction:column;gap:10px">
          <div><div class="f-label">불용사유</div><textarea class="f-input" id="f_fac_unus" rows="2" style="resize:vertical;font-family:inherit" maxlength="500"></textarea></div>
          <div><div class="f-label">주의사항</div><textarea class="f-input" id="f_fac_cau" rows="2" style="resize:vertical;font-family:inherit" maxlength="500"></textarea></div>
          <div><div class="f-label">비고</div><textarea class="f-input" id="f_fac_bigo" rows="2" style="resize:vertical;font-family:inherit" maxlength="500"></textarea></div>
        </div>
      </div>

    </div>

    <div class="modal-footer">
      <button class="btn-outline btn-sm" id="btnDelete" onclick="deleteForm()" style="color:var(--red);border-color:var(--red);display:none;margin-right:auto" data-perm="del">🗑 삭제</button>
      <button class="btn-outline btn-sm" onclick="closeModal()">취소</button>
      <button class="btn-primary btn-sm" onclick="saveForm()">💾 저장</button>
    </div>
  </div>
</div>

<script>
var base     = '${pageContext.request.contextPath}';
var curPage  = 1;
var pageSize = 20;
var selCode  = null;

var toastTimer;
function showToast(msg, type){
  var t=document.getElementById('toast');
  t.textContent=msg; t.className='toast '+(type||'toast-success');
  clearTimeout(toastTimer);
  setTimeout(function(){ t.classList.add('show'); },10);
  toastTimer=setTimeout(function(){ t.classList.remove('show'); },2500);
}

function openModal(){ document.getElementById('modalOverlay').classList.add('open'); document.body.style.overflow='hidden'; }
function closeModal(){ document.getElementById('modalOverlay').classList.remove('open'); document.body.style.overflow=''; }

function searchList(){ curPage=1; loadList(); }

function loadList(){
  var n=encodeURIComponent(document.getElementById('kwFacName').value.trim());
  var no=encodeURIComponent(document.getElementById('kwFacNo').value.trim());
  var g=encodeURIComponent(document.getElementById('kwFacGubn').value);
  fetch(base+'/fac/list?kwFacName='+n+'&kwFacNo='+no+'&kwFacGubn='+g+'&page='+curPage+'&pageSize='+pageSize)
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success===false){ showToast(d.error,'toast-error'); return; }
      renderTable(d.list||[]);
      renderPaging(d.total||0, d.totalPage||1);
      document.getElementById('totalCount').textContent='총 '+(d.total||0)+'건';
    });
}

function renderTable(list){
  var tbody=document.getElementById('facTableBody');
  if(!list.length){ tbody.innerHTML='<tr><td colspan="10" style="text-align:center;padding:40px;color:var(--muted)">데이터 없음</td></tr>'; return; }
  tbody.innerHTML=list.map(function(f){
    var sel=(f.fac_code===selCode)?' selected':'';
    var stCls=f.fac_state?('state-'+f.fac_state):'';
    var stBadge=f.fac_state?'<span class="state-badge '+stCls+'">'+esc(f.fac_state)+'</span>':'';
    var fn=f.fac_file_name||'';
    var thumbTd=fn
      ? '<td class="thumb-cell" data-img-src="'+base+'/fac/image/'+encodeURIComponent(fn)+'" data-img-label="'+esc(f.fac_name||'')+'">'
          +'<img class="thumb-img" src="'+base+'/fac/image/'+encodeURIComponent(fn)+'" onerror="this.outerHTML=\'<span class=thumb-none>📷</span>\'">'
          +'</td>'
      : '<td class="thumb-cell"><span class="thumb-none">📷</span></td>';
    return '<tr class="'+sel+'" onclick="clickRow(\''+esc(f.fac_code)+'\')" ondblclick="dblSelectRow(\''+esc(f.fac_code)+'\')">'+thumbTd
      +'<td>'+esc(f.fac_code||'')+'</td>'
      +'<td>'+esc(f.fac_name||'')+'</td>'
      +'<td>'+esc(f.fac_no||'')+'</td>'
      +'<td>'+esc(f.fac_gubn||'')+'</td>'
      +'<td>'+esc(f.fac_plc||'')+'</td>'
      +'<td>'+esc(f.fac_make||'')+'</td>'
      +'<td>'+esc(f.fac_able||'')+'</td>'
      +'<td>'+stBadge+'</td>'
      +'<td>'+esc(f.fac_man1||'')+'</td>'
      +'</tr>';
  }).join('');
}

function renderPaging(total, totalPage){
  var pg=document.getElementById('pagination');
  if(totalPage<=1){ pg.innerHTML=''; return; }
  var html='', from=Math.max(1,curPage-2), to=Math.min(totalPage,curPage+2);
  if(curPage>1) html+='<button class="pg-btn" onclick="goPage('+(curPage-1)+')">‹</button>';
  for(var i=from;i<=to;i++) html+='<button class="pg-btn'+(i===curPage?' active':'')+'" onclick="goPage('+i+')">'+i+'</button>';
  if(curPage<totalPage) html+='<button class="pg-btn" onclick="goPage('+(curPage+1)+')">›</button>';
  pg.innerHTML=html;
}
function goPage(p){ curPage=p; loadList(); }

function clickRow(facCode){
  selCode=facCode;
  document.querySelectorAll('#facTableBody tr').forEach(function(tr){
    var first=tr.querySelector('td');
    tr.classList.toggle('selected', first&&first.textContent===facCode);
  });
}

function dblSelectRow(facCode){
  selCode=facCode;
  clickRow(facCode);
  fetch(base+'/fac/detail?facCode='+encodeURIComponent(facCode))
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success===false){ showToast(d.error,'toast-error'); return; }
      fillForm(d);
      setMode('edit');
      openModal();
    });
}

var FIELDS=['fac_code','fac_no','fac_name','fac_gyu','fac_hyun','fac_yong',
  'fac_man1','fac_man2','fac_plc','fac_make','fac_cbuy','fac_buy','fac_mday',
  'fac_mon','fac_able','fac_time','fac_test','fac_bigo','tech_no','fac_gubn',
  'fac_e1','fac_e2','fac_e3','fac_e4','fac_lot','fac_dan','fac_unus','fac_cau',
  'fac_pda_use','fac_state','fac_file_name'];

function fillForm(d){
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) el.value=d[f]||''; });
  setFacImage(d.fac_file_name||'');
}
function collectForm(){
  var obj={};
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) obj[f]=el.value||null; });
  return obj;
}

function newForm(){
  selCode=null;
  document.querySelectorAll('#facTableBody tr').forEach(function(tr){ tr.classList.remove('selected'); });
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) el.value=''; });
  setFacImage('');
  setMode('new'); openModal();
  setTimeout(function(){ document.getElementById('f_fac_name').focus(); },100);
}

function saveForm(){
  var data=collectForm();
  if(!data.fac_name||!data.fac_name.trim()){ showToast('설비명을 입력하세요.','toast-error'); return; }
  if(!data.fac_gubn||!data.fac_gubn.trim()){ showToast('구분을 선택하세요.','toast-error'); return; }
  var isNew=!data.fac_code;
  fetch(base+'/fac/save',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(data)})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){ selCode=d.facCode; closeModal(); loadList(); showToast(isNew?'등록되었습니다.':'수정되었습니다.'); }
      else { showToast(d.error||'저장 실패','toast-error'); }
    });
}

function deleteForm(){
  if(!selCode){ showToast('삭제할 설비를 선택하세요.','toast-error'); return; }
  if(!confirm('['+selCode+'] 설비를 삭제하시겠습니까?')) return;
  fetch(base+'/fac/delete',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({facCode:selCode})})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){ selCode=null; closeModal(); loadList(); showToast('삭제되었습니다.'); }
      else { showToast(d.error||'삭제 실패','toast-error'); }
    });
}

function setMode(mode){
  var badge=document.getElementById('formModeBadge'), btnDel=document.getElementById('btnDelete'), title=document.getElementById('modalTitle');
  if(mode==='new'){ badge.textContent='신규'; badge.className='badge-new'; title.textContent='설비 등록'; btnDel.style.display='none'; }
  else            { badge.textContent='수정'; badge.className='badge-edit'; title.textContent='설비 수정'; btnDel.style.display=''; }
}

function esc(s){ return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }

/* ── 이미지 업로드 ── */
function triggerImgInput(id){ document.getElementById(id).click(); }

function setFacImage(fileName){
  var el=document.getElementById('f_fac_file_name'); if(el) el.value=fileName||'';
  var prev=document.getElementById('imgPrev_fac');
  var empty=document.getElementById('imgEmpty_fac');
  var box=document.getElementById('imgBox_fac');
  if(!prev||!empty||!box) return;
  if(fileName){
    prev.src=base+'/fac/image/'+encodeURIComponent(fileName);
    prev.style.display='block';
    empty.style.display='none';
    box.onclick=function(){ window.open(base+'/fac/image/'+encodeURIComponent(fileName),'_blank'); };
  } else {
    prev.src=''; prev.style.display='none';
    empty.style.display='flex';
    box.onclick=function(){ document.getElementById('imgFile_fac').click(); };
  }
}

function uploadFacImage(input){
  var file=input.files[0]; if(!file) return;
  var fd=new FormData(); fd.append('file',file);
  fetch(base+'/fac/image/upload',{method:'POST',body:fd})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){ setFacImage(d.fileName); showToast('이미지 업로드 완료'); }
      else { showToast(d.error||'업로드 실패','toast-error'); }
      input.value='';
    })
    .catch(function(){ showToast('업로드 실패','toast-error'); input.value=''; });
}

document.addEventListener('keydown',function(e){ if(e.key==='Escape') closeModal(); });

/* ── 리스트 호버 미리보기 ── */
(function(){
  var p=document.createElement('div');
  Object.assign(p.style,{display:'none',position:'fixed',zIndex:'6000',background:'#fff',
    border:'1px solid #e2e8f0',borderRadius:'10px',boxShadow:'0 8px 32px rgba(0,0,0,.22)',
    overflow:'hidden',width:'270px',pointerEvents:'none'});
  p.id='imgPopG';
  p.innerHTML='<img id="imgPopGImg" style="width:100%;max-height:210px;object-fit:contain;display:block;background:#f7fafc">'
    +'<div id="imgPopGLbl" style="font-size:10px;color:#718096;padding:4px 10px;border-top:1px solid #e2e8f0;white-space:nowrap;overflow:hidden;text-overflow:ellipsis"></div>';
  document.body.appendChild(p);
})();
function showImgPopup(e,src,lbl){
  var p=document.getElementById('imgPopG');
  document.getElementById('imgPopGImg').src=src;
  document.getElementById('imgPopGLbl').textContent=lbl||'';
  p.style.display='block'; posImgPopup(e);
}
function posImgPopup(e){
  var p=document.getElementById('imgPopG'),pw=272,ph=240;
  var x=e.clientX+16,y=e.clientY-60;
  if(x+pw>window.innerWidth) x=e.clientX-pw-8;
  if(y+ph>window.innerHeight) y=window.innerHeight-ph-8;
  if(y<4) y=4;
  p.style.left=x+'px'; p.style.top=y+'px';
}
function hideImgPopup(){ document.getElementById('imgPopG').style.display='none'; }

document.addEventListener('DOMContentLoaded',function(){
  var tbody=document.getElementById('facTableBody');
  tbody.addEventListener('mouseover',function(e){
    var td=e.target.closest('td[data-img-src]');
    if(td) showImgPopup(e,td.dataset.imgSrc,td.dataset.imgLabel||'');
    else hideImgPopup();
  });
  tbody.addEventListener('mousemove',function(e){
    if(document.getElementById('imgPopG').style.display==='block') posImgPopup(e);
  });
  tbody.addEventListener('mouseleave',hideImgPopup);
});

loadList();
</script>
</body>
</html>
