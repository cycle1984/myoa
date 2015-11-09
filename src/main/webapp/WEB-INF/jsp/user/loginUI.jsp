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

<!DOCTYPE HTML>
<html>
<head>
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
							//location.replace('${pageContext.request.contextPath}/register.jsp');
							registerFunDialog();
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
	
	/**
	*用户注册弹出的窗口
	*/
	var registerFunDialog = function(){
		var dialog = sy.modalDialog({//创建一个模式化的dialog
			title:'用户注册',
			width : 400,//dialog宽度
			top:'10%',//dialog离页面顶部的距离
			href:'/jingxi01/register.jsp',//从URL读取远程数据并且显示到面板。注意：内容将不会被载入，直到面板打开或扩大，在创建延迟加载面板时是非常有用的
			buttons: [ {
				id:'registerBtn',
				text : '注册',
				iconCls:'icon-ok',
				handler : function() {
					registerFun();
				}
			},{
    			id:'back_login',
    			text : '返回登陆',
    			handler : function() {
    				location.replace('${pageContext.request.contextPath}/index.jsp');
    			}
    		} ],
			onLoad:function(){//在加载远程数据时触发,初始化机构和单位的下拉菜单
				/**
	    		 * 机构下拉菜单初始化
	    		 */
	    		$("#register_myGroupCombobox").combobox({
	    			//value:'-==请选择所属系统==-',
	    			//mode:'remote',
	    		    url:"myGroup_findAll.action",
	    		    valueField:"id",
	    		    textField:"name",
	    		    required:true,
	    		    editable:false,
	    		    onSelect:function(){
	    		    	var myGroupId = $("#register_myGroupCombobox").combobox("getValue");
	    		    	//$('#register_unitCombobox').combobox('setValue' , '');
	    		    	$("#register_unitCombobox").combobox('reload','unit_getUnitsByMyGroupId.action?myGroupId='+myGroupId);
	    		    }
	    		});
	    		
	    		/**
	    		 * unit下拉菜单
	    		 */
	    		$("#register_unitCombobox").combobox({
	    		    valueField:"id",
	    		    textField:"name",
	    		    editable:false,
	    		    required:true
	    		});
	    		$('#register_loginName').textbox('textbox').focus();
    			$('#register_form :input').keyup(function(event) {
    				if (event.keyCode == 13) {
    					registerFun();
    				}
    			});
			},
			onOpen : function() {
    			
    		}
		});
	}
	var registerFun = function() {
		if ($('#register_form').form('validate')) {
			$('#registerBtn').linkbutton('disable');
			$('#back_login').linkbutton('disable');
			$.post('${pageContext.request.contextPath}/user_register.action', $('#register_form').serialize(), function(result) {
				if (result.success) {
					$.messager.alert('提示', result.msg, 'info', function() {
						location.replace('${pageContext.request.contextPath}/index.jsp');
					});

				} else {
					$.messager.alert('提示', result.msg, 'error', function() {
						$('register_form :input:eq(1)').focus();
					});
					$('#registerBtn').linkbutton('enable');
					$('#back_login').linkbutton('enable');
				}
			}, 'json');
		}
	};
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
					<TD style="background-color:#7e9fd8; background-position:left top; background-repeat: no-repeat;"></TD>
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
	<div id="home_login_loginDialog" title="系统登陆" style="display: none;width: 320px;height: 200px;overflow: hidden;">
		<div id="home_login_loginTabs" class="easyui-tabs" data-options="fit:true,border:false">
			<div title="用户输入模式" style="overflow: hidden; padding: 10px;">
				<form id="home_login_loginForm" method="post" class="form">
					<table class="table" style="width: 100%; height: 100%;">
						<!-- 
                        <tr style="margin: 0px;padding: 0px;">
                            <td colspan="2" style="margin: 0px;padding:0px;border: 0px;font-size: 12px;color: red;"><s:fielderror></s:fielderror>
                        </tr>
                         -->
						<tr>
							<th style="width: 50px;font-size: 13px;height: 15px;">用户名</th>
							<td><s:textfield id="loginName" name="loginName" cssClass="easyui-textbox" data-options="required:true,iconCls:'icon-man',type:'text'" style="width: 100%;"></s:textfield></td>
						</tr>
						<tr>
							<th style="width: 50px;font-size: 13px;height: 15px;">密码</th>
							<td><input id='pwd' name="pwd" class="easyui-textbox" data-options="required:true,validType:'length[3,20]',iconCls:'icon-lock',type:'password'" style="width: 100%;" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		// 在被嵌套时就刷新上级窗口
		if (window.parent != window) {
			window.parent.location.reload(true);
		}
	</script>
</body>
</html>
