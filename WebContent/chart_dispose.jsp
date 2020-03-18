<%@page import="org.apache.jasper.compiler.JavacErrorDetail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="SQL.jsp"%>

<%
	String num = request.getParameter("num");
	String divice = request.getParameter("divice");
	String flag = request.getParameter("flag");

	// 3 用来执行SQL语句
	Statement statement = conn.createStatement();
	String sql;

	if (flag.equals("0")) {
		if (num.equals("0")) {
			sql = "SELECT * from Node1_CO2浓度  where date >=(NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("1")) {
			sql = "SELECT * from Node1_光照强度  where date >=(NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("2")) {
			sql = "SELECT * from Node1_液位  where date >=(NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("3")) {
			sql = "SELECT * from Node1_温度  where date >=(NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("4")) {
			sql = "SELECT * from Node1_湿度  where date >=(NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("5")) {
			sql = "SELECT * from Node1_TDS  where date >=(NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("6")) {
			sql = "SELECT * from Node1_PH度  where date >=(NOW() - interval 24 hour) and diviceID="+divice;
		} else {
			sql = "SELECT * from Node1_水温  where date >=(NOW() - interval 24 hour) and diviceID="+divice;
		}
		ResultSet rs = statement.executeQuery(sql);

		String[] dateString = new String[1000];
		String[] timeString = new String[1000];
		String[] valeData = new String[1000];
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm:ss");
		Date date;
		Time time;
		int count = 0;
		while (rs.next()) {
			date = rs.getDate("date");
			dateString[count] = formatDate.format(date);
			time = rs.getTime("date");
			timeString[count] = formatTime.format(time);
			valeData[count] = Integer.toString(rs.getInt("vale"));
			count++;
		}
		String[] dateTime = new String[count];
		String[] vale = new String[count];
		for (int i = 0; i < count; i++) {
			dateTime[i] = dateString[i] + " " + timeString[i];
			vale[i] = valeData[i];
		}

		String s = "~";
		String dataDateTime = "";
		String dataVale = "";
		for (int i = 0; i < dateTime.length; i++) {
			if (i < count - 1)
				dateTime[i] += s;
		}
		for (int i = 0; i < vale.length; i++) {
			if (i < count - 1)
				vale[i] += s;
		}

		for (int i = 0; i < dateTime.length; i++) {
			dataDateTime = dataDateTime + dateTime[i];
		}
		for (int i = 0; i < vale.length; i++) {
			dataVale = dataVale + vale[i];
		}
		String string = "*" + dataDateTime + "*" + dataVale + "*";

		out.println(string);
		rs.close();
		statement.close();
		conn.close();
	} else if (flag.equals("1")) {
		if (num.equals("0")) {
			sql = "SELECT * from Node1_CO2浓度  where date BETWEEN (NOW() - interval 48 hour) and (NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("1")) {
			sql = "SELECT * from Node1_光照强度  where date BETWEEN (NOW() - interval 48 hour) and (NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("2")) {
			sql = "SELECT * from Node1_液位  where date BETWEEN (NOW() - interval 48 hour) and (NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("3")) {
			sql = "SELECT * from Node1_温度  where date BETWEEN (NOW() - interval 48 hour) and (NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("4")) {
			sql = "SELECT * from Node1_湿度  where date BETWEEN (NOW() - interval 48 hour) and (NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("5")) {
			sql = "SELECT * from Node1_TDS  where date BETWEEN (NOW() - interval 48 hour) and (NOW() - interval 24 hour) and diviceID="+divice;
		} else if (num.equals("6")) {
			sql = "SELECT * from Node1_PH度  where date BETWEEN (NOW() - interval 48 hour) and (NOW() - interval 24 hour) and diviceID="+divice;
		} else {
			sql = "SELECT * from Node1_水温  where date BETWEEN (NOW() - interval 48 hour) and (NOW() - interval 24 hour) and diviceID="+divice;
		}
		ResultSet rs = statement.executeQuery(sql);

		String[] dateString = new String[1000];
		String[] timeString = new String[1000];
		String[] valeData = new String[1000];
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm:ss");
		Date date;
		Time time;
		int count = 0;
		while (rs.next()) {
			date = rs.getDate("date");
			dateString[count] = formatDate.format(date);
			time = rs.getTime("date");
			timeString[count] = formatTime.format(time);
			valeData[count] = Integer.toString(rs.getInt("vale"));
			count++;
		}
		String[] dateTime = new String[count];
		String[] vale = new String[count];
		for (int i = 0; i < count; i++) {
			dateTime[i] = dateString[i] + " " + timeString[i];
			vale[i] = valeData[i];
		}

		String s = "~";
		String dataDateTime = "";
		String dataVale = "";
		for (int i = 0; i < dateTime.length; i++) {
			if (i < count - 1)
				dateTime[i] += s;
		}
		for (int i = 0; i < vale.length; i++) {
			if (i < count - 1)
				vale[i] += s;
		}

		for (int i = 0; i < dateTime.length; i++) {
			dataDateTime = dataDateTime + dateTime[i];
		}
		for (int i = 0; i < vale.length; i++) {
			dataVale = dataVale + vale[i];
		}
		String string = "*" + dataDateTime + "*" + dataVale + "*";

		out.println(string);
		rs.close();
		statement.close();
		conn.close();
	} else {
		if (num.equals("0")) {
			sql = "SELECT * from Node1_CO2浓度  where date >=(NOW() - interval 168 hour) and diviceID="+divice;
			System.out.print(sql);
		} else if (num.equals("1")) {
			sql = "SELECT * from Node1_光照强度  where date >=(NOW() - interval 168 hour) and diviceID="+divice;
		} else if (num.equals("2")) {
			sql = "SELECT * from Node1_液位  where date >=(NOW() - interval 168 hour) and diviceID="+divice;
		} else if (num.equals("3")) {
			sql = "SELECT * from Node1_温度  where date >=(NOW() - interval 168 hour) and diviceID="+divice;
		} else if (num.equals("4")) {
			sql = "SELECT * from Node1_湿度  where date >=(NOW() - interval 168 hour) and diviceID="+divice;
		} else if (num.equals("5")) {
			sql = "SELECT * from Node1_TDS  where date >=(NOW() - interval 168 hour) and diviceID="+divice;
		} else if (num.equals("6")) {
			sql = "SELECT * from Node1_PH度  where date >=(NOW() - interval 168 hour) and diviceID="+divice;
		} else {
			sql = "SELECT * from Node1_水温  where date >=(NOW() - interval 168 hour) and diviceID="+divice;
		}
		ResultSet rs = statement.executeQuery(sql);

		String[] dateString = new String[1000];
		String[] timeString = new String[1000];
		int[] valeData = new int[1000];
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm:ss");
		Date date;
		Time time;
		int count = 0;
		while (rs.next()) {
			date = rs.getDate("date");
			dateString[count] = formatDate.format(date);
			time = rs.getTime("date");
			timeString[count] = formatTime.format(time);
			valeData[count] = rs.getInt("vale");
			count++;
		}
		String[] dateTime = new String[count];
		int[] vale = new int[count];
		//去掉数组中空的部分
		for (int i = 0; i < count; i++) {
			dateTime[i] = dateString[i];
			vale[i] = valeData[i];
		}

		double[] a = { 1, 1, 1, 1, 1, 1, 1, 1 };
		int[] number = new int[8];
		String[] weekDate = new String[8];
		weekDate[0] = dateTime[0];
		int j = 0;

		for (int i = 0; i < count; i++) {
			if (i < count - 1) {
				if (dateTime[i].equals(dateTime[i + 1])) {
					a[j] += 1;
					number[j] += vale[i];
				} else {
					number[j] += vale[i];
					j++;
					weekDate[j] = dateTime[i + 1];
				}
			} else {
				number[j] += vale[i];
			}
		}

		/* 		System.out.println(j);
				System.out.print(a[0]+" ");
				System.out.print(number[0]+" ");
				System.out.println(weekDate[0]);
				System.out.print(a[1]+" ");
				System.out.print(number[1]+" ");
				System.out.println(weekDate[1]);
				System.out.print(a[2]+" ");
				System.out.print(number[2]+" ");
				System.out.println(weekDate[2]); */

		//去掉数组中空的部分
		String[] realNumber = new String[j + 1];
		String[] realWeekDate = new String[j + 1];
		for (int i = 0; i < realNumber.length; i++) {
			realNumber[i] = Double.toString(number[i] / a[i]);
			realWeekDate[i] = weekDate[i];
		}

		/* 		System.out.println(realNumber.length);
				System.out.println(realNumber.length); */

		String s = "~";
		String dataDateTime = "";
		String dataVale = "";
		for (int i = 0; i < realNumber.length; i++) {
			if (i < j)
				realNumber[i] += s;
		}
		for (int i = 0; i < realNumber.length; i++) {
			if (i < j)
				realWeekDate[i] += s;
		}

		for (int i = 0; i < realWeekDate.length; i++) {
			dataDateTime = dataDateTime + realWeekDate[i];
		}
		for (int i = 0; i < realNumber.length; i++) {
			dataVale = dataVale + realNumber[i];
		}

		String string = "*" + dataDateTime + "*" + dataVale + "*";

		out.println(string);
		rs.close();
		statement.close();
		conn.close();
	}
%>







