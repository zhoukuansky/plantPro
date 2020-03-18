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
	

	name = "'" + name + "'";
	userID = "'" + userID + "'";

	Statement statement = conn.createStatement();

	String sql ="insert into PlantMode value ("+userID+","+name+","+co2+","+sun+","+waterHeight+","+temperature+","+humidity+","+TDS+","+PH+","+water+","+cycle+","+sunTime+","+sterilize+",'')";
	System.out.print(sql);
	statement.executeUpdate(sql);

	out.print("*0*");

	statement.close();
	conn.close();
%>