<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>菜单管理工作平台</title>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="js/jquery.jstree.js"></script>
<script language="javascript">
	$(function() {
		//计算页面的高度
		var clientHeight ;
		if($.browser.msie){
			//ie 浏览器
			clientHeight = document.body.clientHeight;
		}else{
			clientHeight = self.innerHeight;
		}
		//将菜单的高度设置成浏览器的高度(一个绝对值)
		$("#menuTree").height(clientHeight);
		$("#menuTree").width(150);
		//设置左右滚动条 自动显示
		$("#menuTree").css("overflow","auto");
		
		//将menuContainer变成一棵树！
		$("#menuTree").jstree({
			"json_data" : {
				"ajax" : {
					"url" : "system/menu!tree.action"
				}
			},
			"plugins" : [ "themes", "json_data", "ui" ]
		});
		$("#menuTree").bind("loaded.jstree", function(event) {
			$("#menuTree").jstree("open_all", -1);
		});
		$("#menuTree").bind("select_node.jstree", function(event, data) {
			var menuId = data.rslt.obj.attr("id");
			$("#rigthFrame").attr("src", "system/menu!updateInput.action?id=" + menuId)
		});

		$("#menuTree").css("font-size", "12px")
	});
	function refresh(){
		$("#menuTree").jstree("refresh","#menuTree");
	}
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-size: 12px;
}
-->
</style>
</head>
<body>
	<table width="100%" height="100%" border="0" cellpadding="0">
		<tr>
			<td width="150" valign="top"><div id="menuTree" />
			</td>
			<td width="8" bgcolor="#add2da">&nbsp;</td>

			<td><iframe src="right.jsp" width="100%" height="100%" frameborder="0" id="rigthFrame" />
			</td>
			<td width="8" bgcolor="#add2da">&nbsp;</td>
		</tr>
	</table>
</body>
</html>

