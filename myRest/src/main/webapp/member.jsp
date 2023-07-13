<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.net.*, java.time.*, java.time.format.DateTimeFormatter, myRest.SQLConnection"
    %>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	InetAddress local = null;
	String ip = "", sql = "";
	int rows;
%>
<!-- 클래스 빈이름 = new 클래스();와 동일한 의미 -->
<jsp:useBean id="mem" class="myRest.MemberDTO"/>
<!-- 자바빈 파일의 setter메소드를 사용하기 위해 쓴다. -->
<jsp:setProperty name="mem" property="*"/>    
<%
	// 아이피 주소 입력
	try{
		local = InetAddress.getLocalHost();
	}catch(UnknownHostException e){
		
	}
	if(local != null){
		ip = local.getHostAddress();
	}	
	
	/*
		현재 날짜 받기
		LocalDateTime 을 이용해 년월일시분초를 받은 후
		DateTimeFormatter를 이용해 yyyy-mm-dd hh:mm:ss 형식으로 출력
	*/

	// 현재 날짜 받기 yyyy-mm-dd hh:mm:ss
	LocalDateTime now = LocalDateTime.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	String writeDay = now.format(formatter);
	
	
	// 배열로 받은 값을 하나로 합침
	String[] hobby = mem.getHobby();
	for(int i = 0; i < hobby.length; i++){
		System.out.println(hobby[i]);
	}
	String strhobby = "";
	for(String h : hobby){
		strhobby += h + " ";
	}
	sql = "insert into members (";
	sql += "userName, userId, userPass, gender, postcode, address, detailAddress, job, hobby, LeftRight, writeDay, writeIP";
	sql += ") values (?,?,?,?,?,?,?,?,?,?,?,?)";
	
	// 접속
	conn = SQLConnection.initConnection();
	
	try{
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, mem.getUsername());
		pstmt.setString(2, mem.getUserid());
		pstmt.setString(3, mem.getUserpass());
		pstmt.setString(4, mem.getGender());
		pstmt.setInt(5, mem.getPostcode());
		pstmt.setString(6, mem.getAddress());
		pstmt.setString(7, mem.getDetailAddress());
		pstmt.setString(8, mem.getJob());
		pstmt.setString(9, strhobby);
		pstmt.setString(10, mem.getLeftright());
		pstmt.setString(11, writeDay);
		pstmt.setString(12, ip);
		
		System.out.println(pstmt);
		rows = pstmt.executeUpdate();
		
		if(rows > 0){
			response.sendRedirect("index.jsp");			 
		}
		
		pstmt.close();
		
	}catch(SQLException e){
		
	}finally{
		if(conn != null){
			try{
				conn.close();
			}catch(SQLException e){
				
			}
		}
	}
	
%>