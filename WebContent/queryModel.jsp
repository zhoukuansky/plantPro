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
	String userID = request.getParameter("user");
	String nowModel = request.getParameter("nowModel");
	nowModel = "'" + nowModel + "'";
	String nowDivice = request.getParameter("nowDivice");
	nowDivice = "'" + nowDivice + "'";

	Statement statement = conn.createStatement();

	String sql = "select * from PlantMode where user=" + userID + " and plantName=" + nowModel;
	//System.out.print(sql);
	ResultSet rs = statement.executeQuery(sql);

	String back = "";
	int count = 0;

	String updateSql0 = "";
	String updateSql1 = "";
	String updateSql2 = "";
	String updateSql3 = "";
	String updateSql4 = "";
	String updateSql5 = "";
	String updateSql6 = "";
	String updateSql7 = "";
	String updateSql8 = "";
	String updateSql9 = "";
	String updateSql10 = "";

	if (rs.next()) {
		ResultSet rss = statement.executeQuery(sql);
		while (rss.next()) {
			back = Double.toString(rss.getDouble(3));
			back = back + "~" + Double.toString(rss.getDouble(4));
			back = back + "~" + Double.toString(rss.getDouble(5));
			back = back + "~" + Double.toString(rss.getDouble(6));
			back = back + "~" + Double.toString(rss.getDouble(7));
			back = back + "~" + Double.toString(rss.getDouble(8));
			back = back + "~" + Double.toString(rss.getDouble(9));
			back = back + "~" + Double.toString(rss.getDouble(10));
			back = back + "~" + Double.toString(rss.getDouble(11));
			back = back + "~" + Double.toString(rss.getDouble(12));
			back = back + "~" + Double.toString(rss.getDouble(13));

			updateSql0 = "update Node1_Control set Sta=" + rss.getDouble(3) + " where diviceID=" + nowDivice
					+ " and Class='CO2浓度'";
			updateSql1 = "update Node1_Control set Sta=" + rss.getDouble(4) + " where diviceID=" + nowDivice
					+ " and Class='光照强度'";
			updateSql2 = "update Node1_Control set Sta=" + rss.getDouble(5) + " where diviceID=" + nowDivice
					+ " and Class='液位'";
			updateSql3 = "update Node1_Control set Sta=" + rss.getDouble(6) + " where diviceID=" + nowDivice
					+ " and Class='温度'";
			updateSql4 = "update Node1_Control set Sta=" + rss.getDouble(7) + " where diviceID=" + nowDivice
					+ " and Class='湿度'";
			updateSql5 = "update Node1_Control set Sta=" + rss.getDouble(8) + " where diviceID=" + nowDivice
					+ " and Class='TDS'";
			updateSql6 = "update Node1_Control set Sta=" + rss.getDouble(9) + " where diviceID=" + nowDivice
					+ " and Class='PH度'";
			updateSql7 = "update Node1_Control set Sta=" + rss.getDouble(10) + " where diviceID=" + nowDivice
					+ " and Class='水温'";
			updateSql8 = "update Node1_Control set Sta=" + rss.getDouble(11) + " where diviceID=" + nowDivice
					+ " and Class='水循环'";
			updateSql9 = "update Node1_Control set Sta=" + rss.getDouble(12) + " where diviceID=" + nowDivice
					+ " and Class='日照时间'";
			updateSql10 = "update Node1_Control set Sta=" + rss.getDouble(13) + " where diviceID=" + nowDivice
					+ " and Class='杀菌时间'";

			back = "*" + back + "*";
			System.out.print(back);
			out.print(back);
		}
	} else {
		sql = "select * from PlantMode where user=0 and plantName=" + nowModel;
		ResultSet rrss = statement.executeQuery(sql);

		while (rrss.next()) {
			back = Double.toString(rrss.getDouble(3));
			back = back + "~" + Double.toString(rrss.getDouble(4));
			back = back + "~" + Double.toString(rrss.getDouble(5));
			back = back + "~" + Double.toString(rrss.getDouble(6));
			back = back + "~" + Double.toString(rrss.getDouble(7));
			back = back + "~" + Double.toString(rrss.getDouble(8));
			back = back + "~" + Double.toString(rrss.getDouble(9));
			back = back + "~" + Double.toString(rrss.getDouble(10));
			back = back + "~" + Double.toString(rrss.getDouble(11));
			back = back + "~" + Double.toString(rrss.getDouble(12));
			back = back + "~" + Double.toString(rrss.getDouble(13));

			updateSql0 = "update Node1_Control set Sta=" + rrss.getDouble(3) + " where diviceID=" + nowDivice
					+ " and Class='CO2浓度'";
			updateSql1 = "update Node1_Control set Sta=" + rrss.getDouble(4) + " where diviceID=" + nowDivice
					+ " and Class='光照强度'";
			updateSql2 = "update Node1_Control set Sta=" + rrss.getDouble(5) + " where diviceID=" + nowDivice
					+ " and Class='液位'";
			updateSql3 = "update Node1_Control set Sta=" + rrss.getDouble(6) + " where diviceID=" + nowDivice
					+ " and Class='温度'";
			updateSql4 = "update Node1_Control set Sta=" + rrss.getDouble(7) + " where diviceID=" + nowDivice
					+ " and Class='湿度'";
			updateSql5 = "update Node1_Control set Sta=" + rrss.getDouble(8) + " where diviceID=" + nowDivice
					+ " and Class='TDS'";
			updateSql6 = "update Node1_Control set Sta=" + rrss.getDouble(9) + " where diviceID=" + nowDivice
					+ " and Class='PH度'";
			updateSql7 = "update Node1_Control set Sta=" + rrss.getDouble(10) + " where diviceID=" + nowDivice
					+ " and Class='水温'";
			updateSql8 = "update Node1_Control set Sta=" + rrss.getDouble(11) + " where diviceID=" + nowDivice
					+ " and Class='水循环'";
			updateSql9 = "update Node1_Control set Sta=" + rrss.getDouble(12) + " where diviceID=" + nowDivice
					+ " and Class='日照时间'";
			updateSql10 = "update Node1_Control set Sta=" + rrss.getDouble(13) + " where diviceID=" + nowDivice
					+ " and Class='杀菌时间'";

			back = "*" + back + "*";
			System.out.print(back);
			out.print(back);
		}
	}
//	System.out.print(updateSql0);
	statement.executeUpdate(updateSql0);
	statement.executeUpdate(updateSql1);
	statement.executeUpdate(updateSql2);
	statement.executeUpdate(updateSql3);
	statement.executeUpdate(updateSql4);
	statement.executeUpdate(updateSql5);
	statement.executeUpdate(updateSql6);
	statement.executeUpdate(updateSql7);
	statement.executeUpdate(updateSql8);
	statement.executeUpdate(updateSql9);
	statement.executeUpdate(updateSql10);

	rs.close();
	statement.close();
	conn.close();
%>