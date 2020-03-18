<%@page import="org.apache.jasper.compiler.JavacErrorDetail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>chart</title>
<script src="assets/jquery/jquery-3.3.1.min.js"></script>

<link rel="stylesheet" href="css/chart.css" />
</head>
<body>
	<%
		String num = request.getParameter("num");
	%>

	<div class="content">
		<div class="navigation">
			<div class="showWay">
				<h2>显示时长选择</h2>
				<ul type="none">
					<li class="choice" id="1" class="ch">24小时
						<div class="youjian"></div>
						<div class="zuojian"></div>
					</li>
					<li class="unchoice" id="2" class="ch">24~48小时
						<div class="youjian"></div>
						<div class="zuojian"></div>
					</li>
					<li class="unchoice" id="3" class="ch">一周
						<div class="youjian"></div>
						<div class="zuojian"></div>
					</li>
				</ul>
			</div>
		</div>
		<div class="body">
		<a href="html/control_management.html">返回</a>
			<div class="main" id="main"></div>
		</div>
	</div>
</body>
<script src="assets/echarts/echarts.js"></script>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var num=<%=num%>;
        var flag=0;
    </script>
    <script src="./js/chart.js"></script>
</html>