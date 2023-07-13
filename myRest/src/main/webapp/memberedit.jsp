<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, myRest.SQLConnection, java.net.*, java.time.*, java.time.format.DateTimeFormatter"%>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	InetAddress local = null;
	String ip = "", sql = "";	
%>  
<jsp:useBean id = "mem" class="myRest.MemberDTO"/>
<jsp:setProperty name = "mem" property="*"/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	// 아이피 주소
	try{
		local = InetAddress.getLocalHost();
		}catch(UnknownHostException e){}
	
	if(local != null){ ip = local.getHostAddress();};
	
	// 현재날짜
	LocalDateTime now = LocalDateTime.now();
	DateTimeFormatter fo = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	String edtday = now.format(fo);
	
	// 취미 배열을 하나로 합침 (띄어쓰기 기준으로)
	String[] hobby = mem.getHobby();
	String edthobby = "";
	
	for(String h : hobby){
		edthobby += h + " ";
	}

	// sql 문 구성
	if(mem.getUserpass() == null){
		sql = "update members set username = ?, gender = ?, postcode = ?, address = ?, detailAddress = ?, job = ?, hobby = ?, leftright = ?, writeDay = ?, writeIP = ?";
		sql += " where number = ?";	
	}else{
		sql = "update members set username = ?, userpass = '" + mem.getUserpass() + "', gender = ?, postcode = ?, address = ?, detailAddress = ?, job = ?, hobby = ?, leftright = ?, writeDay = ?, writeIP = ?";
		sql += " where number = ?";
	}
	
	conn = SQLConnection.initConnection();

	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mem.getUsername());
		pstmt.setString(2, mem.getGender());
		pstmt.setInt(3, mem.getPostcode());
		pstmt.setString(4, mem.getAddress());
		pstmt.setString(5, mem.getDetailAddress());
		pstmt.setString(6, mem.getJob());
		pstmt.setString(7, edthobby);
		pstmt.setString(8, mem.getLeftright());
		pstmt.setString(9, edtday);
		pstmt.setString(10, ip);
		pstmt.setInt(11, num);
		// System.out.println("pstmt");
		int rows = pstmt.executeUpdate();
		response.sendRedirect("index.jsp");



		}catch(SQLException r){
			
		}finally{
			if(pstmt != null) try{pstmt.close(); } catch(SQLException r){}
			if(conn != null) try{conn.close(); } catch(SQLException r){}
		}
%>  
