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
<%@ page import="showPhoto.*"%>
<%@ page import="cn.gwj.PlantDetect.*"%>
<%@ page import="com.*"%>

<%
String aa=this.getClass().getClassLoader().getResource("../../images/0.jpg").getPath();
System.out.println(aa);
///String bb="/usr/local/tomcat/webapps/ROOT/images/0.jpg";
String result="";
try{
	result=PlantDemo.getPlantResult(aa);
	System.out.print(result);
}catch(Exception e){
	result="{\"log_id\": 0, \"result\": [{\"score\": 0, \"name\": \"识别失败\"}]}";
}
finally{
	out.print(result);
}

//{"log_id": 7749522987805042151, "result": [{"score": 0, "name": "非植物"}]}
%>