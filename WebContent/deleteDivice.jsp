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
	String deleteId = request.getParameter("deleteId");
	String userId = request.getParameter("userId");
	deleteId = "'" + deleteId + "'";
	userId = "'" + userId + "'";

	Statement statement = conn.createStatement();

	String sql = "delete from Divice where userName=" + userId + " and diviceID=" + deleteId;
	statement.executeUpdate(sql);

	String sqlQuery = "select * from Divice where diviceID=" + deleteId;
	ResultSet rs = statement.executeQuery(sqlQuery);
	if (rs.next()) {

	} else {
		sql = "delete from DiviceStatus where diviceID=" + deleteId;
		statement.executeUpdate(sql);
		sql = "delete from Node1_Control where diviceID=" + deleteId;
		statement.executeUpdate(sql);
	}

	out.print("*0*");

	statement.close();
	conn.close();
%>