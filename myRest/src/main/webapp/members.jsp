<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, myRest.SQLConnection, java.net.*"%>
<%!
	Connection conn = null;
	Statement stmt = null;
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
    <script src="js/memrs.js"></script>
    
    
</head>
<body>   
<div id="members" data-role="page"  data-theme="c">
<%@ include file="include/header.jsp" %>
        <div data-role="content">
            <div id="brand">
                <h1><span>맛집</span><span>검색</span></h1>
            </div>
			<h1 class="memberform-h1">회원가입</h1>
             <form name="memberform" id="memberform" action="member.jsp" method="post" onSubmit="return checkForm();">
                 <ul class="members" data-role="listview" data-inset="true">
                     <li data-role="fieldcontain">
                         <label for="username">이름</label>
                         <input type="text" name="username" id="username" placeholder="이름" data-clear-btn="true">
                     </li>
                     <li data-role="fieldcontain">
                         <label for="userid">아이디</label>
                         <input class="dupli" type="text" name="userid" id="userid" placeholder="아이디" data-clear-btn="true">
                         <p id="idtext"></p>
                         <input type="hidden" name="idok" id="idok" value="notok">
                     </li>
                     <li data-role="fieldcontain">
                         <label for="userpass">비밀번호</label>
                         <input type="password" name="userpass" id="userpass" placeholder="비밀번호">
                     </li>
                     <li data-role="fieldcontain">
                         <label for="gender">성별</label>
                         <div class="genderbox" id="gender">
                             <label class="gender"><input type="radio" name="gender" value="남자" checked>
                              남자</label>
                             <label class="gender"><input type="radio" name="gender" value="여자">
                              여자</label>
                         </div>
                     </li>
                     <li data-role="fieldcontain" class="li-post">
                        <label for="postcode">우편번호</label>
                       	<input type="search" name="postcode" id="postcode" placeholder="우편번호"
                       	data-rel="popup" data-transition="pop" data-clear-btn="true">
                    </li>
                     <li class="li-address">
                       	<input type="text" name="address" id="address" readonly placeholder="주소">
                       	<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"> 
                     </li>
                     <li data-role="fieldcontain">
                         <label for="job">직업</label>
                         <select name="job" id="job">
                             <option value="프론트엔드 프로그래머" >프론트엔드 프로그래머</option>
                             <option value="백엔드 프로그래머" >백엔드 프로그래머</option>
                             <option value="풀스택 프로그래머" >풀스택 프로그래머</option>
                             <option value="UI 디자이너" >UI 디자이너</option>
                             <option value="입만 프로그래머">입만 프로그래머</option>
                         </select>
                     </li>
                     <li data-role="fieldcontain" class="li-hobby">
                     <fieldset data-mini="true" id="hobby" >
                         <label>취미</label>
                                 <input type="checkbox" name="hobby" id="hobby1" value="운동">
                                 <label for="hobby1">운동</label>
                                 <input type="checkbox" name="hobby" id="hobby2" value="여행"> 
                                 <label for="hobby2">여행</label>
                                 <input type="checkbox" name="hobby" id="hobby3" value="독서"> 
                                 <label for="hobby3">독서</label>
                                 <input type="checkbox" name="hobby" id="hobby4" value="음악"> 
                                 <label for="hobby4">음악</label>
                                 <input type="checkbox" name="hobby" id="hobby5" value="쇼핑"> 
                                 <label for="hobby5">쇼핑</label>
                      </fieldset>
                         
                     </li>
                     <li data-role="fieldcontain" >
                         <label for="leftright">좌우명</label>
                         <input type="text" name="leftright" id="leftright">
                     </li>
                 </ul>
                 <div class="btnbox">
                     <button type="submit" class="submit">가입</button>
                 </div>
             </form>
     </div>
        
<%@ include file="include/footer.jsp" %>
            </div>
<!--  팝업 -->
      <div id="popupPostcode" style="display:none;position:fixed;overflow:hidden;z-index:100;-webkit-overflow-scrolling:touch;">
         <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" alt="닫기 버튼">
      </div>
    <!--  /팝업  -->

        


</body>
</html>