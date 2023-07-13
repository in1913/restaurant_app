<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" %>

<div data-role="footer" data-position="fixed">
   <div data-role="navbar" data-iconpos="bottom">
       <ul>
       
        <% if( UNUM > 0){ %>
       <li><a href="logout.jsp" data-icon="check" data-ajax="false">로그아웃</a></li>
       <li><a href="memberlist.jsp" data-icon="edit">회원정보</a></li>
   		<% }else{ %>
       <li><a href="#popupLogin" data-rel="popup" data-position-to="window" data-role="button" data-inline="true" data-icon="check" data-transition="pop">로그인</a>
       <li><a href="members.jsp" data-icon="edit">회원가입</a></li>
   		<% } %>    
       <li><a href="index.jsp" data-icon="home">메인페이지</a></li>
       <li><a href="heart.jsp" data-icon="star">리뷰</a></li>

       </ul>
   </div>
</div>
<%
   Enumeration params = request.getParameterNames();
   String gparam = "";
   while(params.hasMoreElements()){
     String name = (String) params.nextElement();
     gparam += name +"=" + request.getParameter(name)+"&";
   }
%>
<div data-role="popup" id="popupLogin" data-theme="a" class="ui-corner-all">
    <form name="loginForm" action="loginok.jsp" id="loginForm" data-ajax="false" method="post">
        <div style="padding:10px 20px;">
            <h3>로그인</h3>
            <label for="un" class="ui-hidden-accessible">아이디:</label>
            <input type="text" name="userid" id="un" value="" placeholder="아이디" data-theme="a">
            <label for="pw" class="ui-hidden-accessible">Password:</label>
            <input type="password" name="userpass" id="pw" value="" placeholder="비밀번호" data-theme="a">
            <input type="hidden" name="rUrl" id="rUrl" value="<%=request.getRequestURI() %>">
            <input type="hidden" name="rParam" id="rParam" value="<%=gparam %>">
            <button type="submit" id="submitbtn" data-theme="b" data-icon="check">로그인</button>
        </div>
    </form>
</div>
  