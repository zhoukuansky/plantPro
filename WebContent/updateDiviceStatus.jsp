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
	String nowDivice = request.getParameter("nowDivice");
	String nowModel = request.getParameter("nowModel");
	nowDivice="'"+nowDivice+"'";
	nowModel="'"+nowModel+"'";

	Statement statement = conn.createStatement();

	String sql = "update DiviceStatus set mode="+nowModel+" where diviceID="+nowDivice;
	System.out.print(sql);
	statement.executeUpdate(sql);

	out.print("*0*");

	statement.close();
	conn.close();
%>