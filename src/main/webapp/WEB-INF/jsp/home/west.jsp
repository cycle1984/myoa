<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'west.jsp' starting page</title>

</head>

<body>
	<script type="text/javascript">
		$(function() {
			$('#public_west_tree').tree({
				url : 'myResource_getAllMenu.action',
				parentField : 'pid',
				onClick : function(node) {
					if (node.attributes.url) {
						var url = '${pageContext.request.contextPath}/'
								+ node.attributes.url+".action";
						addTab({
							title : node.text,
							href : url,
							closable : true,
							fit:true
						});
					}

				}
			});
		});
	</script>
	<div>
		<ul id="public_west_tree">
		</ul>
	</div>
</body>
</html>
