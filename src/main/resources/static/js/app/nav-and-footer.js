$(function(){
	var language = $("meta[http-equiv='content-language']").attr("content");

	if (language == 'ko') {
		$("#nav-placeholder").load("/html/kr/nav.html");
		$("#footer-placeholder").load("/html/kr/footer.html");
	} else {
		$("#nav-placeholder").load("/html/nav.html");
		$("#footer-placeholder").load("/html/footer.html");
	}
});

// /**
//  * 전체페이지 keypress 이벤트
//  */
// $(document).keypress(function(e){
	
// 	// 키보드 숫자 0~10
// 	// keyCode 48~57
// 	if (e.keyCode >= 48 && e.keyCode <= 57) {

// 		switch (e.keyCode) {
// 			case 49:	// 1
// 				$("#testRadio1").prop("checked", true);
// 				break;
		
// 			case 50:	// 2
// 				$("#testRadio2").prop("checked", true);
// 				break;
			
// 			case 51:	// 3
// 				$("#testRadio3").prop("checked", true);
// 				break;

// 			default:
// 				break;
// 		}


		
// 	}
// });