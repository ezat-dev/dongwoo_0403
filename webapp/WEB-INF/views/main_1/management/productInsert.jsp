<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common_style.jsp" %>
<style>
/* ── 토스트 ── */
.toast-wrap { position:fixed; top:20px; left:50%; transform:translateX(-50%); z-index:9999; pointer-events:none; }
.toast { background:#2D3748; color:#fff; padding:10px 22px; border-radius:8px; font-size:13px; font-weight:600;
  box-shadow:0 4px 16px rgba(0,0,0,.2); opacity:0; transform:translateY(-12px);
  transition:opacity .25s, transform .25s; white-space:nowrap; }
.toast.toast-success { background:#38A169; }
.toast.toast-error   { background:#E53E3E; }
.toast.show { opacity:1; transform:translateY(0); }

/* ── 목록 ── */
.list-panel { display:flex; flex-direction:column; gap:10px; height:calc(100vh - 130px); }
.search-bar { display:flex; gap:6px; align-items:center; flex-wrap:wrap; }
.search-bar label { font-size:11px; color:var(--muted); font-weight:600; white-space:nowrap; }
.prod-table-wrap { flex:1; overflow-y:auto; border:1px solid var(--border); border-radius:8px; }
.prod-table { width:100%; border-collapse:collapse; font-size:12px; }
.prod-table th { background:var(--bg); color:var(--muted); font-size:11px; font-weight:600;
  padding:8px 10px; border-bottom:2px solid var(--border); position:sticky; top:0; z-index:1; text-align:left; }
.prod-table td { padding:8px 10px; border-bottom:1px solid var(--border); cursor:pointer; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; max-width:140px; }
.prod-table tr:last-child td { border-bottom:none; }
.prod-table tbody tr:hover { background:var(--primary-l); }
.prod-table tbody tr.selected { background:#EBF8FF; font-weight:600; }
.pagination-wrap { display:flex; align-items:center; justify-content:center; gap:4px; padding-top:4px; }
.pg-btn { width:28px; height:28px; border-radius:5px; border:1px solid var(--border);
  background:var(--white); cursor:pointer; font-size:12px; }
.pg-btn:hover,.pg-btn.active { background:var(--primary); color:#fff; border-color:var(--primary); }

/* ── 모달 ── */
.modal-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,.45); z-index:1000; align-items:center; justify-content:center; }
.modal-overlay.open { display:flex; }
.modal-box { background:var(--white); border-radius:12px; width:860px; max-width:96vw;
  max-height:90vh; display:flex; flex-direction:column; box-shadow:0 8px 40px rgba(0,0,0,.2); }
.modal-header { display:flex; align-items:center; gap:10px; padding:14px 18px; border-bottom:1px solid var(--border); }
.modal-header .modal-title { font-size:14px; font-weight:700; flex:1; }
.modal-header .btn-icon { background:none; border:none; cursor:pointer; font-size:18px; color:var(--muted); padding:2px 6px; }
.modal-header .btn-icon:hover { color:var(--text); }
.modal-body { flex:1; overflow-y:auto; padding:0; }
.modal-footer { display:flex; gap:8px; justify-content:flex-end; padding:12px 18px; border-top:1px solid var(--border); }

/* ── 폼 ── */
.tab-row { display:flex; border-bottom:2px solid var(--border); padding:0 18px; }
.tab-item { padding:10px 18px; font-size:12px; font-weight:600; cursor:pointer;
  color:var(--muted); border-bottom:2px solid transparent; margin-bottom:-2px; }
.tab-item.active { color:var(--primary); border-bottom-color:var(--primary); }
.tab-content { padding:16px 18px; }
.tab-pane { display:none; }
.tab-pane.active { display:block; }
.field-grid { display:grid; grid-template-columns:1fr 1fr; gap:10px 14px; }
.field-grid-3 { display:grid; grid-template-columns:1fr 1fr 1fr; gap:10px 14px; }
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
.range-pair { display:flex; align-items:center; gap:4px; }
.range-pair input { flex:1; }
.range-pair span { font-size:11px; color:var(--muted); white-space:nowrap; }
.badge-new  { background:#EBF8FF; color:var(--primary); border:1px solid var(--primary-m);
  padding:2px 8px; border-radius:10px; font-size:11px; font-weight:600; }
.badge-edit { background:#FFFAF0; color:var(--orange); border:1px solid #FBD38D;
  padding:2px 8px; border-radius:10px; font-size:11px; font-weight:600; }
.dblclick-hint { font-size:10px; color:var(--muted); margin-left:6px; font-style:italic; }

/* ── 리스트 사진 썸네일 ── */
.thumb-cell { width:56px; padding:3px 6px !important; }
.thumb-img  { width:46px; height:34px; object-fit:cover; border-radius:4px;
  border:1px solid var(--border); display:block; background:var(--bg); cursor:zoom-in; }
.thumb-none { width:46px; height:34px; background:var(--bg); border-radius:4px;
  border:1px dashed var(--border); display:flex; align-items:center; justify-content:center;
  font-size:14px; opacity:.25; }

/* ── 이미지 패널 ── */
.img-panel { display:flex; gap:16px; padding:12px 18px; border-bottom:1px solid var(--border); background:var(--bg); flex-wrap:wrap; align-items:flex-start; }
.img-slot { display:flex; flex-direction:column; align-items:center; gap:5px; }
.img-slot-label { font-size:10px; color:var(--muted); font-weight:700; letter-spacing:.3px; text-align:center; }
.img-box { width:120px; height:90px; border:2px dashed var(--border); border-radius:8px;
  display:flex; align-items:center; justify-content:center; overflow:hidden;
  cursor:pointer; transition:border-color .2s, box-shadow .2s; background:var(--white); }
.img-box:hover { border-color:var(--primary); box-shadow:0 2px 8px rgba(0,0,0,.08); }
.img-box img { width:100%; height:100%; object-fit:cover; display:none; }
.img-empty { display:flex; flex-direction:column; align-items:center; gap:3px; pointer-events:none; }
.img-empty-icon { font-size:22px; opacity:.3; }
.img-empty-text { font-size:9px; color:var(--muted); }
.img-slot-btns { display:flex; gap:4px; }
.img-slot-btns button { font-size:10px; padding:2px 7px; line-height:1.4; }
</style>

<!-- 토스트 -->
<div class="toast-wrap"><div class="toast" id="toast"></div></div>

<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">제품 기준 정보</div>
      <div class="page-sub">제품 등록 · 수정 · 조회</div>
    </div>
    <button class="btn-primary btn-sm" onclick="newForm()" data-perm="add">＋ 신규 등록</button>
  </div>

  <div class="list-panel card" style="padding:14px">
    <div class="search-bar">
      <label>품명</label>
      <input class="f-input" id="kwProdName" style="width:150px" placeholder="품명 검색" onkeydown="if(event.key==='Enter')searchList()">
      <label>품번</label>
      <input class="f-input" id="kwProdNo" style="width:150px" placeholder="품번 검색" onkeydown="if(event.key==='Enter')searchList()">
      <label>거래처</label>
      <input class="f-input" id="kwCorpName" style="width:150px" placeholder="거래처명 검색" onkeydown="if(event.key==='Enter')searchList()">
      <button class="btn-primary btn-sm" onclick="searchList()">조회</button>
      <span class="dblclick-hint">※ 더블클릭으로 수정</span>
    </div>

    <div class="prod-table-wrap">
      <table class="prod-table">
        <thead>
          <tr>
            <th class="thumb-cell">사진</th>
            <th style="width:110px">제품코드</th>
            <th style="width:130px">품명</th>
            <th style="width:110px">품번</th>
            <th style="width:110px">거래처</th>
            <th style="width:120px">규격</th>
            <th style="width:80px">재질</th>
            <th style="width:70px">단중</th>
            <th style="width:60px">단위</th>
            <th style="width:90px;text-align:right">단가</th>
            <th style="width:60px">구분</th>
          </tr>
        </thead>
        <tbody id="prodTableBody">
          <tr><td colspan="11" style="text-align:center;padding:40px;color:var(--muted)">조회 버튼을 누르세요</td></tr>
        </tbody>
      </table>
    </div>

    <div style="display:flex;align-items:center;justify-content:space-between">
      <span style="font-size:11px;color:var(--muted)" id="totalCount">총 0건</span>
      <div class="pagination-wrap" id="pagination"></div>
    </div>
  </div>
</div>

<!-- 거래처 검색 서브모달 -->
<div class="modal-overlay" id="corpSearchOverlay" onclick="if(event.target===this)closeCorpSearch()" style="z-index:1100">
  <div class="modal-box" style="width:640px;max-height:70vh">
    <div class="modal-header">
      <span class="modal-title">거래처 검색</span>
      <button class="btn-icon" onclick="closeCorpSearch()">✕</button>
    </div>
    <div style="padding:12px 18px;border-bottom:1px solid var(--border);display:flex;gap:6px">
      <input class="f-input" id="corpSearchKw" placeholder="거래처명 검색" onkeydown="if(event.key==='Enter')searchCorpList()">
      <button class="btn-primary btn-sm" onclick="searchCorpList()">조회</button>
    </div>
    <div style="overflow-y:auto;max-height:420px">
      <table class="prod-table">
        <thead>
          <tr>
            <th style="width:100px">거래처코드</th>
            <th>거래처명</th>
            <th style="width:80px">구분</th>
            <th style="width:130px">전화번호</th>
            <th style="width:80px">대표자</th>
          </tr>
        </thead>
        <tbody id="corpSearchBody">
          <tr><td colspan="5" style="text-align:center;padding:30px;color:var(--muted)">로딩 중…</td></tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- 등록/수정 모달 -->
<div class="modal-overlay" id="modalOverlay" onclick="if(event.target===this)closeModal()">
  <div class="modal-box">
    <div class="modal-header">
      <span id="formModeBadge" class="badge-new">신규</span>
      <span class="modal-title" id="modalTitle">제품 등록</span>
      <button class="btn-icon" onclick="closeModal()">✕</button>
    </div>

    <div class="tab-row">
      <div class="tab-item active" onclick="switchTab(0,this)">기본정보</div>
      <div class="tab-item" onclick="switchTab(1,this)">열처리 조건</div>
      <div class="tab-item" onclick="switchTab(2,this)">포장/후처리</div>
      <div class="tab-item" onclick="switchTab(3,this)">치수</div>
      <div class="tab-item" onclick="switchTab(4,this)">기타</div>
    </div>

    <!-- 이미지 패널 -->
    <div class="img-panel">
      <div class="img-slot">
        <div class="img-slot-label">제품사진</div>
        <div class="img-box" id="imgBox_product">
          <img id="imgPrev_product" alt="제품사진">
          <div class="img-empty" id="imgEmpty_product"><span class="img-empty-icon">🖼</span><span class="img-empty-text">클릭하여 업로드</span></div>
        </div>
        <div class="img-slot-btns">
          <input type="file" id="imgFile_product" accept="image/*,.pdf" style="display:none" onchange="uploadProdImage(this,'product')">
          <button class="btn-outline btn-sm" onclick="triggerImgInput('imgFile_product')" type="button">업로드</button>
          <button class="btn-outline btn-sm" onclick="clearProdImage('product')" type="button" style="color:var(--red);border-color:var(--red)">✕</button>
        </div>
      </div>
      <div class="img-slot">
        <div class="img-slot-label">외형사진</div>
        <div class="img-box" id="imgBox_apperance">
          <img id="imgPrev_apperance" alt="외형사진">
          <div class="img-empty" id="imgEmpty_apperance"><span class="img-empty-icon">🖼</span><span class="img-empty-text">클릭하여 업로드</span></div>
        </div>
        <div class="img-slot-btns">
          <input type="file" id="imgFile_apperance" accept="image/*,.pdf" style="display:none" onchange="uploadProdImage(this,'apperance')">
          <button class="btn-outline btn-sm" onclick="triggerImgInput('imgFile_apperance')" type="button">업로드</button>
          <button class="btn-outline btn-sm" onclick="clearProdImage('apperance')" type="button" style="color:var(--red);border-color:var(--red)">✕</button>
        </div>
      </div>
      <div class="img-slot">
        <div class="img-slot-label">열처리사진</div>
        <div class="img-box" id="imgBox_heat">
          <img id="imgPrev_heat" alt="열처리사진">
          <div class="img-empty" id="imgEmpty_heat"><span class="img-empty-icon">🖼</span><span class="img-empty-text">클릭하여 업로드</span></div>
        </div>
        <div class="img-slot-btns">
          <input type="file" id="imgFile_heat" accept="image/*,.pdf" style="display:none" onchange="uploadProdImage(this,'heat')">
          <button class="btn-outline btn-sm" onclick="triggerImgInput('imgFile_heat')" type="button">업로드</button>
          <button class="btn-outline btn-sm" onclick="clearProdImage('heat')" type="button" style="color:var(--red);border-color:var(--red)">✕</button>
        </div>
      </div>
      <div class="img-slot">
        <div class="img-slot-label">도면</div>
        <div class="img-box" id="imgBox_drawing">
          <img id="imgPrev_drawing" alt="도면">
          <div class="img-empty" id="imgEmpty_drawing"><span class="img-empty-icon">📄</span><span class="img-empty-text">클릭하여 업로드</span></div>
        </div>
        <div class="img-slot-btns">
          <input type="file" id="imgFile_drawing" accept="image/*,.pdf" style="display:none" onchange="uploadProdImage(this,'drawing')">
          <button class="btn-outline btn-sm" onclick="triggerImgInput('imgFile_drawing')" type="button">업로드</button>
          <button class="btn-outline btn-sm" onclick="clearProdImage('drawing')" type="button" style="color:var(--red);border-color:var(--red)">✕</button>
        </div>
      </div>
    </div>

    <div class="modal-body">
      <div class="tab-content">

        <!-- 탭1: 기본정보 -->
        <div class="tab-pane active" id="tab0">
          <div class="field-group">
            <div class="field-grid">
              <div>
                <div class="f-label">제품코드</div>
                <input class="f-input" id="f_prod_code" readonly placeholder="자동 생성" style="background:var(--bg);color:var(--muted)">
              </div>
              <div class="field-full">
                <div class="f-label">거래처</div>
                <div style="display:flex;gap:6px;align-items:center">
                  <input class="f-input" id="f_corp_code" readonly placeholder="코드" style="width:90px;flex-shrink:0;background:var(--bg);color:var(--muted)">
                  <input class="f-input" id="f_corp_name_disp" readonly placeholder="거래처명" style="flex:1;background:var(--bg)">
                  <button class="btn-outline btn-sm" onclick="openCorpSearch()" type="button" style="white-space:nowrap;flex-shrink:0">거래처 검색</button>
                </div>
              </div>
              <div>
                <div class="f-label">품명</div>
                <input class="f-input" id="f_prod_name" maxlength="100">
              </div>
              <div>
                <div class="f-label">품번</div>
                <input class="f-input" id="f_prod_no" maxlength="30">
              </div>
              <div>
                <div class="f-label">규격</div>
                <input class="f-input" id="f_prod_gyu" maxlength="50">
              </div>
              <div>
                <div class="f-label">재질</div>
                <input class="f-input" id="f_prod_jai" maxlength="30">
              </div>
              <div>
                <div class="f-label">단중</div>
                <input class="f-input" id="f_prod_danj" maxlength="30">
              </div>
              <div>
                <div class="f-label">단위</div>
                <input class="f-input" id="f_prod_danw" maxlength="30">
              </div>
              <div>
                <div class="f-label">단가</div>
                <input class="f-input" id="f_prod_dang" maxlength="30">
              </div>
              <div>
                <div class="f-label">주문번호</div>
                <input class="f-input" id="f_prod_cno" maxlength="30">
              </div>
              <div>
                <div class="f-label">구분</div>
                <select class="f-select" id="f_prod_gubn">
                  <option value="">선택</option>
                  <option value="양산">양산</option>
                  <option value="개발">개발</option>
                </select>
              </div>
              <div>
                <div class="f-label">업종</div>
                <select class="f-select" id="f_prod_upjong">
                  <option value="">선택</option>
                  <option value="자동차">자동차</option>
                  <option value="선박">선박</option>
                  <option value="유압">유압</option>
                  <option value="방산">방산</option>
                  <option value="기타">기타</option>
                </select>
              </div>
              <div>
                <div class="f-label">모델</div>
                <input class="f-input" id="f_prod_model" maxlength="50">
              </div>
              <div>
                <div class="f-label">등록일</div>
                <input class="f-input" id="f_prod_date" type="date">
              </div>
            </div>
            <div style="margin-top:10px">
              <div class="f-label">비고</div>
              <textarea class="f-input" id="f_prod_note" rows="2" style="resize:vertical;font-family:inherit" maxlength="500"></textarea>
            </div>
          </div>
        </div>

        <!-- 탭2: 열처리 조건 -->
        <div class="tab-pane" id="tab1">
          <div class="field-group">
            <div class="field-group-title">표면경도</div>
            <div class="field-grid">
              <div>
                <div class="f-label">종류 (PROD_PG)</div>
                <select class="f-select" id="f_prod_pg">
                  <option value="">선택</option>
                  <option>HRC</option><option>HV</option><option>HS</option>
                  <option>HRA</option><option>HRB</option><option>HB</option>
                  <option>HR15N</option><option>HR30N</option><option>HR45N</option>
                </select>
              </div>
              <div>
                <div class="f-label">수치 범위</div>
                <div class="range-pair">
                  <input class="f-input" id="f_prod_pg1" maxlength="50" placeholder="시작">
                  <span>~</span>
                  <input class="f-input" id="f_prod_pg2" maxlength="50" placeholder="종료">
                </div>
              </div>
              <div>
                <div class="f-label">종류 (PROD_PGS)</div>
                <input class="f-input" id="f_prod_pgs" maxlength="50">
              </div>
              <div>
                <div class="f-label">수치 범위 (PGS)</div>
                <div class="range-pair">
                  <input class="f-input" id="f_prod_pgs1" maxlength="50" placeholder="시작">
                  <span>~</span>
                  <input class="f-input" id="f_prod_pgs2" maxlength="50" placeholder="종료">
                </div>
              </div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">심부경도</div>
            <div class="field-grid">
              <div>
                <div class="f-label">종류 (PROD_SG)</div>
                <select class="f-select" id="f_prod_sg">
                  <option value="">선택</option>
                  <option>HRC</option><option>HV</option><option>HRA</option>
                  <option>HRB</option><option>HB</option>
                </select>
              </div>
              <div>
                <div class="f-label">수치 범위</div>
                <div class="range-pair">
                  <input class="f-input" id="f_prod_sg1" maxlength="50" placeholder="시작">
                  <span>~</span>
                  <input class="f-input" id="f_prod_sg2" maxlength="50" placeholder="종료">
                </div>
              </div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">소입경도</div>
            <div class="field-grid">
              <div>
                <div class="f-label">종류 (PROD_SI)</div>
                <select class="f-select" id="f_prod_si">
                  <option value="">선택</option>
                  <option>HRC</option><option>HV</option><option>HS</option>
                  <option>HRA</option><option>HRB</option><option>HB</option>
                  <option>HR15N</option><option>HR30N</option><option>HR45N</option>
                </select>
              </div>
              <div>
                <div class="f-label">수치 범위</div>
                <div class="range-pair">
                  <input class="f-input" id="f_prod_si1" maxlength="50" placeholder="시작">
                  <span>~</span>
                  <input class="f-input" id="f_prod_si2" maxlength="50" placeholder="종료">
                </div>
              </div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">소려경도</div>
            <div class="field-grid">
              <div>
                <div class="f-label">종류 (PROD_SR)</div>
                <select class="f-select" id="f_prod_sr">
                  <option value="">선택</option>
                  <option>HRC</option><option>HV</option><option>HS</option>
                  <option>HRA</option><option>HRB</option><option>HB</option>
                  <option>HR15N</option><option>HR30N</option><option>HR45N</option>
                </select>
              </div>
              <div>
                <div class="f-label">수치 범위</div>
                <div class="range-pair">
                  <input class="f-input" id="f_prod_sr1" maxlength="50" placeholder="시작">
                  <span>~</span>
                  <input class="f-input" id="f_prod_sr2" maxlength="50" placeholder="종료">
                </div>
              </div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">경화깊이</div>
            <div class="field-grid-3">
              <div>
                <div class="f-label">유효/전경화 (GD1)</div>
                <input class="f-input" id="f_prod_gd1" maxlength="50">
              </div>
              <div>
                <div class="f-label">수치 (GD2)</div>
                <input class="f-input" id="f_prod_gd2" maxlength="50">
              </div>
              <div>
                <div class="f-label">단위 (GD3)</div>
                <select class="f-select" id="f_prod_gd3">
                  <option value="">선택</option><option>HV</option><option>HRC</option>
                </select>
              </div>
              <div>
                <div class="f-label">수치 시작 (GD4)</div>
                <input class="f-input" id="f_prod_gd4" maxlength="50">
              </div>
              <div>
                <div class="f-label">수치 종료 (GD5)</div>
                <input class="f-input" id="f_prod_gd5" maxlength="50">
              </div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">기타 열처리</div>
            <div class="field-grid">
              <div><div class="f-label">금속조직 (GJ)</div><input class="f-input" id="f_prod_gj" maxlength="50"></div>
              <div><div class="f-label">변형량 (BH)</div><input class="f-input" id="f_prod_bh" maxlength="50"></div>
              <div><div class="f-label">DO</div><input class="f-input" id="f_prod_do" maxlength="50"></div>
              <div><div class="f-label">RA</div><input class="f-input" id="f_prod_ra" maxlength="50"></div>
              <div><div class="f-label">연마여유 (POLISH)</div><input class="f-input" id="f_prod_polish" maxlength="50"></div>
              <div><div class="f-label">공정번호 (TECH_NO)</div><input class="f-input" id="f_tech_no" maxlength="10"></div>
              <div><div class="f-label">공정패턴</div><input class="f-input" id="f_tech_pattern" maxlength="50"></div>
              <div><div class="f-label">공정순서</div><input class="f-input" id="f_tech_seq" maxlength="50"></div>
            </div>
          </div>
        </div>

        <!-- 탭3: 포장/후처리 -->
        <div class="tab-pane" id="tab2">
          <div class="field-group">
            <div class="field-group-title">포장</div>
            <div class="field-grid">
              <div><div class="f-label">포장방법 (DANCH)</div><input class="f-input" id="f_prod_danch" maxlength="50"></div>
              <div><div class="f-label">PLT</div><input class="f-input" id="f_prod_plt" maxlength="50"></div>
              <div>
                <div class="f-label">BOX TYPE</div>
                <select class="f-select" id="f_prod_box">
                  <option value="">선택</option><option value="A">A</option><option value="B">B</option>
                </select>
              </div>
              <div><div class="f-label">박스당 수량 (BOXSU)</div><input class="f-input" id="f_prod_boxsu" maxlength="50"></div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">후처리</div>
            <div class="field-grid">
              <div>
                <div class="f-label">열처리 곡선 (SNP)</div>
                <select class="f-select" id="f_prod_snp">
                  <option value="">선택</option><option value="불요">불요</option><option value="필요">필요</option>
                </select>
              </div>
              <div>
                <div class="f-label">방청유 (BANGCH)</div>
                <select class="f-select" id="f_prod_bangch">
                  <option value="">선택</option>
                  <option value="필요없음">필요없음</option><option value="수용성">수용성</option>
                  <option value="유용성">유용성</option><option value="기타">기타</option>
                </select>
              </div>
              <div><div class="f-label">후처리 (VNYL)</div><input class="f-input" id="f_prod_vnyl" maxlength="50" placeholder="불요/쇼트/샌딩 등"></div>
              <div>
                <div class="f-label">시편제목 (PAD)</div>
                <select class="f-select" id="f_prod_pad">
                  <option value="">선택</option>
                  <option value="본품">본품</option><option value="대체시편">대체시편</option>
                  <option value="시편절단">시편절단</option><option value="시편필요없음">시편필요없음</option>
                </select>
              </div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">외관 / 변형</div>
            <div class="field-grid">
              <div><div class="f-label">외관 (APPEAR)</div><input class="f-input" id="f_prod_appear" maxlength="50"></div>
              <div><div class="f-label">변형 (TRANSFORM)</div><input class="f-input" id="f_prod_transform" maxlength="50"></div>
              <div><div class="f-label">실재고현황 (REALJAI)</div><input class="f-input" id="f_prod_realjai" maxlength="50"></div>
            </div>
          </div>
        </div>

        <!-- 탭4: 치수 -->
        <div class="tab-pane" id="tab3">
          <div class="field-group">
            <div class="field-group-title">치수 비교값 (N: 시작, S: 종료)</div>
            <table style="width:100%;border-collapse:collapse;font-size:12px">
              <thead>
                <tr>
                  <th style="padding:6px 8px;background:var(--bg);border:1px solid var(--border);text-align:center;font-size:11px;color:var(--muted)">치수</th>
                  <th style="padding:6px 8px;background:var(--bg);border:1px solid var(--border);text-align:center;font-size:11px;color:var(--muted)">시작값 (N)</th>
                  <th style="padding:6px 8px;background:var(--bg);border:1px solid var(--border);text-align:center;font-size:11px;color:var(--muted)">종료값 (S)</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td style="padding:6px 8px;border:1px solid var(--border);text-align:center;font-weight:600">치수 1</td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu1n" maxlength="50"></td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu1s" maxlength="50"></td>
                </tr>
                <tr>
                  <td style="padding:6px 8px;border:1px solid var(--border);text-align:center;font-weight:600">치수 2</td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu2n" maxlength="50"></td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu2s" maxlength="50"></td>
                </tr>
                <tr>
                  <td style="padding:6px 8px;border:1px solid var(--border);text-align:center;font-weight:600">치수 3</td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu3n" maxlength="50"></td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu3s" maxlength="50"></td>
                </tr>
                <tr>
                  <td style="padding:6px 8px;border:1px solid var(--border);text-align:center;font-weight:600">치수 4</td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu4n" maxlength="50"></td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu4s" maxlength="50"></td>
                </tr>
                <tr>
                  <td style="padding:6px 8px;border:1px solid var(--border);text-align:center;font-weight:600">치수 5</td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu5n" maxlength="50"></td>
                  <td style="padding:4px 6px;border:1px solid var(--border)"><input class="f-input" id="f_prod_chisu5s" maxlength="50"></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- 탭5: 기타 -->
        <div class="tab-pane" id="tab4">
          <div class="field-group">
            <div class="field-group-title">추가 정보</div>
            <div class="field-grid">
              <div><div class="f-label">PROD_CD</div><input class="f-input" id="f_prod_cd" maxlength="50"></div>
              <div><div class="f-label">기종 (KIJONG)</div><input class="f-input" id="f_prod_kijong" maxlength="50"></div>
              <div><div class="f-label">REFNO</div><input class="f-input" id="f_prod_refno" maxlength="50"></div>
              <div><div class="f-label">PWSNO</div><input class="f-input" id="f_prod_pwsno" maxlength="50"></div>
              <div><div class="f-label">WHADEEP</div><input class="f-input" id="f_prod_whadeep" maxlength="50"></div>
              <div><div class="f-label">FILE</div><input class="f-input" id="f_prod_file" maxlength="100"></div>
              <div><div class="f-label">E1</div><input class="f-input" id="f_prod_e1" maxlength="50"></div>
              <div><div class="f-label">E2</div><input class="f-input" id="f_prod_e2" maxlength="50"></div>
              <div><div class="f-label">E3</div><input class="f-input" id="f_prod_e3" maxlength="50"></div>
              <div><div class="f-label">E4</div><input class="f-input" id="f_prod_e4" maxlength="50"></div>
              <div><div class="f-label">E5</div><input class="f-input" id="f_prod_e5" maxlength="50"></div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">FAC 항목</div>
            <div class="field-grid">
              <div><div class="f-label">FAC1</div><input class="f-input" id="f_prod_fac1" maxlength="50"></div>
              <div><div class="f-label">FAC2</div><input class="f-input" id="f_prod_fac2" maxlength="50"></div>
              <div><div class="f-label">FAC3</div><input class="f-input" id="f_prod_fac3" maxlength="50"></div>
              <div><div class="f-label">FAC4</div><input class="f-input" id="f_prod_fac4" maxlength="50"></div>
              <div><div class="f-label">FAC5</div><input class="f-input" id="f_prod_fac5" maxlength="50"></div>
              <div><div class="f-label">FAC6</div><input class="f-input" id="f_prod_fac6" maxlength="50"></div>
              <div><div class="f-label">FAC7</div><input class="f-input" id="f_prod_fac7" maxlength="50"></div>
              <div><div class="f-label">FAC8</div><input class="f-input" id="f_prod_fac8" maxlength="50"></div>
            </div>
          </div>
          <div class="field-group">
            <div class="field-group-title">첨부 파일명 <span style="font-size:10px;font-weight:400;color:var(--muted)">(상단 이미지 패널에서 업로드)</span></div>
            <div class="field-grid">
              <div><div class="f-label">제품 사진</div><input class="f-input" id="f_product_file_name" readonly style="background:var(--bg);color:var(--muted);font-size:10px"></div>
              <div><div class="f-label">외형 사진</div><input class="f-input" id="f_apperance_file_name" readonly style="background:var(--bg);color:var(--muted);font-size:10px"></div>
              <div><div class="f-label">열처리 사진</div><input class="f-input" id="f_heat_file_name" readonly style="background:var(--bg);color:var(--muted);font-size:10px"></div>
              <div><div class="f-label">도면 파일</div><input class="f-input" id="f_drawing_file_name" readonly style="background:var(--bg);color:var(--muted);font-size:10px"></div>
            </div>
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

/* ── 토스트 ── */
var toastTimer;
function showToast(msg, type){
  var t = document.getElementById('toast');
  t.textContent = msg;
  t.className = 'toast ' + (type||'toast-success');
  clearTimeout(toastTimer);
  setTimeout(function(){ t.classList.add('show'); }, 10);
  toastTimer = setTimeout(function(){ t.classList.remove('show'); }, 2500);
}

/* ── 모달 ── */
function openModal(){ document.getElementById('modalOverlay').classList.add('open'); document.body.style.overflow='hidden'; }
function closeModal(){ document.getElementById('modalOverlay').classList.remove('open'); document.body.style.overflow=''; }

/* ── 탭 ── */
function switchTab(idx, el){
  document.querySelectorAll('.tab-item').forEach(function(t){ t.classList.remove('active'); });
  document.querySelectorAll('.tab-pane').forEach(function(p){ p.classList.remove('active'); });
  el.classList.add('active');
  document.getElementById('tab'+idx).classList.add('active');
}

/* ── 목록 조회 ── */
function searchList(){ curPage = 1; loadList(); }

function loadList(){
  var n = encodeURIComponent(document.getElementById('kwProdName').value.trim());
  var no = encodeURIComponent(document.getElementById('kwProdNo').value.trim());
  var c = encodeURIComponent(document.getElementById('kwCorpName').value.trim());
  fetch(base+'/product/list?kwProdName='+n+'&kwProdNo='+no+'&kwCorpName='+c+'&page='+curPage+'&pageSize='+pageSize)
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success===false){ showToast(d.error,'toast-error'); return; }
      renderTable(d.list||[]);
      renderPaging(d.total||0, d.totalPage||1);
      document.getElementById('totalCount').textContent='총 '+(d.total||0)+'건';
    });
}

function renderTable(list){
  var tbody = document.getElementById('prodTableBody');
  if(!list.length){ tbody.innerHTML='<tr><td colspan="11" style="text-align:center;padding:40px;color:var(--muted)">데이터 없음</td></tr>'; return; }
  tbody.innerHTML = list.map(function(p){
    var sel = (p.prod_code===selCode)?' selected':'';
    var dang = p.prod_dang ? Number(p.prod_dang).toLocaleString() : '';
    var fn = p.product_file_name||'';
    var thumbTd = fn
      ? '<td class="thumb-cell" data-img-src="'+base+'/product/image/'+encodeURIComponent(fn)+'" data-img-label="'+esc(p.prod_name||'')+'">'
          +'<img class="thumb-img" src="'+base+'/product/image/'+encodeURIComponent(fn)+'" onerror="this.outerHTML=\'<span class=thumb-none>📷</span>\'">'
          +'</td>'
      : '<td class="thumb-cell"><span class="thumb-none">📷</span></td>';
    return '<tr class="'+sel+'" onclick="clickRow(\''+esc(p.prod_code)+'\')" ondblclick="dblSelectRow(\''+esc(p.prod_code)+'\')">'+thumbTd
      +'<td>'+esc(p.prod_code||'')+'</td>'
      +'<td>'+esc(p.prod_name||'')+'</td>'
      +'<td>'+esc(p.prod_no||'')+'</td>'
      +'<td>'+esc(p.corp_name||p.corp_code||'')+'</td>'
      +'<td>'+esc(p.prod_gyu||'')+'</td>'
      +'<td>'+esc(p.prod_jai||'')+'</td>'
      +'<td>'+esc(p.prod_danj||'')+'</td>'
      +'<td>'+esc(p.prod_danw||'')+'</td>'
      +'<td style="text-align:right">'+esc(dang)+'</td>'
      +'<td>'+esc(p.prod_gubn||'')+'</td>'
      +'</tr>';
  }).join('');
}

function renderPaging(total, totalPage){
  var pg = document.getElementById('pagination');
  if(totalPage<=1){ pg.innerHTML=''; return; }
  var html='', from=Math.max(1,curPage-2), to=Math.min(totalPage,curPage+2);
  if(curPage>1) html+='<button class="pg-btn" onclick="goPage('+(curPage-1)+')">‹</button>';
  for(var i=from;i<=to;i++) html+='<button class="pg-btn'+(i===curPage?' active':'')+'" onclick="goPage('+i+')">'+i+'</button>';
  if(curPage<totalPage) html+='<button class="pg-btn" onclick="goPage('+(curPage+1)+')">›</button>';
  pg.innerHTML=html;
}
function goPage(p){ curPage=p; loadList(); }

/* ── 단일클릭: 행 하이라이트만 ── */
function clickRow(prodCode){
  selCode = prodCode;
  document.querySelectorAll('#prodTableBody tr').forEach(function(tr){
    var first = tr.querySelector('td');
    tr.classList.toggle('selected', first && first.textContent===prodCode);
  });
}

/* ── 더블클릭: 수정 모달 ── */
function dblSelectRow(prodCode){
  selCode = prodCode;
  clickRow(prodCode);
  fetch(base+'/product/detail?prodCode='+encodeURIComponent(prodCode))
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success===false){ showToast(d.error,'toast-error'); return; }
      fillForm(d);
      setMode('edit');
      switchTab(0, document.querySelector('.tab-item'));
      openModal();
    });
}

/* ── 폼 필드 ── */
var FIELDS = ['prod_code','corp_code','prod_name','prod_no','prod_gyu','prod_jai',
  'prod_danj','prod_danw','prod_dang','prod_cno','prod_gubn','prod_upjong','prod_model','prod_date','prod_note',
  'prod_pg','prod_pg1','prod_pg2','prod_pgs','prod_pgs1','prod_pgs2',
  'prod_sg','prod_sg1','prod_sg2','prod_si','prod_si1','prod_si2','prod_sr','prod_sr1','prod_sr2',
  'prod_gd1','prod_gd2','prod_gd3','prod_gd4','prod_gd5',
  'prod_gj','prod_bh','prod_do','prod_ra','prod_polish','tech_no','tech_pattern','tech_seq',
  'prod_danch','prod_plt','prod_box','prod_boxsu','prod_snp','prod_bangch','prod_vnyl','prod_pad',
  'prod_appear','prod_transform','prod_realjai',
  'prod_chisu1n','prod_chisu2n','prod_chisu3n','prod_chisu4n','prod_chisu5n',
  'prod_chisu1s','prod_chisu2s','prod_chisu3s','prod_chisu4s','prod_chisu5s',
  'prod_cd','prod_kijong','prod_refno','prod_pwsno','prod_whadeep','prod_file',
  'prod_e1','prod_e2','prod_e3','prod_e4','prod_e5',
  'prod_fac1','prod_fac2','prod_fac3','prod_fac4','prod_fac5','prod_fac6','prod_fac7','prod_fac8',
  'product_file_name','apperance_file_name','heat_file_name','drawing_file_name'];

function fillForm(d){
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) el.value=d[f]||''; });
  document.getElementById('f_corp_name_disp').value = d.corp_name||'';
  setProdImage('product',  d.product_file_name||'');
  setProdImage('apperance',d.apperance_file_name||'');
  setProdImage('heat',     d.heat_file_name||'');
  setProdImage('drawing',  d.drawing_file_name||'');
}
function collectForm(){
  var obj={};
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) obj[f]=el.value||null; });
  return obj;
}

/* ── 신규 ── */
function newForm(){
  selCode=null;
  document.querySelectorAll('#prodTableBody tr').forEach(function(tr){ tr.classList.remove('selected'); });
  FIELDS.forEach(function(f){ var el=document.getElementById('f_'+f); if(el) el.value=''; });
  document.getElementById('f_corp_name_disp').value='';
  setProdImage('product',''); setProdImage('apperance',''); setProdImage('heat',''); setProdImage('drawing','');
  setMode('new');
  switchTab(0, document.querySelector('.tab-item'));
  openModal();
  setTimeout(function(){ document.getElementById('f_prod_name').focus(); },100);
}

/* ── 저장 ── */
function saveForm(){
  var data = collectForm();
  var isNew = !data.prod_code;
  fetch(base+'/product/save',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(data)})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){
        selCode = d.prodCode;
        closeModal();
        loadList();
        showToast(isNew ? '등록되었습니다.' : '수정되었습니다.');
      } else {
        showToast(d.error||'저장 실패','toast-error');
      }
    });
}

/* ── 삭제 ── */
function deleteForm(){
  if(!selCode){ showToast('삭제할 제품을 선택하세요.','toast-error'); return; }
  if(!confirm('['+selCode+'] 제품을 삭제하시겠습니까?')) return;
  fetch(base+'/product/delete',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({prodCode:selCode})})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){
        selCode=null; closeModal(); loadList();
        showToast('삭제되었습니다.');
      } else {
        showToast(d.error||'삭제 실패','toast-error');
      }
    });
}

/* ── 모드 표시 ── */
function setMode(mode){
  var badge=document.getElementById('formModeBadge'), btnDel=document.getElementById('btnDelete'), title=document.getElementById('modalTitle');
  if(mode==='new'){ badge.textContent='신규'; badge.className='badge-new'; title.textContent='제품 등록'; btnDel.style.display='none'; }
  else            { badge.textContent='수정'; badge.className='badge-edit'; title.textContent='제품 수정'; btnDel.style.display=''; }
}

function esc(s){ return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }

/* ── 이미지 업로드 ── */
function triggerImgInput(id){ document.getElementById(id).click(); }

var PROD_IMG_MAP = { 'product':'f_product_file_name', 'apperance':'f_apperance_file_name', 'heat':'f_heat_file_name', 'drawing':'f_drawing_file_name' };

function setProdImage(imgType, fileName){
  var fid = PROD_IMG_MAP[imgType];
  if(fid){ var el=document.getElementById(fid); if(el) el.value=fileName||''; }
  var prev=document.getElementById('imgPrev_'+imgType);
  var empty=document.getElementById('imgEmpty_'+imgType);
  var box=document.getElementById('imgBox_'+imgType);
  if(!prev||!empty||!box) return;
  if(fileName){
    prev.src=base+'/product/image/'+encodeURIComponent(fileName);
    prev.style.display='block';
    empty.style.display='none';
    box.onclick=function(){ window.open(base+'/product/image/'+encodeURIComponent(fileName),'_blank'); };
  } else {
    prev.src=''; prev.style.display='none';
    empty.style.display='flex';
    box.onclick=function(){ document.getElementById('imgFile_'+imgType).click(); };
  }
}

function uploadProdImage(input, imgType){
  var file=input.files[0]; if(!file) return;
  var fd=new FormData(); fd.append('file',file);
  fetch(base+'/product/image/upload',{method:'POST',body:fd})
    .then(function(r){ return r.json(); })
    .then(function(d){
      if(d.success){ setProdImage(imgType,d.fileName); showToast('이미지 업로드 완료'); }
      else { showToast(d.error||'업로드 실패','toast-error'); }
      input.value='';
    })
    .catch(function(){ showToast('업로드 실패','toast-error'); input.value=''; });
}

function clearProdImage(imgType){ setProdImage(imgType,''); }

/* ── 거래처 검색 모달 ── */
function openCorpSearch(){
  document.getElementById('corpSearchKw').value='';
  document.getElementById('corpSearchOverlay').classList.add('open');
  searchCorpList();
  setTimeout(function(){ document.getElementById('corpSearchKw').focus(); },100);
}
function closeCorpSearch(){ document.getElementById('corpSearchOverlay').classList.remove('open'); }
function searchCorpList(){
  var kw = encodeURIComponent(document.getElementById('corpSearchKw').value.trim());
  fetch(base+'/corp/list?kwCorpName='+kw+'&pageSize=200')
    .then(function(r){ return r.json(); })
    .then(function(d){
      var list=d.list||[], tbody=document.getElementById('corpSearchBody');
      if(!list.length){ tbody.innerHTML='<tr><td colspan="5" style="text-align:center;padding:30px;color:var(--muted)">데이터 없음</td></tr>'; return; }
      tbody.innerHTML=list.map(function(c){
        return '<tr style="cursor:pointer" onclick="selectCorp(\''+esc(c.corp_code)+'\',\''+esc(c.corp_name||'')+'\')">'
          +'<td>'+esc(c.corp_code||'')+'</td>'
          +'<td>'+esc(c.corp_name||'')+'</td>'
          +'<td>'+esc(c.corp_gubn||'')+'</td>'
          +'<td>'+esc(c.corp_tel||'')+'</td>'
          +'<td>'+esc(c.corp_boss||'')+'</td>'
          +'</tr>';
      }).join('');
    });
}
function selectCorp(code,name){
  document.getElementById('f_corp_code').value=code;
  document.getElementById('f_corp_name_disp').value=name;
  closeCorpSearch();
}

/* ── ESC 키 ── */
document.addEventListener('keydown',function(e){
  if(e.key==='Escape'){
    if(document.getElementById('corpSearchOverlay').classList.contains('open')) closeCorpSearch();
    else closeModal();
  }
});

/* ── 리스트 호버 미리보기 ── */
(function(){
  var p=document.createElement('div');
  Object.assign(p.style, {display:'none',position:'fixed',zIndex:'6000',background:'#fff',
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
  var x=e.clientX+16, y=e.clientY-60;
  if(x+pw>window.innerWidth) x=e.clientX-pw-8;
  if(y+ph>window.innerHeight) y=window.innerHeight-ph-8;
  if(y<4) y=4;
  p.style.left=x+'px'; p.style.top=y+'px';
}
function hideImgPopup(){ document.getElementById('imgPopG').style.display='none'; }

document.addEventListener('DOMContentLoaded',function(){
  var tbody=document.getElementById('prodTableBody');
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
