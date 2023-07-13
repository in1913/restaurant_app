const rsla = ['37.5517', '37.6999', '37.3344', '37.7224','37.6719'];
const rsln = ['127.208', '126.716', '126.733', '126.74','126.747'];

let roadviewContainer = document.getElementsByClassName('roadView'); //로드뷰를 표시할 div

for( let i = 0; i < rsla.length; i++) {
     let roadview = new kakao.maps.Roadview(roadviewContainer[i]); //로드뷰 객체
     let roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
     let position = new kakao.maps.LatLng(rsla[i], rsln[i]);
   
        roadviewClient.getNearestPanoId(position, 50, function(panoId) {
        roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
    });
}

// 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
