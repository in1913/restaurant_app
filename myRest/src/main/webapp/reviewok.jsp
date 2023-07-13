<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection, java.net.*"
%>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	InetAddress local = null;
	String ip = "", sql = "";	
	
%> 
<jsp:useBean id="rv" class="myRest.ReviewDTO"></jsp:useBean>
<jsp:setProperty property="*" name="rv" />

<%
	// ip주소
	try{
		local = InetAddress.getLocalHost(); 
	}catch(Exception e){}
	if(local != null)ip = local.getHostAddress();
	
	sql = "insert into review (rnum, unum, star, content, writeip) values (?, ?, ?, ?, ?)";
	conn = SQLConnection.initConnection();
	
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, rv.getRnum());
		pstmt.setInt(2, rv.getUnum());
		pstmt.setInt(3, rv.getStar());
		pstmt.setString(4, rv.getContent());
		pstmt.setString(5, ip);
		System.out.println(pstmt);
		int rows = pstmt.executeUpdate();
		
		if(rows > 0){
			System.out.println("입력 완료");
			
			
			%>
			<%=rv.getRnum()%>
			<%
		}else{
		%>
		0
		<%
		}
		pstmt.close();
		
	}catch(SQLException e){
		
	}finally{
		if(pstmt!= null) try{ pstmt.close(); }catch(SQLException e){}
		if(conn!= null) try{ conn.close(); }catch(SQLException e){}
	}
	







%>