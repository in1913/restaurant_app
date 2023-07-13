<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myRest.SQLConnection, java.sql.*, java.net.*"%>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	InetAddress local = null;
	String ip = "", sql = "";
%>
<jsp:useBean id="rv" class="myRest.ReviewDTO" />
<jsp:setProperty name="rv" property="*" />

<jsp:getProperty name="rv" property="rnum"/>