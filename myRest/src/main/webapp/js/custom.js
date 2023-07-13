$(document).on("pageinit", function(){
    $("#submitbtn").attr("disabled", true);
     $(document).on("blur", "#pw", function(){
       if($("#un").val() && $("#pw").val()){
          $('#submitbtn').attr("disabled", false);
       }
    });    
  });
  $(document).on("pageshow","#list02", function(){
     roadView01();
  });  
     
  $(document).on("pageshow","#detail", function(){
     roadView02();
     $("#submit").click(function(){
		 $.ajax({
			 url : "reviewok.jsp",
			 type : "post",
			 data : $("#reviewForm").serialize(),
			 dataType : "json",
			 success : function(data){
				 if(data > 0){
					 alert("수정완료");
					 location.href = "detail.jsp?num=" + data;
				 }else{
					 alert("에러가 발생했습니다.");
				 }
			 }
		 })
	 })
  }); 
  
  
  

function roadView01(){
  
    let rlat = new Array();
    let rlon = new Array();

   
    $("input[name=lat]").each(function(index, item){
    	rlat.push($(item).val());
    });

    $("input[name=lon]").each(function(index, item){
    	rlon.push($(item).val());
    });

	let roadviewContainer = document.getElementsByClassName('roadView'); //로드뷰를 표시할 div
	
	for(let i = 0; i < rlat.length; i++) {
	    let roadview = new kakao.maps.Roadview(roadviewContainer[i]); //로드뷰 객체
	    let roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
	    let position = new kakao.maps.LatLng(rlat[i], rlon[i]);
	   
        roadviewClient.getNearestPanoId(position, 50, function(panoId) {
        	roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
    	});
	}
}


function roadView02(){
	const lat = $("#lat").val();
	const lon = $("#lon").val();
	const roadviewContainer = document.getElementById('roadView'); //로드뷰를 표시할 div
	const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	
	    mapOption = { 
	        center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	    
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(lat, lon); 
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	let roadview = new kakao.maps.Roadview(roadviewContainer); //로드뷰 객체
	let roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
	let position = new kakao.maps.LatLng(lat, lon);
	
	   roadviewClient.getNearestPanoId(position, 50, function(panoId) {
	   roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
	});
}
