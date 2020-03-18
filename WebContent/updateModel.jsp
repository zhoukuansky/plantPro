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
	String word = request.getParameter("word");
	String userID = request.getParameter("userID");
	String name = request.getParameter("name");
	String co2 = request.getParameter("co2");
	String PH = request.getParameter("PH");
	String TDS = request.getParameter("TDS");
	String sun = request.getParameter("sun");
	String water = request.getParameter("water");
	String waterHeight = request.getParameter("waterHeight");
	String temperature = request.getParameter("temperature");
	String humidity = request.getParameter("humidity");
	String cycle = request.getParameter("cycle");
	String sunTime = request.getParameter("sunTime");
	String sterilize = request.getParameter("sterilize");

	word = "'" + word + "'";
	userID = "'" + userID + "'";
	name = "'" + name + "'";
	co2 = "'" + co2 + "'";
	PH = "'" + PH + "'";
	sun = "'" + sun + "'";
	TDS = "'" + TDS + "'";
	water = "'" + water + "'";
	waterHeight = "'" + waterHeight + "'";
	temperature = "'" + temperature + "'";
	humidity = "'" + humidity + "'";
	cycle = "'" + cycle + "'";
	sunTime = "'" + sunTime + "'";
	sterilize = "'" + sterilize + "'";

	Statement statement = conn.createStatement();

	String sql = "update PlantMode set plantName=" + name + ",CO2浓度=" + co2 + ",光照强度=" + sun + ",液位="
			+ waterHeight + ",温度=" + temperature + ",湿度=" + humidity + ",TDS=" + TDS + ",PH度=" + PH + ",水温="
			+ temperature + ",水循环时间=" + cycle + ",日照时间=" + sunTime+ ",杀菌时间=" + sterilize + " where user=" + userID + " and plantName=" + word;
	System.out.print(sql);
	statement.executeUpdate(sql);

	out.print("*0*");

	statement.close();
	conn.close();
%>