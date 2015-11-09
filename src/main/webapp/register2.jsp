<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册页面</title>

<title>用户注册</title>
    
    <script type="text/javascript">
    $(function(){
    	$('#registerDialog').show().dialog({
    		width : 300,
    		modal : true,
    		closable : false,
    		iconCls : 'ext-icon-user_add',
    		buttons : [ {
    			id:'back_login',
    			text : '返回登陆',
    			handler : function() {
    				location.replace('${pageContext.request.contextPath}/index.jsp');
    			}
    		}, {
    			id : 'registerBtn',
    			text : '注册',
    			iconCls:'icon-add',
    			handler : function() {
    				registerFun();
    			}
    		} ],
    		onOpen : function() {
    			$('input[name="sex"]').get(0).checked='checked';
    			$('form :input:first').focus();
    			$('form :input').keyup(function(event) {
    				if (event.keyCode == 13) {
    					registerFun();
    				}
    			});
    		}
    	});
    	
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
							$('form :input:eq(1)').focus();
						});
						$('#registerBtn').linkbutton('enable');
						$('#back_login').linkbutton('enable');
					}
				}, 'json');
			}
		};
		
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

		
    });
    
    
    </script>

</head>
<body style="width:100%;height:100%;">
	<div id="registerDialog" title="用户注册" style="display: none;">
     
		<form method="post" id="register_form">
		<fieldset>
        <legend>用户基本信息</legend>
            <table style='margin:0px auto;' class="table">
                <tr>
                    <th>登陆名</th>
                    <td><input id="register_loginName" name="loginName" type="text" class="easyui-textbox" data-options="required:true,delay:1000,validType:['username[$(\'#register_loginName\').val()]','remote[\'${pageContext.request.contextPath}/user_searchByLoginName.action\',\'loginName\']']" ></td>
                </tr>
                <tr>
                    <th>姓名</th>
                    <td><input name="name" id="register_name" type="text" class="easyui-textbox" data-options="required:true,validType:'chinese[$(\'#register_name\').val()]'"></td>
                </tr>
                <tr>
					<th>密码</th>
					<td><input id="pwd" name="pwd" type="password" class="easyui-textbox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>重复密码</th>
					<td><input type="password" class="easyui-textbox" data-options="required:true,validType:'eqPwd[\'#pwd\']'" /></td>
				</tr>
                <tr>
                    <th>性别</th>
                    <td>男<input name="gender" value="男" type="radio">女<input name="gender" value="女" type="radio" ></td>
                </tr>
               	<tr>
                    <th>办公室电话</th>
                    <td><input type="text" id="register_tel" name="tel" class="easyui-textbox" data-options="validType:['tel[$(\'#register_tel\').val()]','maxLength[12]']"></td>
                </tr>
                <tr>
                    <th>手机号码</th>
                    <td><input type="text" id="register_phone" name="phone" class="easyui-textbox" data-options="required:true,prompt:'支持13、15、17、18开头手机号码',validType:'mobile[$(\'#register_phone\').val()]'"></td>
                </tr>
                <tr>
                  <th>所属机构</th>
                  <td><select id="register_myGroupCombobox" name="myGroupId" style="width: 155px" data-options="prompt:'请选择所属机构'"></select></td>
                </tr>
                <tr>
                  <th>所属单位</th>
                  <td><select id="register_unitCombobox" name="unitId" style="width: 155px" data-options="prompt:'请选择所属单位'"></select></td>
                </tr>
                <tr>
					<th>部门</th>
					<td><input name="dep" type="text" class="easyui-textbox" ></td>
				</tr>
                <tr>
                    <th>描述</th>
                    <td><input type="text" name="description" class="easyui-textbox" data-options="multiline:true,height:55,prompt:'此处可备注信息'"></td>
                </tr>
            </table>
        </fieldset>
		</form>
	</div>
</body>
</html>