var processDefinitionGrid = $('#processDefinition_list_grid');
$(function(){
	processDefinitionGrid.datagrid({
		idField:'id',//指定标识字段
		url:'${pageContext.request.contextPath}/processDefinition_listGrid.action',//URL从远程站点请求数据
		fit:true,//当设置为true的时候面板大小将自适应父容器
		fitColumns:true,//适应网格的宽度，防止水平滚动
		striped : true,//是否显示斑马线
		rownumbers : true,//显示一个行号列
		pagination : true,//DataGrid控件底部显示分页工具栏
		singleSelect : false,//如果为true，则只允许选择一行
		border:false,//是否显示面板边框
		pageSize : 20,//每页显示记录数
		pageList : [10, 20, 30, 40, 50, 100, 500],//在设置分页属性的时候 初始化页面大小选择列表
		columns:[[{
			field : 'id',
			title : '主键',
			width : 100,
			checkbox : true
		}, {
			field : 'name',
			title : '名称',
			width : 100,
			sortable : true
		}, {
			field : 'key',
			title : 'key',
			width : 100,
			sortable : true
		}, {
			field : 'version',
			title : '版本号',
			width : 100,
			sortable : true
		}, {
			field : 'deploymentId',
			title : '部署ID',
			width : 100,
			sortable : true
		}, {
			field : 'resourceName',
			title : '流程定义xml文件',
			width : 100,
			sortable : true
		}, {
			field : 'diagramResourceName',
			title : '流程图',
			width : 100,
			formatter: function(value,row,index){
				var str = '<a target="_blank" style="text-decoration:none;" href="${pageContext.request.contextPath}/processDefinition_viewResource.action?id='+row.id+'">'+value+'</a>';
				//var str = '';//下面弹窗方式出现乱码 暂时无法解决
				//str += sy.formatString('<span onclick="viewResource(\'{0}\');" title="公文添加">'+value+'</span>',row.id);
				return str;
			},
			sortable : true
		}, {
			field : 'suspended',
			title : 'suspended',
			width : 100,
			sortable : true
		}]],
		onLoadError:function(){
			 $.messager.alert('信息提示','登录超时请重新登录!','error');
		},
		toolbar:'#processDefinition_list_toolbar'//工具面板
	});
});

//弹出方式出现乱码
var viewResource = function(pdID){
	var dialog = sy.modalDialog({
		title:'流程图',
		href:'${pageContext.request.contextPath}/processDefinition_viewResource.action?id='+pdID,
		width:'70%',
		height:'70%',
		border:true
	});
};

//删除流程定义
var deleteFunProcessDefinition = function(){
	var rows = processDefinitionGrid.datagrid('getChecked');
	var ids = "";
	if(rows.length>0){
		$.messager.confirm('提示信息', '即将删除' + rows.length + '条数据,确认删除？',
		function(r){
			$.messager.progress({
				text : '数据删除中....'
			});
			if(r){
				// 将id拼成字符串
				for (var i = 0; i < rows.length; i++) {
					ids += rows[i].deploymentId + ',';
				}
				ids = ids.substring(0, ids.length - 1);
				$.post('${pageContext.request.contextPath}/processDefinition_delete.action',{ids : ids},function(r){
					if(r.success){
						processDefinitionGrid.datagrid('load');
						processDefinitionGrid.datagrid('uncheckAll');
						$.messager.show({
							title : '提示',
							msg : r.msg
						});
					}else{
	    				$.messager.alert('提示', r.msg,'error');
	    			}
				},'json');
				$.messager.progress('close');
			}
		});
	}else {
		$.messager.show({
			title : '提示',
			msg : "请选择要删除的记录"
		});
	}
};