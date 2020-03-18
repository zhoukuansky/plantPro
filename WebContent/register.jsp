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

	Statement statement = conn.createStatement();

	String sql = "select userName from user";
	String sqlAdd="insert into user values("+userName+","+passWord+")";
	ResultSet rs = statement.executeQuery(sql);
	int mark=0;
	while (rs.next()) {
		if (rs.getString("userName").equals(userName)) {
			out.print("*1*");
			mark=1;
		}
	}
	if(mark==0){
		statement.executeUpdate(sqlAdd);
		out.print("*0*");
	}
//	System.out.println(sql);

	statement.close();
	conn.close();
%>