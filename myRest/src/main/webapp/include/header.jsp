<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	String UID = null;
	int UNUM = 0;
%>  
<%
	if(session.getAttribute("UID") != null){ // 세션값이 있으면
		UID = (String) session.getAttribute("UID");
		UNUM = (int) session.getAttribute("UNUM");
	}else{
		UID = null; 
		UNUM = 0;
	}
%>  
<script src="js/members.js"></script>
