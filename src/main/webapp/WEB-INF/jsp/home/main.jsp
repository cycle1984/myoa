<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>'main.jsp'</title>
</head>

<body>
<script type="text/javascript">

    function addTab(opts){
    
    	var t = $('#home_main_tabs');
    	if(t.tabs('exists',opts.title)){
    		t.tabs('select',opts.title);
    	}else{
    		t.tabs('add',opts);
    	}
    	
    }
    
    
    
</script>
	<div id="home_main_tabs" class="easyui-tabs" data-options="fit:true">
		<s:if test="%{#session.userSession.loginName!='admin'}"><!-- 如果不是超级管理员，则显示收文列表 -->
		    <div title="收文列表">
		        
		    </div>
		    <s:if test='%{#session.userSession.hasCyResourceByTitle("发文管理")}'>
		    	<div title="发文管理">
				    <jsp:include  page="../document/publishList.jsp" ></jsp:include>
				</div>
		    </s:if>
	    </s:if>
	     <s:else>
	    <div title="发文管理">
		  <jsp:include  page="../document/publishList.jsp" ></jsp:include>
		</div>
		 </s:else>
		   
	</div>
	
</body>
</html>
