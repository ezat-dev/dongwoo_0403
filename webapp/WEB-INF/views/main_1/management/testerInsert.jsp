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
.ter-table-wrap { flex:1; overflow-y:auto; border:1px solid var(--border); border-radius:8px; }
.ter-table { width:100%; border-collapse:collapse; font-size:12px; }
.ter-table th { background:var(--bg); color:var(--muted); font-size:11px; font-weight:600;
  padding:8px 10px; border-bottom:2px solid var(--border); position:sticky; top:0; z-index:1; text-align:left; }
.ter-table td { padding:8px 10px; border-bottom:1px solid var(--border); cursor:pointer;
  white-space:nowrap; overflow:hidden; text-overflow:ellipsis; max-width:180px; }
.ter-table tr:last-child td { border-bottom:none; }
.ter-table tbody tr:hover { background:var(--primary-l); }
.ter-table tbody tr.selected { background:#EBF8FF; font-weight:600; }
.pagination-wrap { display:flex; align-items:center; justify-content:center; gap:4px; padding-top:4px; }
.pg-btn { width:28px; height:28px; border-radius:5px; border:1px solid var(--border);
  background:var(--white); cursor:pointer; font-size:12px; }
.pg-btn:hover,.pg-btn.active { background:var(--primary); color:#fff; border-color:var(--primary); }

.modal-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,.45); z-index:1000; align-items:center; justify-content:center; }
.modal-overlay.open { display:flex; }
.modal-box { background:var(--white); border-radius:12px; width:640px; max-width:96vw;
  max-height:90vh; display:flex; flex-direction:column; box-shadow:0 8px 40px rgba(0,0,0,.2); }
.modal-header { display:flex; align-items:center; gap:10px; padding:14px 18px; border-bottom:1px solid var(--border); }
.modal-header .modal-title { font-size:14px; font-weight:700; flex:1; }
.modal-header .btn-icon { background:none; border:none; cursor:pointer; font-size:18px; color:var(--muted); padding:2px 6px; }
.modal-header .btn-icon:hover { color:var(--text); }
.modal-body { flex:1; overflow-y:auto; padding:18px; }
.modal-footer { display:flex; gap:8px; justify-content:flex-end; padding:12px 18px; border-top:1px solid var(--border); }

.field-grid { display:grid; grid-template-columns:1fr 1fr; gap:10px 14px; }
.field-full { grid-column:1/-1; }
.field-group { margin-bottom:18px; }
.field-group-title { font-size:11px; font-weight:700; color:var(--primary); letter-spacing:.3px;
  padding-bottom:6px; border-bottom:1px solid var(--border); margin-bottom:10px; }
.f-label { font-size:11px; color:var(--muted); font-weight:600; margin-bottom:3px; }
.f-input { width:100%; padding:6px 9px; border:1px solid var(--border); border-radius:6px;
  font-size:12px; color:var(--text); background:var(--white); outline:none; box-sizing:border-box; }
.f-input:focus { border-color:var(--primary); }
.f-input[readonly] { background:var(--bg); }
.f-select { width:100%; padding:6px 9px; border:1px solid var(--border); border-radius:6px;
  font-size:12px; color:var(--text); background:var(--white); outline:none; box-sizing:border-box; }
.badge-new  { background:#EBF8FF; color:var(--primary); border:1px solid var(--primary-m);
  padding:2px 8px; border-radius:10px; font-size:11px; font-weight:600; }
.badge-edit { background:#FFFAF0; color:var(--orange); border:1px solid #FBD38D;
  padding:2px 8px; border-radius:10px; font-size:11px; font-weight:600; }
.dblclick-hint { font-size:10px; color:var(--muted); margin-left:6px; font-style:italic; }
</style>

<div class="toast-wrap"><div class="toast" id="toast"></div></div>

<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">측정기기 기준 정보</div>
      <div class="page-sub">측정기기 등록 · 수정 · 조회</div>
    </div>
    <button class="btn-primary btn-sm" onclick="newForm()" data-perm="add">＋ 신규 등록</button>
  </div>

  <div class="list-panel card" style="padding:14px">
    <div class="search-bar">
      <label>측정기기명</label>
      <input class="f-input" id="kwTerName" style="width:140px" placeholder="기기명 검색" onkeydown="if(event.key==='Enter')searchList()">
      <label>관리번호</label>
      <input class="f-input" id="kwTerNo" style="width:120px" placeholder="관리번호 검색" onkeydown="if(event.key==='Enter')searchList()">
      <label>종류</label>
      <input class="f-input" id="kwTerKind" style="width:100px" placeholder="종류 검색" onkeydown="if(event.key==='Enter')searchList()">
      <button class="btn-primary btn-sm" onclick="searchList()">조회</button>
      <span class="dblclick-hint">※ 더블클릭으로 수정</span>
    </div>

    <div class="ter-table-wrap">
      <table class="ter-table">
        <thead>
          <tr>
            <th style="width:100px">측정기기코드</th>
            <th style="width:180px">측정기기명</th>
            <th style="width:120px">관리번호</th>
            <th style="width:150px">모델</th>
            <th style="width:100px">종류</th>
            <th style="width:90px">담당자</th>
            <th>비고</th>
          </tr>
        </thead>
        <tbody id="terTableBody">
          <tr><td colspan="7" style="text-align:center;padding:40px;color:var(--muted)">조회 버튼을 누르세요</td></tr>
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
      <span class="modal-title" id="modalTitle">측정기기 등록</span>
      <button class="btn-icon" onclick="closeModal()">✕</button>
    </div>

    <div class="modal-body">
      <div class="field-group">
        <div class="field-group-title">기본정보</div>
        <div class="field-grid">
          <div>
            <div class="f-label">측정기기코드</div>
            <input class="f-input" id="f_ter_code" readonly placeholder="자동 생성" style="background:var(--bg);color:var(--muted)">
          </div>
          <div>
            <div class="f-label">측정기기명 <span style="color:var(--red)">*</span></div>
            <input class="f-input" id="f_ter_name" maxlength="50">
          </div>
          <div>
            <div class="f-label">관리번호</div>
            <input class="f-input" id="f_ter_no" maxlength="30">
          </div>
          <div>
            <div class="f-label">모델</div>
            <input class="f-input" id="f_ter_model" maxlength="50">
          </div>
          <div>
            <div class="f-label">종류</div>
            <input class="f-input" id="f_ter_kind" maxlength="30" placeholder="예: 버니어캘리퍼스, 마이크로미터">
          </div>
          <div>
            <div class="f-label">담당자</div>
            <input class="f-input" id="f_ter_man" maxlength="30">
          </div>
          <div class="field-full">
            <div class="f-label">비고</div>
            <textarea class="f-input" id="f_ter_bigo" rows="3" style="resize:vertical;font-family:inherit" maxlength="200"></textarea>
          </div>
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
  var n=encodeURIComponent(document.getElementById('kwTerName').value.trim());
  var no=encodeURIComponent(document.getElementById('kwTerNo').value.trim());
  var k=encodeURIComponent(document.getElementById('kwTerKind').value.trim());
  fetch(base+'/tester/list?kwTerName='+n+'&kwTerNo='+no+'&kwTerKind='+k+'&page='+curPage+'&pageSize='+pageSize)
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success===false){ showToast(d.error,'toast-error'); return; }
      renderTable(d.list||[]);
      renderPaging(d.total||0, d.totalPage||1);
      document.getElementById('totalCount').textContent='총 '+(d.total||0)+'건';
    });
}

function renderTable(list){
  var tbody=document.getElementById('terTableBody');
  if(!list.length){ tbody.innerHTML='<tr><td colspan="7" style="text-align:center;padding:40px;color:var(--muted)">데이터 없음</td></tr>'; return; }
  tbody.innerHTML=list.map(function(t){
    var sel=(t.ter_code===selCode)?' selected':'';
    return '<tr class="'+sel+'" onclick="clickRow(\''+esc(t.ter_code)+'\')" ondblclick="dblSelectRow(\''+esc(t.ter_code)+'\')">'
      +'<td>'+esc(t.ter_code||'')+'</td>'
      +'<td>'+esc(t.ter_name||'')+'</td>'
      +'<td>'+esc(t.ter_no||'')+'</td>'
      +'<td>'+esc(t.ter_model||'')+'</td>'
      +'<td>'+esc(t.ter_kind||'')+'</td>'
      +'<td>'+esc(t.ter_man||'')+'</td>'
      +'<td>'+esc(t.ter_bigo||'')+'</td>'
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

function clickRow(terCode){
  selCode=terCode;
  document.querySelectorAll('#terTableBody tr').forEach(function(tr){
    var first=tr.querySelector('td');
    tr.classList.toggle('selected', first&&first.textContent===terCode);
  });
}

function dblSelectRow(terCode){
  selCode=terCode;
  clickRow(terCode);
  fetch(base+'/tester/detail?terCode='+encodeURIComponent(terCode))
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success===false){ showToast(d.error,'toast-error'); return; }
      fillForm(d);
      setMode('edit');
      openModal();
    });
}

var FIELDS=['ter_code','ter_name','ter_no','ter_model','ter_kind','ter_man','ter_bigo'];

function fillForm(d){
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) el.value=d[f]||''; });
}
function collectForm(){
  var obj={};
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) obj[f]=el.value||null; });
  return obj;
}

function newForm(){
  selCode=null;
  document.querySelectorAll('#terTableBody tr').forEach(function(tr){ tr.classList.remove('selected'); });
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) el.value=''; });
  setMode('new'); openModal();
  setTimeout(function(){ document.getElementById('f_ter_name').focus(); },100);
}

function saveForm(){
  var data=collectForm();
  if(!data.ter_name||!data.ter_name.trim()){ showToast('측정기기명을 입력하세요.','toast-error'); return; }
  var isNew=!data.ter_code;
  fetch(base+'/tester/save',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(data)})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){ selCode=d.terCode; closeModal(); loadList(); showToast(isNew?'등록되었습니다.':'수정되었습니다.'); }
      else { showToast(d.error||'저장 실패','toast-error'); }
    });
}

function deleteForm(){
  if(!selCode){ showToast('삭제할 측정기기를 선택하세요.','toast-error'); return; }
  if(!confirm('['+selCode+'] 측정기기를 삭제하시겠습니까?')) return;
  fetch(base+'/tester/delete',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({terCode:selCode})})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){ selCode=null; closeModal(); loadList(); showToast('삭제되었습니다.'); }
      else { showToast(d.error||'삭제 실패','toast-error'); }
    });
}

function setMode(mode){
  var badge=document.getElementById('formModeBadge'), btnDel=document.getElementById('btnDelete'), title=document.getElementById('modalTitle');
  if(mode==='new'){ badge.textContent='신규'; badge.className='badge-new'; title.textContent='측정기기 등록'; btnDel.style.display='none'; }
  else            { badge.textContent='수정'; badge.className='badge-edit'; title.textContent='측정기기 수정'; btnDel.style.display=''; }
}

function esc(s){ return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }

document.addEventListener('keydown',function(e){ if(e.key==='Escape') closeModal(); });

loadList();
</script>
</body>
</html>
