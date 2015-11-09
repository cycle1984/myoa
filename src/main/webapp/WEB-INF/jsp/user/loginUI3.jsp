<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/common.jsp"%>
<%@ page import="cycle.myoa.domain.User"%>
<%
	User user = (User) session.getAttribute("userSession");
	if (user != null) {
		response.sendRedirect(request.getContextPath()
				+ "/home_index.action");
	}
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>登陆页面</title>
<meta name="renderer" content="webkit">

<script type="text/javascript">
	$(function() {
		var loginFun = function() {
			if ($('#home_login_loginForm').form('validate')) {
				$('#loginBtn').linkbutton('disable');
				$('#regBtn').linkbutton('disable');
				//$('#home_login_loginForm').submit();
				$.post('${pageContext.request.contextPath}/user_login.action',$('#home_login_loginForm').serialize(),function(r) {
					if (r.success) {
						$.messager.show({
							title : '提示',
							msg : r.msg
						});
						location.replace('home_index.action');

					} else {
						/*IE6-9出错
						$.messager.alert('错误提示',r.msg,'error',function(date){
							$('input[name="pwd"]').val('').focus();
							$('#loginBtn').linkbutton('enable');
						});
						 */
						$.messager.show({
							title : '错误提示',
							msg : r.msg,
							timeout : 5000,
							showType : 'fade'
						});
						$('#pwd').textbox('clear').textbox('textbox').focus();//密码框获得焦点
						//$('#pwd').val('').focus();
						$('#loginBtn').linkbutton('enable');
						$('#regBtn').linkbutton('enable');
					}
				}, 'json');
			}
		};

		$('#home_login_loginDialog').show().dialog({
			modal : false,
			closable : false,
			iconCls : 'ext-icon-lock_open',
			buttons : [
					{
						id : 'loginBtn',
						text : '登录',
						handler : function() {
							loginFun();
						}
					} ,{
						id : 'regBtn',
						text : '注册',
						handler : function() {
							location.replace('${pageContext.request.contextPath}/reg.jsp');
						}
					} ],
			onOpen : function() {
				$('form :input').keyup(function(event) {
					if (event.keyCode == 13) {
						loginFun();
					}
				});
			}
		});
		$('#loginName').textbox('textbox').focus();//登录名文本框获得焦点，不能放到onOpen里，否则无法获取焦点
	});
</script>
</head>

<!-- <body style="width:99%;height:97.3%;background-color: #F5F5F5 "> -->
<body style="width:100%;height:100%;margin:0px;padding: 0px;overflow: hidden;">
	<div style="margin: 0px;padding: 0px;">
		<TABLE style="border:0;height:100%; width:100%;border-collapse: collapse;">
			<TBODY>
				<TR>
					<TD style="background:url(style/images/sys/login_topBg.jpg);height:90px;">
						<TABLE style="border:0;border-collapse: collapse;width:100%;">
							<TBODY>
								<TR>
									<TD><IMG style="border: 0px;" src='style/images/sys/top.jpg'></TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD style="background-color: #07359b;height: 4px;">
						<TABLE style="border: 0px;width: 100%;border-collapse: collapse;">
							<TBODY>
								<TR>
									<TD><IMG style="border: 0px;" src='style/images/sys/login_line1.jpg'></TD>
									<TD><IMG style="border: 0px;" src="style/images/sys/login_line1_r.jpg"></TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD align="middle" style="background-color:#7e9fd8; background-position:left top; background-repeat: no-repeat;">
		<!-- saddas -->	<table width="260" cellspacing="0" cellpadding="5" border="0" id="Table4">
				        <tbody>
				        <tr>
				          <td height="25"><font face="宋体">
				            <table width="100%" cellspacing="0" cellpadding="0" border="0" id="Table5"><tbody>
				              <tr>
				                <td align="right"><img border="0" src="images/login_arrow.gif" id="Image7"></td>
				                <td align="center"><a href="default.asp"><img border="0" alt="靖西县党政机关公文传输系统" src="images/login_font.jpg" id="Image8"></a></td>
				              </tr></tbody></table></font></td></tr>
				        <tr>
				          <td>
				            <table width="100%" cellspacing="0" cellpadding="5" border="0" bgcolor="#9cb5e1" id="Table7">
				              <tbody>
				              <tr>
				                <td height="3" align="center" colspan="2" class="loginBorder"><span class="style1"><font face="宋体">靖西县党政机关公文传输系统</font></span></td>
				              </tr>
				              <tr>
				                <td align="right" class="loginBorder"><font face="宋体"><span style="COLOR: white" id="Label1">用户名：</span></font></td>
				                <td class="loginBorder"><font face="宋体"><input style="COLOR: maroon; FONT-FAMILY: Tahoma; FONT-WEIGHT: bold; WIDTH: 150px" id="txtUser" name="username"></font></td></tr>
				              <tr>
				                <td align="right" class="loginBorderB"><font face="宋体"><span style="COLOR: white" id="Label2">密&nbsp;&nbsp;码：</span></font></td>
				                <td class="loginBorderB"><input type="password" style="COLOR: maroon; FONT-FAMILY: Tahoma; FONT-WEIGHT: bold; WIDTH: 150px" id="txtPassword" name="password"></td></tr>
				              <tr>
				                <td height="3" align="right"><font face="宋体"></font></td>
				                <td height="3"></td></tr></tbody></table></td></tr>
				        <tr>
				          <td height="35">
				            <table width="100%" cellspacing="0" cellpadding="0" border="0" id="Table6"><tbody>
				              <tr>
				                <td width="50%" align="center"><font face="宋体">
				    <input type="image" border="0" onclick="return form_check();" src="Images/login_btnLogin.jpg" onmouseover="this.src='Images/login_btnLogin_hover.jpg'" onmouseout="this.src='Images/login_btnLogin.jpg'" name="btnEnter" id="btnEnter"></font></td>
				                <td align="center">
				    <a onmouseover="MM_swapImage('Image2','','images/login_btnCancel_hover.jpg',0)" onmouseout="MM_swapImgRestore()" href="javascript:window.close();"><img border="0" name="Image2" src="images/login_btnCancel.jpg"></a>    </td></tr></tbody></table></td></tr></tbody></table>
					
					</TD><!-- dsadas-->
				</TR>
				<TR>
					<TD style="background-color:#07359b;height: 4px; "><IMG style="border: 0px;" src='style/images/sys/login_line2.jpg'></TD>
				</TR>
				<TR>
					<TD  style="background-color:#07359b;height: 40px; ">
							<table style="width: 100%;border: 0px;border-collapse: collapse;">
								<tr>
									<td style="text-align: center;"><span style="color: white;font-size: 12px;"> 靖西市党政机关公文传输系统 <br> 靖西市委机要局 技术支持 <img src='style/images/sys/ico.gif'></span></td>
								</tr>
							</table>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</div>

	<script type="text/javascript">
		// 在被嵌套时就刷新上级窗口
		if (window.parent != window) {
			window.parent.location.reload(true);
		}
	</script>
</body>
</html>
