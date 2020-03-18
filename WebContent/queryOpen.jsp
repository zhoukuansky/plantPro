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
	String diviceID = request.getParameter("diviceID");

	Statement statement = conn.createStatement();

	String sql = "select * from Node1_Control where diviceID=" + diviceID+" LIMIT 1";
	ResultSet rs = statement.executeQuery(sql);
	String back = "";
	int count = 0;
	while (rs.next()) {
			back = rs.getString("AuTo");
			
	}
	back = "*"+back + "*";
	out.print(back);
	rs.close();
    statement.close();
    conn.close();
%>