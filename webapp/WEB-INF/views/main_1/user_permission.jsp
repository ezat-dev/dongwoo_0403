<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common_style.jsp" %>
<style>
.perm-layout { display:grid; grid-template-columns:260px 1fr; gap:16px; }
@media(max-width:800px){ .perm-layout { grid-template-columns:1fr; } }
.user-pick-item {
  display:flex; align-items:center; gap:10px; padding:9px 12px;
  border-radius:8px; border:1px solid var(--border); background:var(--white);
  cursor:pointer; margin-bottom:6px; transition:all .13s;
}
.user-pick-item:hover { border-color:var(--primary-m); background:var(--primary-l); }
.user-pick-item.active { border-color:var(--primary); background:var(--primary-l); box-shadow:0 0 0 2px var(--primary-m); }
.perm-grid { display:grid; grid-template-columns:1fr 1fr; gap:10px; }
.perm-menu-item {
  display:flex; align-items:center; justify-content:space-between;
  padding:10px 14px; border-radius:9px; border:1px solid var(--border);
  background:var(--bg); font-size:13px;
}
.perm-menu-item .menu-name { font-weight:600; }
.perm-menu-item .menu-icon-s { font-size:15px; margin-right:7px; }
.toggle-wrap { display:flex; align-items:center; gap:6px; }
.toggle-switch {
  position:relative; width:38px; height:20px; display:inline-block; cursor:pointer;
}
.toggle-switch input { display:none; }
.toggle-slider {
  position:absolute; inset:0; background:var(--light); border-radius:20px;
  transition:background .2s;
}
.toggle-slider::before {
  content:''; position:absolute; width:14px; height:14px; border-radius:50%;
  background:#fff; top:3px; left:3px; transition:transform .2s;
}
.toggle-switch input:checked + .toggle-slider { background:var(--primary); }
.toggle-switch input:checked + .toggle-slider::before { transform:translateX(18px); }
</style>
<body>
<div class="page-wrap">
  <div class="page-header">
    <div>
      <div class="page-title">권한 부여</div>
      <div class="page-sub">사용자별 메뉴 접근 권한 설정</div>
    </div>
    <button class="btn-primary" onclick="savePerms()">💾 저장</button>
  </div>

  <div class="perm-layout">
    <!-- 사용자 선택 -->
    <div class="card" style="height:fit-content">
      <div class="card-title">사용자 선택</div>
      <div id="userPickList"></div>
    </div>

    <!-- 권한 설정 -->
    <div class="card">
      <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:14px">
        <div class="card-title" style="margin:0" id="permTitle">사용자를 선택하세요</div>
        <div style="display:flex;gap:8px">
          <button class="btn-outline btn-sm" onclick="setAll(true)">전체 허용</button>
          <button class="btn-outline btn-sm" onclick="setAll(false)">전체 차단</button>
        </div>
      </div>
      <div class="perm-grid" id="permGrid">
        <div style="color:var(--light);font-size:13px;grid-column:1/-1;text-align:center;padding:40px">
          좌측에서 사용자를 선택하세요
        </div>
      </div>
    </div>
  </div>
</div>

<script>
var users = [
  {id:'kim_op',  name:'김운영',  dept:'생산팀', role:'operator'},
  {id:'lee_eq',  name:'이설비',  dept:'설비팀', role:'user'},
  {id:'park_qc', name:'박품질',  dept:'품질팀', role:'operator'},
  {id:'choi_el', name:'최전기',  dept:'설비팀', role:'user'},
  {id:'jung_op', name:'정운영',  dept:'생산팀', role:'user'},
];

var menus = [
  {id:'equip_monitor', name:'설비 모니터링', icon:'🖥️'},
  {id:'equip_detail',  name:'설비 상세',     icon:'🔍'},
  {id:'trend',         name:'트렌드',        icon:'📈'},
  {id:'alarm_history', name:'알람 이력',     icon:'🔔'},
  {id:'alarm_ranking', name:'알람 랭킹',     icon:'🏆'},
  {id:'calib_status',  name:'보정현황',      icon:'🌡️'},
  {id:'daily_inspect', name:'일상점검일지',  icon:'📋'},
  {id:'fproof',        name:'F/PROOF',       icon:'🛡️'},
  {id:'spare_parts',   name:'스페어파트',   icon:'🔩'},
  {id:'user_manage',   name:'사용자 관리',  icon:'👤'},
  {id:'user_permission','name':'권한 부여', icon:'🔐'},
];

// 기본 권한 (operator = 모두, user = 일부)
var defaultPerms = {
  operator: ['equip_monitor','equip_detail','trend','alarm_history','alarm_ranking','calib_status','daily_inspect','fproof','spare_parts'],
  user:     ['equip_monitor','equip_detail','trend','alarm_history'],
};
var permMap = {};
users.forEach(function(u){
  permMap[u.id] = {};
  menus.forEach(function(m){
    permMap[u.id][m.id] = defaultPerms[u.role]
      ? defaultPerms[u.role].indexOf(m.id) >= 0
      : false;
  });
});

var selectedUser = null;

function renderPickList(){
  var html='';
  users.forEach(function(u){
    var isSel = selectedUser && selectedUser.id === u.id;
    html += '<div class="user-pick-item'+(isSel?' active':'')+'" onclick="selectUser(\''+u.id+'\')">'
          + '<div class="user-avatar" style="width:30px;height:30px;font-size:12px;background:linear-gradient(135deg,#4299E1,#2B6CB0);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;flex-shrink:0">'+u.name[0]+'</div>'
          + '<div style="flex:1"><div style="font-size:13px;font-weight:600">'+u.name+'</div><div style="font-size:11px;color:var(--muted)">'+u.dept+' · '+u.id+'</div></div>'
          + '</div>';
  });
  document.getElementById('userPickList').innerHTML = html;
}

function selectUser(id){
  selectedUser = users.find(function(u){ return u.id===id; });
  renderPickList();

  document.getElementById('permTitle').textContent = selectedUser.name + ' 권한 설정';
  var html='';
  menus.forEach(function(m){
    var checked = permMap[id][m.id] ? 'checked' : '';
    html += '<div class="perm-menu-item">'
          + '<div><span class="menu-icon-s">'+m.icon+'</span><span class="menu-name">'+m.name+'</span></div>'
          + '<label class="toggle-switch">'
          + '  <input type="checkbox" id="perm_'+m.id+'" '+checked+' onchange="updatePerm(\''+id+'\',\''+m.id+'\',this.checked)">'
          + '  <span class="toggle-slider"></span>'
          + '</label>'
          + '</div>';
  });
  document.getElementById('permGrid').innerHTML = html;
}

function updatePerm(uid, mid, val){ permMap[uid][mid] = val; }
function setAll(val){
  if(!selectedUser) return;
  menus.forEach(function(m){
    permMap[selectedUser.id][m.id] = val;
    var el = document.getElementById('perm_'+m.id);
    if(el) el.checked = val;
  });
}
function savePerms(){ alert('권한 저장 기능은 서버 연동 후 구현됩니다.'); }

renderPickList();
</script>
</body></html>
