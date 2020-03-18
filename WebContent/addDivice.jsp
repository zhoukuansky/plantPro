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
    String userID = request.getParameter("userID");
    userID="'"+userID+"'";
    String input = request.getParameter("input");
    
	Statement statement = conn.createStatement();

	String sql = "insert into Divice VALUES ("+userID+",'"+input+"')";
	System.out.print(sql);
	statement.executeUpdate(sql);
	
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 0, 'CO2浓度', 728.00, 101, '1', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 1, '光照强度', 155.00, 100, '1', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 2, '液位', 1134.00, 20, '1', 1)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 3, '温度', 31.00, 20, '0', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 4, '湿度', 70.00, 50, '1', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 5, 'TDS', 0.00, 61, '1', 1)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 6, 'PH度', 12.00, 71, '0', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 7, '水温', 27.00, 10, '0', 1)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 8, '水循环', 15.00, 11, '0', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 9, '日照时间', 0, 0, '0', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 10, '杀菌时间', 0, 0, '0', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 19, 'photo', 0.00, 0, '1', 0)";
	statement.executeUpdate(sql);
	sql="INSERT INTO `Node1_Control` VALUES ('"+input+"', 20, 'vide', 1.00, 0, '1', 0)";
	statement.executeUpdate(sql);
	
	String sqlsql = "select * from PlantMode where user=" + userID;
	ResultSet rs = statement.executeQuery(sqlsql);
	
	int n=0;
	String name="";
	while(rs.next()){
		if(n==0){
			name=rs.getString("plantName");
		}
		n++;
	}
	name="'"+name+"'";
	sql="insert into DiviceStatus values ('"+input+"', 0,0, "+name+")";
	System.out.print(sql);
	statement.executeUpdate(sql);
	
	out.print("*0*");
	rs.close();
    statement.close();
    conn.close();
%>