<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection"%>
<jsp:useBean id="mem" class="myRest.MemberDTO"/>
<jsp:setProperty name="mem" property="*"/>    
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>맛집검색</title>
    <link rel="icon" href="images/cutlery.png">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Tilt+Prism&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/jquery.mobile-1.3.2.min.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d47e23997bea42a8ec210b8a061c7985"></script>
    <script src="js/jquery-1.12.4.min.js"></script>
    <script src="js/jquery.mobile-1.3.2.min.js"></script>
    <script src="js/custom.js"></script>
</head>
<body>   
<div id="memberlist" data-role="page"  data-theme="c">
<%@ include file="include/header.jsp" %>

<%
	if(UNUM == 0){
%>
<script>
	alert("에러가 발생했습니다.");
	document.location.href="index.jsp";
</script>
<%
	}else{
		conn = SQLConnection.initConnection();
		sql = "select * from members where number = ?"; 
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, UNUM);
			rs = pstmt.executeQuery();
			if(rs.next()){
				
%>


	<div data-role="content" >
	<form name="memberedit" action="memberedit.jsp" method="post" onSubmit="return checkForm();">
	<ul class="memberlist" data-role="listview" data-inset="true" data-divider-theme="s">
		<li data-role="list-divider">필수항목</li>
		<li data-role="fieldcontain">
            <label for="username">이름</label>
            <input type="text" name="username" id="username" value="<%=rs.getString("username") %>" data-clear-btn="true">
        </li>
        <li data-role="fieldcontain">
            <label for="userid">아이디</label>
            <input class="dupli" type="text" name="userid" id="userid" value="<%=rs.getString("userid") %>" readonly>
            <input type="hidden" name="idok" id="idok" value="notok">
        </li>
        <li data-role="fieldcontain">
            <label for="userpass">비밀번호</label>
            <input type="password" name="userpass" id="userpass" value="<%=rs.getString("userpass") %>" data-clear-btn="true">
        </li>
        
        <li data-role="fieldcontain" class="li-post">
           <label for="postcode">우편번호</label>
          	<input type="search" name="postcode" id="postcode" value="<%=rs.getString("postcode") %>"
          	data-clear-btn="true">
       </li>
        <li class="li-address">
          	<input type="text" name="address" id="address" value="<%=rs.getString("address") %>" readonly data-clear-btn="true">
          	<input type="text" name="detailAddress" id="detailAddress" value=" <%=rs.getString("detailaddress") %>" data-clear-btn="true"> 
        </li>
        <%
        	String chk1 = "", chk2 = "";
        		   if(rs.getString("gender").equals("남자")){
        				chk1 = "checked";
        				chk2 = "";
        		   }else{
        			   	chk1 = "";
       					chk2 = "checked";
        		   }
        %>
		<li data-role="list-divider">선택항목</li>
		<li data-role="fieldcontain">
            <label for="gender">성별</label>
            <div class="genderbox" id="gender">
                <label class="gender"><input type="radio" name="gender" value="남자" <%=chk1 %>>
                 남자</label>
                <label class="gender"><input type="radio" name="gender" value="여자"<%=chk2 %>>
                 여자</label>
            </div>

        </li>
        
        <%
        	String[] jobArray = {"프론트엔드 프로그래머","백엔드 프로그래머",
        						"풀스택 프로그래머","UI 디자이너", "입만 프로그래머"};
        	String[] hobbyArray = {"운동","여행",
								"독서","음악", "쇼핑"};
        %>
		
		<li data-role="fieldcontain">
            <label for="job0" class="job">직업</label>
            <select name="job" id="job0">
        <%
        	int i = 1; 
        	for(String jobs: jobArray){
        		if(rs.getString("job").equals(jobs)){
        			out.println("<option value=\"" + jobs + "\" name=\"job\" id=\"job" + i + "\" selected>" + jobs + "</option>");	
        		}else{
        			out.println("<option value=\"" + jobs +"\" name=\"job\" id=\"job" + i + "\">" + jobs + "</option>");
        		}
        		i++;
        	}
        	
        	
        %>
            </select>
        </li>
        <li data-role="fieldcontain" class="li-hobby">
        <label>취미</label>	
        <fieldset data-mini="true" id="hobby0" >
        
    	<%
    		int j = 1;
	    	for(String hobbys: hobbyArray){
	    		if(rs.getString("hobby").contains(hobbys)){
	    			out.println("<input type=\"checkbox\" name=\"hobby\" id=\"hobby" + j + "\" value=\"" + hobbys + "\" checked>");
	    			out.println("<label for=\"hobby" + j + "\">" + hobbys + "</label>");
	    		}else{
	    			out.println("<input type=\"checkbox\" name=\"hobby\" id=\"hobby" + j + "\" value=\""+ hobbys + "\">");
	    			out.println("<label for=\"hobby" + j + "\">" +hobbys + "</label>");
	    		}
	    		j++;
	    	}
    	%>
         </fieldset>
            
        </li>
        <li data-role="fieldcontain" >
            <label for="leftright">좌우명</label>
            <input type="text" name="leftright" id="leftright" value="<%=rs.getString("leftright") %>" data-clear-btn="true">
        </li>
	</ul>
	<div class="btnbox">
        <button type="submit" class="submit">수 정</button>
        
    </div><input type="hidden" name="num" value="<%=UNUM%>">
    </form>
</div>
	 <%
			}
		}catch(Exception e){
			
		}finally{
			if(rs != null) try{rs.close();} catch(SQLException e){}
			if(pstmt != null) try{pstmt.close();} catch(SQLException e){}
			if(conn != null) try{conn.close();} catch(SQLException e){}
		}
	}
	 %>
	<%@ include file="include/footer.jsp" %>
	 
	 <div id="popupPostcode" style="display:none;position:fixed;overflow:hidden;z-index:100;-webkit-overflow-scrolling:touch;">
         <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" alt="닫기 버튼">
      </div>
</div>
</body>
</html>