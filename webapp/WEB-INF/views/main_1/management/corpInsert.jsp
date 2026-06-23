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
.search-bar { display:flex; gap:6px; align-items:center; }
.search-bar label { font-size:11px; color:var(--muted); font-weight:600; white-space:nowrap; }
.corp-table-wrap { flex:1; overflow-y:auto; border:1px solid var(--border); border-radius:8px; }
.corp-table { width:100%; border-collapse:collapse; font-size:12px; }
.corp-table th { background:var(--bg); color:var(--muted); font-size:11px; font-weight:600;
  padding:8px 10px; border-bottom:2px solid var(--border); position:sticky; top:0; z-index:1; text-align:left; }
.corp-table td { padding:8px 10px; border-bottom:1px solid var(--border); cursor:pointer;
  white-space:nowrap; overflow:hidden; text-overflow:ellipsis; max-width:160px; }
.corp-table tr:last-child td { border-bottom:none; }
.corp-table tbody tr:hover { background:var(--primary-l); }
.corp-table tbody tr.selected { background:#EBF8FF; font-weight:600; }
.pagination-wrap { display:flex; align-items:center; justify-content:center; gap:4px; padding-top:4px; }
.pg-btn { width:28px; height:28px; border-radius:5px; border:1px solid var(--border);
  background:var(--white); cursor:pointer; font-size:12px; }
.pg-btn:hover,.pg-btn.active { background:var(--primary); color:#fff; border-color:var(--primary); }

.modal-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,.45); z-index:1000; align-items:center; justify-content:center; }
.modal-overlay.open { display:flex; }
.modal-box { background:var(--white); border-radius:12px; width:760px; max-width:96vw;
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
      <div class="page-title">거래처 기준 정보</div>
      <div class="page-sub">거래처 등록 · 수정 · 조회</div>
    </div>
    <button class="btn-primary btn-sm" onclick="newForm()" data-perm="add">＋ 신규 등록</button>
  </div>

  <div class="list-panel card" style="padding:14px">
    <div class="search-bar">
      <label>거래처명</label>
      <input class="f-input" id="kwCorpName" style="width:200px" placeholder="거래처명 검색" onkeydown="if(event.key==='Enter')searchList()">
      <button class="btn-primary btn-sm" onclick="searchList()">조회</button>
      <span class="dblclick-hint">※ 더블클릭으로 수정</span>
    </div>

    <div class="corp-table-wrap">
      <table class="corp-table">
        <thead>
          <tr>
            <th style="width:100px">거래처코드</th>
            <th style="width:160px">거래처명</th>
            <th style="width:80px">구분</th>
            <th style="width:130px">전화번호</th>
            <th style="width:90px">대표자</th>
            <th style="width:90px">업태</th>
            <th style="width:90px">업종</th>
            <th style="width:130px">휴대폰</th>
            <th>이메일</th>
          </tr>
        </thead>
        <tbody id="corpTableBody">
          <tr><td colspan="9" style="text-align:center;padding:40px;color:var(--muted)">조회 버튼을 누르세요</td></tr>
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
      <span class="modal-title" id="modalTitle">거래처 등록</span>
      <button class="btn-icon" onclick="closeModal()">✕</button>
    </div>

    <div class="modal-body">

      <div class="field-group">
        <div class="field-group-title">기본정보</div>
        <div class="field-grid">
          <div>
            <div class="f-label">거래처코드</div>
            <input class="f-input" id="f_corp_code" readonly placeholder="자동 생성" style="background:var(--bg);color:var(--muted)">
          </div>
          <div>
            <div class="f-label">구분</div>
            <select class="f-select" id="f_corp_gubn">
              <option value="">선택</option>
              <option value="고객사">고객사</option>
              <option value="협력사">협력사</option>
              <option value="기타">기타</option>
            </select>
          </div>
          <div>
            <div class="f-label">거래처명 <span style="color:var(--red)">*</span></div>
            <input class="f-input" id="f_corp_name" maxlength="50">
          </div>
          <div>
            <div class="f-label">거래처명2 (약칭)</div>
            <input class="f-input" id="f_corp_name2" maxlength="50">
          </div>
          <div>
            <div class="f-label">사업자번호</div>
            <input class="f-input" id="f_corp_no" maxlength="50" placeholder="000-00-00000">
          </div>
          <div>
            <div class="f-label">사업자등록 (BUSINESS)</div>
            <input class="f-input" id="f_corp_business" maxlength="50">
          </div>
          <div>
            <div class="f-label">업태</div>
            <input class="f-input" id="f_corp_upte" maxlength="50">
          </div>
          <div>
            <div class="f-label">업종</div>
            <input class="f-input" id="f_corp_upjo" maxlength="50">
          </div>
        </div>
      </div>

      <div class="field-group">
        <div class="field-group-title">연락처</div>
        <div class="field-grid">
          <div>
            <div class="f-label">전화번호</div>
            <input class="f-input" id="f_corp_tel" maxlength="50">
          </div>
          <div>
            <div class="f-label">팩스</div>
            <input class="f-input" id="f_corp_fax" maxlength="50">
          </div>
          <div>
            <div class="f-label">휴대폰</div>
            <input class="f-input" id="f_corp_hp" maxlength="30">
          </div>
          <div>
            <div class="f-label">이메일</div>
            <input class="f-input" id="f_corp_mail" maxlength="200" type="email">
          </div>
          <div>
            <div class="f-label">대표자</div>
            <input class="f-input" id="f_corp_boss" maxlength="50">
          </div>
          <div>
            <div class="f-label">담당자</div>
            <input class="f-input" id="f_corp_mast" maxlength="50">
          </div>
          <div>
            <div class="f-label">영업담당</div>
            <input class="f-input" id="f_corp_bman" maxlength="20">
          </div>
          <div>
            <div class="f-label">지역</div>
            <input class="f-input" id="f_corp_plc" maxlength="50">
          </div>
          <div class="field-full">
            <div class="f-label">주소</div>
            <input class="f-input" id="f_corp_add" maxlength="255">
          </div>
        </div>
      </div>

      <div class="field-group">
        <div class="field-group-title">거래정보</div>
        <div class="field-grid">
          <div>
            <div class="f-label">결제일 시작 (STRT)</div>
            <input class="f-input" id="f_corp_strt" maxlength="30">
          </div>
          <div>
            <div class="f-label">결제구분1</div>
            <input class="f-input" id="f_corp_gyul1" maxlength="1">
          </div>
          <div>
            <div class="f-label">결제구분2</div>
            <input class="f-input" id="f_corp_gyul2" maxlength="10">
          </div>
          <div>
            <div class="f-label">잔액 (JAN)</div>
            <input class="f-input" id="f_corp_jan" maxlength="18">
          </div>
          <div>
            <div class="f-label">계좌번호</div>
            <input class="f-input" id="f_corp_cno" maxlength="50">
          </div>
          <div>
            <div class="f-label">비밀번호</div>
            <input class="f-input" id="f_corp_pwd" maxlength="50" type="password">
          </div>
        </div>
      </div>

      <div class="field-group">
        <div class="field-group-title">비고</div>
        <textarea class="f-input" id="f_corp_bigo" rows="3" style="resize:vertical;font-family:inherit" maxlength="100"></textarea>
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
  var t = document.getElementById('toast');
  t.textContent = msg;
  t.className = 'toast ' + (type||'toast-success');
  clearTimeout(toastTimer);
  setTimeout(function(){ t.classList.add('show'); }, 10);
  toastTimer = setTimeout(function(){ t.classList.remove('show'); }, 2500);
}

function openModal(){ document.getElementById('modalOverlay').classList.add('open'); document.body.style.overflow='hidden'; }
function closeModal(){ document.getElementById('modalOverlay').classList.remove('open'); document.body.style.overflow=''; }

function searchList(){ curPage=1; loadList(); }

function loadList(){
  var n = encodeURIComponent(document.getElementById('kwCorpName').value.trim());
  fetch(base+'/corp/list?kwCorpName='+n+'&page='+curPage+'&pageSize='+pageSize)
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success===false){ showToast(d.error,'toast-error'); return; }
      renderTable(d.list||[]);
      renderPaging(d.total||0, d.totalPage||1);
      document.getElementById('totalCount').textContent='총 '+(d.total||0)+'건';
    });
}

function renderTable(list){
  var tbody = document.getElementById('corpTableBody');
  if(!list.length){ tbody.innerHTML='<tr><td colspan="9" style="text-align:center;padding:40px;color:var(--muted)">데이터 없음</td></tr>'; return; }
  tbody.innerHTML = list.map(function(c){
    var sel = (c.corp_code===selCode)?' selected':'';
    return '<tr class="'+sel+'" onclick="clickRow(\''+esc(c.corp_code)+'\')" ondblclick="dblSelectRow(\''+esc(c.corp_code)+'\')">'
      +'<td>'+esc(c.corp_code||'')+'</td>'
      +'<td>'+esc(c.corp_name||'')+'</td>'
      +'<td>'+esc(c.corp_gubn||'')+'</td>'
      +'<td>'+esc(c.corp_tel||'')+'</td>'
      +'<td>'+esc(c.corp_boss||'')+'</td>'
      +'<td>'+esc(c.corp_upte||'')+'</td>'
      +'<td>'+esc(c.corp_upjo||'')+'</td>'
      +'<td>'+esc(c.corp_hp||'')+'</td>'
      +'<td>'+esc(c.corp_mail||'')+'</td>'
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

function clickRow(corpCode){
  selCode=corpCode;
  document.querySelectorAll('#corpTableBody tr').forEach(function(tr){
    var first=tr.querySelector('td');
    tr.classList.toggle('selected', first&&first.textContent===corpCode);
  });
}

function dblSelectRow(corpCode){
  selCode=corpCode;
  clickRow(corpCode);
  fetch(base+'/corp/detail?corpCode='+encodeURIComponent(corpCode))
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success===false){ showToast(d.error,'toast-error'); return; }
      fillForm(d);
      setMode('edit');
      openModal();
    });
}

var FIELDS = ['corp_code','corp_name','corp_name2','corp_no','corp_tel','corp_fax',
  'corp_boss','corp_mast','corp_upte','corp_upjo','corp_add','corp_plc','corp_bigo',
  'corp_jan','corp_strt','corp_gyul1','corp_gyul2','corp_gubn','corp_bman',
  'corp_hp','corp_cno','corp_pwd','corp_mail','corp_business'];

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
  document.querySelectorAll('#corpTableBody tr').forEach(function(tr){ tr.classList.remove('selected'); });
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) el.value=''; });
  setMode('new');
  openModal();
  setTimeout(function(){ document.getElementById('f_corp_name').focus(); },100);
}

function saveForm(){
  var data=collectForm();
  if(!data.corp_name||!data.corp_name.trim()){ showToast('거래처명을 입력하세요.','toast-error'); return; }
  var isNew = !data.corp_code;
  fetch(base+'/corp/save',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(data)})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){ selCode=d.corpCode; closeModal(); loadList(); showToast(isNew?'등록되었습니다.':'수정되었습니다.'); }
      else { showToast(d.error||'저장 실패','toast-error'); }
    });
}

function deleteForm(){
  if(!selCode){ showToast('삭제할 거래처를 선택하세요.','toast-error'); return; }
  if(!confirm('['+selCode+'] 거래처를 삭제하시겠습니까?')) return;
  fetch(base+'/corp/delete',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({corpCode:selCode})})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){ selCode=null; closeModal(); loadList(); showToast('삭제되었습니다.'); }
      else { showToast(d.error||'삭제 실패','toast-error'); }
    });
}

function setMode(mode){
  var badge=document.getElementById('formModeBadge'), btnDel=document.getElementById('btnDelete'), title=document.getElementById('modalTitle');
  if(mode==='new'){ badge.textContent='신규'; badge.className='badge-new'; title.textContent='거래처 등록'; btnDel.style.display='none'; }
  else            { badge.textContent='수정'; badge.className='badge-edit'; title.textContent='거래처 수정'; btnDel.style.display=''; }
}

function esc(s){ return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }

document.addEventListener('keydown',function(e){ if(e.key==='Escape') closeModal(); });

loadList();
</script>
</body>
</html>
