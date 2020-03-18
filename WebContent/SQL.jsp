<%@page import="org.apache.jasper.compiler.JavacErrorDetail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.Timer"%>
<%@ page import="java.util.TimerTask"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%
	String driver = "com.mysql.jdbc.Driver";
	//URL指向要访问的数据库名test1
//	String url = "jdbc:mysql://localhost:3306/plant?useUnicode=true&characterEncoding=utf8&autoReconnect=true&failOverReadOnly=false";
	String url = "jdbc:mysql://39.106.207.109:8033/plant?useUnicode=true&characterEncoding=utf8&autoReconnect=true&failOverReadOnly=false";
//	String url = "jdbc:mysql://39.108.74.92:32686/plant?useUnicode=true&characterEncoding=utf8&autoReconnect=true&failOverReadOnly=false";
//String url = "jdbc:mysql://10.4.208.78:32409/plant?useUnicode=true&characterEncoding=utf8&autoReconnect=true&failOverReadOnly=false&useSSL=false";
    
//MySQL配置时的用户名
	String user = "root";
	//Java连接MySQL配置时的密码
	String password = "123456";
	// 1 加载驱动程序
	Class.forName(driver);

	// 2 连接数据库
	Connection conn = DriverManager.getConnection(url, user, password);
	// 3 用来执行SQL语句
	//    Statement statement = conn.createStatement();
%>