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
	String userName = request.getParameter("userName");
	String passWord = request.getParameter("passWord");

	System.out.print(passWord);
	Statement statement = conn.createStatement();
	String sql = "select * from user";
	ResultSet rs = statement.executeQuery(sql);
	while (rs.next()) {
		if (rs.getString("userName").equals(userName)) {
			if (rs.getString("passWord").equals(passWord)) {
				out.print("*0*");
			} else {
				out.print("*1*");
			}
		} else {
			out.print("*1*");
		}
	}
	
	rs.close();
    statement.close();
    conn.close();
%>