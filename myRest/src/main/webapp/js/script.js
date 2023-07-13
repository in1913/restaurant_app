function checkForm(){
	const frm = document.memberform;
	if(frm.username.value == ""){
		frm.username.focus();
		alert("이름을 입력하세요.");
		return false;
	}
	if(frm.userid.value == ""){
		frm.userid.focus();
		alert("아이디를 입력하세요.");
		return false;
	}
	if(frm.userpass.value == ""){
		frm.userpass.focus();
		alert("비밀번호를 입력하세요.");
		return false;
	}
	if(frm.address.value == ""){
		frm.postcode.focus();
		alert("주소를 입력하세요.");
		return false;
	}
	if(frm.idok.value == "notok"){
		alert("아이디 중복확인을 해주세요.");
		return false;
	}
	if(frm.job.value == ""){
		alert("직업을 입력하세요.");
		return false;
	}
}
function checkForm(){
	alert("수정");
	return true;
}
/* function execDaumPostCode() {
        new daum.Postcode({
            oncomplete: function(data) {
                
                var addr = ''; // 주소 변수

             
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
    */
function idCheck(){
	const uid = document.getElementById("userid").value;
	const url = "IdCheck.jsp?uid=" + uid;
	const frm = document.memberform;
	if(uid == "" || uid.length == 0){
		alert("아이디를 입력하지 않았습니다.");
	}else{
		window.open(url, "chkform", "width=400px, height=300px, resizable=no, status=no, menubar=no, toolbar=no, top=100px, left=300px");	
	}
		
}