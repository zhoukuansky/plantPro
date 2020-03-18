<%@page import="org.apache.jasper.compiler.JavacErrorDetail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.Timer"%>
<%@ page import="java.util.TimerTask"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="SQL.jsp"%>
<%@ page import="showPhoto.*"%>

<%
	String first = request.getParameter("first");
	String divice = request.getParameter("divice");
	divice = "'" + divice + "'";
	Statement statement = conn.createStatement();

	System.out.println(3);

	String sql = "update Node1_Control set AuTo=1 WHERE Class='photo' and diviceID=" + divice;

	if (first.equals("0")) {
		System.out.println(4);
		statement.executeUpdate(sql);
	}

	String sqlsql = "SELECT * from Node1_Control WHERE Class='photo' and diviceID=" + divice;
	System.out.println(5);
	ResultSet rs = statement.executeQuery(sqlsql);

	String[] a = new String[1];
	while (rs.next()) {
		a[0] = rs.getString("Auto");
		System.out.println(6);
	}

	if (a[0].equals("0")) {
		String aa = this.getClass().getClassLoader().getResource("../../images/0.jpg").getPath();
		System.out.println(aa);
		
		//String bb="/usr/local/tomcat/webapps/ROOT/images/0.jpg";
		ImageDemo.readDB2ImageId(aa, 1);
		//"./webapps/ROOT/images/0.jpg"
		//./webapps/plant/image/1.jpg
		System.out.println("关");
		out.println("*0*");
	} else {
		System.out.println("开");
		out.println("*1*");
	}

	//    String aaa="update Node1_Control set Auto=0 where Class='photo' and diviceID="+divice;
	//    System.out.println(aaa);
	//    statement.executeUpdate(aaa);

	rs.close();
	statement.close();
	conn.close();
%>