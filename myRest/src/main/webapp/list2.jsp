<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection, java.net.*"%>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null, pstmt2 = null;
	ResultSet rs = null; 
	ResultSet rs2 = null; 
	ResultSet row = null;
	String sql = "", sql2 = "", sql3 = "";
	int pg = 1, allColumn = 0, totalPages = 0;
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
    <script src="js/jquery-1.12.4.min.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d47e23997bea42a8ec210b8a061c7985"></script>
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
<%
	String tempPage = request.getParameter("cpage");
	// 현재페이지	
	if(tempPage == null || tempPage.length() == 0){
		pg = 1;
	}
	try{
		pg = Integer.parseInt(tempPage);
	}catch(NumberFormatException e){
		pg = 1;
	}
	
	int lmt = (pg - 1) * 10;
	totalPages = allColumn % 10 == 0 ? (int) allColumn / 10 :(int) (allColumn / 10) + 1; 
	
	conn = SQLConnection.initConnection();
	String param = URLDecoder.decode(request.getParameter("sectordetail"));
	String param2 = URLDecoder.decode(request.getParameter("city"));
	sql = "select count(*) from best_restaurant where sectordetail = ? and sigundu = ?";
	sql2 = "select * from best_restaurant where sectordetail = ? and sigundu = ? order by num desc limit ?, 10";
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, param);
		pstmt.setString(2, param2);
		row = pstmt.executeQuery();
		if(row.next()){
			allColumn = row.getInt(1);
		}
		pstmt.clearParameters();
		row.close();
		
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, param);
		pstmt.setString(2, param2);
		pstmt.setInt(3, lmt);
		rs = pstmt.executeQuery();
%>
	<div id="list02" data-role="page" data-theme="c">
	<%@ include file="include/header.jsp" %>
        <div data-role="content">
            <div id="brand">
                <h1><span>맛집</span> <span>검색</span></h1>
                <h3>종류 : <%=param %>, 지역 : <%=param2 %> [<%=allColumn %>개의 상점]</h3>
            </div>
            <div class="choice_list">
                <h2><span class="number"><i class="ri-number-3"></i></span>음식점을 선택하세요.</h2>
                <!-- listview -->
                <ul id="restaurant_v" data-role="listview" data-inset="true">
<%		
		while(rs.next()){
			String city = rs.getString("sigundu");
			String enCity = URLEncoder.encode(city);
			int num = rs.getInt("num");
%>
		
					<li>
					<input type="hidden" class="lat" name="lat" value="<%=rs.getFloat("lat")%>"/>
					<input type="hidden" class="lon" name="lon" value="<%=rs.getFloat("lon")%>"/>
                        <a href="detail.jsp?num=<%=num %>" data-transition="slidedown">   
                        <div class="roadView"></div>
                        <div class="context-box">
                            <h3><%=rs.getString("title")%></h3>
                            <p>
<%
			sql3 = "select avg(star) as star from review where rnum = ?";
			try{
				pstmt2 = conn.prepareStatement(sql3);
				pstmt2.setInt(1, num);
				rs2 = pstmt2.executeQuery();
				String[] tstar = {"ri-star-fill", "ri-star-half-line", "ri-star-line"};
				double star = 0.0, starD = 0.0;
				int starInt;
				
				String stars;
				while(rs2.next()){
					star = rs2.getFloat("star");
					starInt = (int) star;
					starD = star - (int) star;
					if(starD > 0 && starD < 0.4){
						stars = tstar[2];
					}else if(0.4 < starD && starD < 0.6){
						stars = tstar[1];
					}else{
						stars = tstar[0];
					}
					
					if(starInt == 0){
						out.print("<i>리뷰가 없습니다.</i>");
					}
					for(int i = 0; i < starInt; i++){
						if(starInt - 1 == i){
							out.print("<i class='" + stars + "'></i>");
						}else{
							out.print("<i class='ri-star-fill'></i>");
						}
					
					}
				}
			
%>
                            </p>
                        </div>
                        
                        </a>
                    </li>
<%
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				if(rs2 != null) try{rs2.close(); }catch(SQLException e){}
				if(pstmt2 != null) try{pstmt2.close(); }catch(SQLException e){}
			}
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
        
    	<div class="text-right">
    	<%if (pg > 1){ %>
			<a href="?sectordetail=<%=param %>&city=<%=param2 %>&cpage=<%=pg-1 %>" data-role="button" data-icon="arrow-l" data-inline="true">이전</a>
		<%} %>
		<span><%=pg %> 페이지</span>
		<%if(pg < totalPages){ %>
			<a href="?sectordetail=<%=param %>&city=<%=param2 %>&cpage=<%=pg+1 %>" data-role="button" data-iconpos="right" data-icon="arrow-r" data-inline="true">다음</a>
		<%} %>	
    	</div>
		
                 
                 
                 
                 
                 
            </div>
            
        </div>
        
<%@ include file="include/footer.jsp" %>
</div>
</body>
</html>