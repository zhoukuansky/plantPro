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
    String sun = request.getParameter("sun");
    nowDivice="'"+nowDivice+"'";

	Statement statement = conn.createStatement();

	String sql = "update Node1_Control set AuTo="+sun+" where Class='光照强度' and diviceID="+nowDivice;
//	System.out.println(sql);
	statement.executeUpdate(sql);

	out.print("*0*");

	statement.close();
	conn.close();
%>