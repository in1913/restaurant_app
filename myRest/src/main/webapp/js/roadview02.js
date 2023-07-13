const lat = '37.5517';
const lon = '127.208';
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