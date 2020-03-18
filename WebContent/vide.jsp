<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="plantserver1.mysql"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link rel="stylesheet" type="text/css" href="simple_link.css">
	<link rel="stylesheet" href="css/base.css">
	<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/video.css">
	<script src="assets/jquery/jquery-1.8.3.min.js"></script>
	<%
	String divice = request.getParameter("divice");
	System.out.println(divice);
	String i=mysql.readSql("select vide from DiviceStatus where diviceID='"+divice+"'");
	if(i.indexOf("1")!=-1){
		%>
</head>

<body class="in-frame">

	<!-- 头部导航 start -->
	<div id="header">
		<div class="w nav-list">
			<ul class="head-left-nav">
				<li>
					<p>CDSJSD</p>
				</li>
				<li><a href="html/control_management.html">控制管理</a>
					<!--不做操作-->
				</li>
				<li><a href="html/login.html">退出登录</a>
					<!--转登陆-->
				</li>
			</ul>

		</div>
	</div>
	<!-- 头部导航 end -->

	<table border="0" width="100%" cellpadding="3" cellspacing="0">
		<tr>
			<td align=center class="in-a-box" colspan=2><br> <img src="images/loading.gif" id="camerascreen" style="max-width: 640px; height: 700px\0/IE8 +9;"
				/> <br></td>
		</tr>
		<tr>
			<td>Please wait</td>
		</tr>
	</table>

</body>
		<%
	}
	else{
	%>	<script type="text/javascript">
		var sl_ws;
		//var wsRecvMsg; 
		var HTTPrequest = new XMLHttpRequest();
		function encode(input) {
			var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
			var output = "";
			var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
			var i = 0;

			while (i < input.length) {
				chr1 = input[i++];
				chr2 = i < input.length ? input[i++] : Number.NaN;
				chr3 = i < input.length ? input[i++] : Number.NaN;

				enc1 = chr1 >> 2;
				enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
				enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
				enc4 = chr3 & 63;

				if (isNaN(chr2)) {
					enc3 = enc4 = 64;
				} else if (isNaN(chr3)) {
					enc4 = 64;
				}
				output += keyStr.charAt(enc1) + keyStr.charAt(enc2)
					+ keyStr.charAt(enc3) + keyStr.charAt(enc4);
			}
			return output;
		}

		function StartCamera() {

			//	var url = $('#wsURL').val();
			//var url = "ws://localhost:8080/plantPro/websocket";
				var url = "ws://10.4.208.78:30088/websocket";
			sl_ws = new WebSocket(url);
			sl_ws.binaryType = 'arraybuffer';

			sl_ws.onopen = function () {
				alert("WebSocket Connected");
				// TBD - Send Start Command on Socket
				//	sl_ws.send("123456789");
				sl_ws.send("capture:01234567");
			};
			sl_ws.onerror = function () {
				alert("WebSocket Error");
			};

			sl_ws.onmessage = function (event) {
				//alert("WebSocket Data Received");
				var wsRecvMsg = event.data;
				var cameraStream = new Uint8Array(wsRecvMsg);
				var camerascreen = document.getElementById('camerascreen');
				camerascreen.src = 'data:image/jpg;base64,' + encode(cameraStream);
				//camerascreen.src = encode(cameraStream);
				//camerascreen.src = images/camera2.jpg;
				//alert ('Server Says:  '+wsRecvMsg+' ');
				//Receive and Handle Data 
			};

			sl_ws.onclose = function () {
				alert("WebSocket Closed");
			};
			// 组件即页面跳转时调用，中断websocket链接
					this.$router.afterEach(function() {
						sl_ws.close()
					})
		}
		function StopCamera() {
			//Close Websocket
			sl_ws.close();
		}

		function SendMessage(data) {

			//Close Websocket
			//	var data = $('#wsMessage').val();
			sl_ws.send(data);
		}
	window.onbeforeunload = function(event) {
		sl_ws.close();
	};
	StartCamera();
	</script>

</head>

<body class="in-frame">

	<!-- 头部导航 start -->
	<div id="header">
		<div class="w nav-list">
			<ul class="head-left-nav">
				<li>
					<p>CDSJSD</p>
				</li>
				<li><a href="html/control_management.html">控制管理</a>
					<!--不做操作-->
				</li>
				<li><a href="html/login.html">退出登录</a>
					<!--转登陆-->
				</li>
			</ul>

		</div>
	</div>
	<!-- 头部导航 end -->

	<table border="0" width="100%" cellpadding="3" cellspacing="0">
		<tr>
			<td align=center class="in-a-box" colspan=2><br> <img src="images/loading.gif" id="camerascreen" style="max-width: 640px; height: 700px\0/IE8 +9;"
				/> <br></td>
		</tr>
		<td class="btnList">
			<div class="btnBtn">
				<button class="btn btn-primary btn1" onclick="SendMessage(1)">
					<span class="glyphicon glyphicon-arrow-up"></span>
				</button>
				<button class="btn btn-primary btn2" onclick="SendMessage(2)">
					<span class="glyphicon glyphicon-arrow-down"></span>
				</button>
				<button class="btn btn-primary btn3" onclick="SendMessage(3)">
					<span class="glyphicon glyphicon-arrow-left"></span>
				</button>
				<button class="btn btn-primary btn4" onclick="SendMessage(4)">
					<span class="glyphicon glyphicon-arrow-right"></span>
				</button>
				<button class="btn btn-success btn6" onclick="StopCamera()">关闭
				</button>
			</div>
		</td>
		<tr>
			<td class="border-l-top" colspan=2></td>
		</tr>
	</table>

</body>
<%
	}
	%> 

</html>