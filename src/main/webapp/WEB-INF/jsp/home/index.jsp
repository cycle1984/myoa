<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/common.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>公文传输系统</title>

</head>

<body class="easyui-layout" data-options="border:false">
	<div data-options="region:'north',split:true" style="height:98px;"><jsp:include page="north.jsp"></jsp:include></div>
	
	<!-- <div data-options="region:'east',iconCls:'icon-reload',title:'East',split:true" style="width:100px;"></div> -->
	<div data-options="region:'west',title:'菜单',split:true" style="width:180px;">
		<jsp:include page="west.jsp"></jsp:include>
	</div>
	<div data-options="region:'center',title:false,border:false">
	    <jsp:include page="main.jsp"></jsp:include>
	</div>
	<div data-options="region:'south',split:true" style="height:40px;overflow: scroll;overflow: hidden;"><jsp:include page="south.jsp"></jsp:include></div>
</body>
</html>
