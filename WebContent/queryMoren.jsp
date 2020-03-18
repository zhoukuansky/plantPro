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

<%
	String name = request.getParameter("name");
	String userID = request.getParameter("userID");

	name = "'" + name + "'";
	userID = "'" + userID + "'";

	Statement statement = conn.createStatement();

	String sql = "select * from PlantMode where user='0' and plantName=" + name;
	System.out.print(sql);
	ResultSet rs = statement.executeQuery(sql);

	String back = "";
	int count = 0;

	if (rs.next()) {
		rs = statement.executeQuery(sql);
		while (rs.next()) {
			back = rs.getString("CO2浓度");
			back = back + "~" + rs.getString("光照强度");
			back = back + "~" + rs.getString("液位");
			back = back + "~" + rs.getString("温度");
			back = back + "~" + rs.getString("湿度");
			back = back + "~" + rs.getString("TDS");
			back = back + "~" + rs.getString("PH度");
			back = back + "~" + rs.getString("水温");
			back = back + "~" + rs.getString("水循环时间");
		}
	} else {
		out.print("*0*");
	}

	back = "*" + back + "*";
	out.print(back);

	rs.close();
	statement.close();
	conn.close();
%>