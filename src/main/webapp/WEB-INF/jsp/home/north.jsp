<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="cycle.myoa.domain.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	User user = (User) session.getAttribute("userSession");
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>左侧菜单</title>
</head>

<body style="overflow: scroll;overflow: hidden;">
<script type="text/javascript">
//注销、退出
var logoutFun = function() {
	$.post('user_logout.action', function(result) {
		location.replace('${pageContext.request.contextPath}/user_loginUI.action');
	}, 'json');
};
//显示个人信息
var showMyInfoFun = function() {
	var dialog = parent.sy.modalDialog({
		title : '我的信息',
		width:500,
		top:60,
		url : '${pageContext.request.contextPath}/userInfo.jsp'
	});
};
//修改个人信息
var modifyInfoFun = function(){
	var dialog = parent.sy.modalDialog({
		title : '修改联系电话',
		width:500,
		top:'10%',
		url : '${pageContext.request.contextPath}/cyUser_modifyInfoUI.action',
		buttons : [ {
			id:'modifyInfoUI_OKbtn',
			text : '确定',
			iconCls:'icon-ok',
			handler : function() {
				cyUser_modifyInfo_submitForm(dialog);
			}
		} ]
	});
};
$(function(){
	$('#passwordDialog').show().dialog({
		modal : true,
		closable : true,
		iconCls : 'ext-icon-lock_edit',
		buttons : [ {
			text : '修改',
			handler : function() {
				if ($('#passwordDialog form').form('validate')) {
					$.post('${pageContext.request.contextPath}/cyUser_updateCurrentPwd.action', {
						'oldPwd' : $('#oldPwd').val(),
						'pwd':$('#pwd').val()
					}, function(result) {
						if (result.success) {
							$.messager.alert('提示', result.msg, 'info');
							$('#passwordDialog').dialog('close');
						}else{
							$.messager.alert('提示',result.msg, 'error');
						}
					}, 'json');
				}
			}
		} ],
		onOpen : function() {
			$('#passwordDialog form :input').val('');
		}
	}).dialog('close');
});
</script>
<div style="overflow: scroll;overflow: hidden;background: url(style/images/sys/login_topBg.jpg);background-color: white;"><img  src="style/images/sys/top.jpg">
	<div id="sessionInfoDiv" style="position: absolute; right: 10px; top: 5px;display: none;">
	sss
	</div>
	<div style="position: absolute; right: 0px; bottom: 0px;">
		<span style="color: white;">当前用户:<% if(user!=null){out.print(user.getName());} %>&nbsp; &nbsp; </span>
		<s:if test="%{#session.userSession.loginName!='admin'}">
			<span style="color: white;">单位:<% if(user!=null){ if(user.getUnit()!=null){out.print(user.getUnit().getName());} } %>&nbsp; &nbsp; </span>
		</s:if>
		<!-- <a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu',iconCls:'ext-icon-rainbow'">更换皮肤</a>  -->
		<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_kzmbMenu',iconCls:'ext-icon-cog'"><span style="color: white;">控制面板</span></a> <a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_zxMenu',iconCls:'ext-icon-disconnect'"><span style="color: white;">注销</span></a>
	</div>
	<div id="layout_north_pfMenu" style="width: 120px; display: none;">
		<div onclick="changeTheme('default');" title="default">default</div>
		<div onclick="changeTheme('gray');" title="gray">gray</div>
		<div onclick="changeTheme('metro');" title="metro">metro</div>
		<div onclick="changeTheme('bootstrap');" title="bootstrap">bootstrap</div>
		<div onclick="changeTheme('black');" title="black">black</div>
		<div class="menu-sep"></div>
		<div onclick="changeTheme('metro-blue');" title="metro-blue">metro-blue</div>
		<div onclick="changeTheme('metro-gray');" title="metro-gray">metro-gray</div>
		<div onclick="changeTheme('metro-green');" title="metro-green">metro-green</div>
		<div onclick="changeTheme('metro-orange');" title="metro-orange">metro-orange</div>
		<div onclick="changeTheme('metro-red');" title="metro-red">metro-red</div>
	</div>
	<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
		<div data-options="iconCls:'ext-icon-lock_edit'" onclick="$('#passwordDialog').dialog('open');">修改密码</div>
		<div class="menu-sep"></div>
		<div data-options="iconCls:'ext-icon-user'" onclick="showMyInfoFun();">我的信息</div>
		<div class="menu-sep"></div>
		<div data-options="iconCls:'ext-icon-user_edit'" onclick="modifyInfoFun();">修改个人资料</div>
	</div>
	<div id="layout_north_zxMenu" style="width: 100px; display: none;">
		<div data-options="iconCls:'ext-icon-door_out'" onclick="logoutFun();">退出系统</div>
	</div>
	<div id="passwordDialog" title="修改密码" style="display: none;">
		<form method="post" class="form" onsubmit="return false;">
			<table class="table">
			    <tr>
					<th>旧密码</th>
					<td><input id="oldPwd" name="oldPwd" type="password" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>新密码</th>
					<td><input id="pwd" name="pwd" type="password" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>重复密码</th>
					<td><input type="password" class="easyui-validatebox" data-options="required:true,validType:'eqPwd[\'#pwd\']'" /></td>
				</tr>
			</table>
		</form>
	</div>
</div>
</body>
</html>
