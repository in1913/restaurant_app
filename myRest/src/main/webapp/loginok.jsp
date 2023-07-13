<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.net.*, myRest.SQLConnection" 
 %>   
<%!
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "", ip="";
    Boolean ok = false;
    InetAddress local = null;
    int num = 0;
%>  
<% 
    String userid = request.getParameter("userid");
    String userpass = request.getParameter("userpass");
    
    if(userid == "" || userpass== "") {
       ok = false;
    }else{

    conn = SQLConnection.initConnection();
    sql ="select * from members where userid=? and userpass=?";

    try{
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, userid);
      pstmt.setString(2, userpass);
      ResultSet rs = pstmt.executeQuery();
      if(rs.next()){
         ok = true;
         // while(rs.next()){
        	 num = rs.getInt("number");	 
         // }
         
      }else{
    	  ok = false;
      }
      
   }catch(Exception e){}
 }
   
    if(ok == true) {
       //세션저장
       	session.setAttribute("UID", userid);
       	if(num > 0){
    		session.setAttribute("UNUM", num);   
       	}
       	session.setMaxInactiveInterval(60*60);
       	//로그인 테이블에 입력
       
        //아이피 주소 받기
        try{
            local = InetAddress.getLocalHost();       
        }catch(UnknownHostException e){
    
        }
        if(local != null){
             ip = local.getHostAddress();
        }
       
        sql = "insert into login (userid, loginip) values (?,?)";  
        //접속      
        try{
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, userid);
          pstmt.setString(2, ip);
          System.out.print(pstmt);
          int rows = pstmt.executeUpdate();
        
          String url = request.getParameter("rUrl");
          String prm = request.getParameter("rParam");
             //request rUrl, rParam 를 가지고 원래 페이지로 되돌려 보냄
          response.sendRedirect(url+"?"+prm);
          
        }catch(Exception e){
        }finally{
           if(rs != null) try{ rs.close(); } catch(SQLException e){}
            if(pstmt != null) try{pstmt.close(); } catch(SQLException e){}
            if(conn != null) try{ conn.close(); } catch(SQLException e){}
        }   
           
       
    }else{
       //경고
  %>
     <script>
       alert("문제가 발생했습니다. 다시 시도하세요.");
       location.href="index.jsp";
     </script>
  <%     
    }  
 %>