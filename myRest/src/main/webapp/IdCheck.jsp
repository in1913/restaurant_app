<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	form{
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    form p{
    	text-align: center;	
    }
    .successbox{
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .box{
    	display: flex;
    }
    input, button{
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 5px 10px;
        margin-right: 5px;
    }
</style>
<body>
<br>
<br>
<%!
	Boolean ok = false;
%>
<%
	String uid = request.getParameter("uid");


	// 접속
	Connection conn = SQLConnection.initConnection();
	String sql = "select userId from members where userId = ?";
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, uid);
		
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			ok = true;
		}else{
			ok = false;
		}
	}catch(Exception e){
		
	}finally{
		if(conn != null){
		    try{
		        conn.close();
		    }catch(SQLException e){
		        
		    }
		}
	}
	if(ok){		
%>
<form>
        <p>[<%=uid %>]는 사용할 수 없습니다.<br> 다시 입력하세요.</p>
        <div class="box">	
        	<input type="text" name="uid" placeholder="아이디를 입력하세요.">
        	<button type="submit">중복확인</button>
        </div>
</form>
<%
	}else{
		
%>
<div class="successbox">
        <p>[<%=uid%>]는 사용할 수 있습니다.</p>
        <button onclick="ok();">닫기</button>
</div>
<% 
}
%>
<script>
function ok(){
	opener.document.memberform.userid.value = "<%=uid%>";
	opener.document.memberform.idok.value = "ok";
	self.close();
}
</script>

</body>
</html>