<%@page import="org.apache.jasper.compiler.JavacErrorDetail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="showPhoto.*"%>
<%@ include file="SQL.jsp"%>
<%
	String mark = request.getParameter("mark");

	Statement statement = conn.createStatement();
	String sql;
	if (mark.equals("0")) {
		 sql = "select * from photo order by id desc limit 1";
	} else {
		 sql = "select * from photo where id="+mark;
	}
	ResultSet rs = statement.executeQuery(sql);
	int[] num = new int[1];
	String[] time = new String[1];
	int count = 0;
	while (rs.next()) {
		num[0] = rs.getInt("id");
		time[0] = rs.getString("name");
		count++;
	}
	System.out.println("1");

	String text;
	String a;

	a = Integer.toString(num[0]);
	//text = "/webapps/ROOT/images/" + a + ".jpg";
	text = "./plantPro/WebContent/images/" + a + ".jpg";
	ImageDemo.readDB2ImageId(text, num[0]);
	//    		ImageDemo.readDB2ImageId("./webapps/plant/image/1.jpg", 1);

	String s = "~";

	String data = a + s + time[0];

	String dataBack = "*" + data + "*";
	System.out.print(dataBack);
	out.println(dataBack);
	rs.close();
	statement.close();
	conn.close();
%>