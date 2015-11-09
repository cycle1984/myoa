<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>页脚</title>
</head>

<body style="overflow: scroll;overflow: hidden;">
	<div style="height: 60px;overflow: scroll;overflow: hidden;">
		<table style="width: 100%;border: 0px;border-collapse: collapse;">
			<tr>
				<td style="text-align: center;"><span style="font-size: 12px;"> 靖西市党政机关公文传输系统 <br> 靖西市委机要局 技术支持 <img src='style/images/sys/ico.gif'></span></td>
			</tr>
		</table>
	</div>
</body>
</html>
