<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection, java.net.*"%>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null; 
	String sql = "";
	
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
    <script>
    $(document).on("mobileinit", function(){
    	$("#list02").on("pageshow", function(){
    		roadView01();
    	});
    	$("#detail").on("pageshow", function(){
    		roadView02();
    	});
    });
    </script>
    
    
</head>
<body>   

 <div id="list01" data-role="page"  data-theme="c">
<%@ include file="include/header.jsp" %>
        <div data-role="content">
            <div id="brand">
                <h1><span>맛집</span><span>검색</span></h1>
            </div>
            <div class="choice_list">
                <h2><span><i class="ri-number-2"></i>지역을 선택하세요.</span></h2>
                <!-- list view -->
                <ul data-role="listview" data-filter="true" data-filter-placeholder="도시선택..." data-inset="true">
<%
	conn = SQLConnection.initConnection();
	String param = URLDecoder.decode(request.getParameter("sectordetail"));
	sql = "select sigundu from best_restaurant where sectordetail=? group by sigundu";
	try{
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, param);
		rs = pstmt.executeQuery();
		while(rs.next()){
			String city = rs.getString("sigundu");
			String enCity = URLEncoder.encode(city);
%>
<li><a href="list2.jsp?sectordetail=<%=request.getParameter("sectordetail") %>&city=<%=enCity%>"><%=city %></a></li>  
<%
		}
	}catch(Exception e){	
		e.printStackTrace();
	}finally{
		if(rs != null) try{rs.close(); }catch(SQLException e){}
		if(pstmt != null) try{pstmt.close(); }catch(SQLException e){}
		if(conn != null) try{conn.close(); }catch(SQLException e){}
	}
%>       
                 </ul>
            </div>
        </div>

<%@ include file="include/footer.jsp" %>
	</div>
	</body>
	</html>