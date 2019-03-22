$(function(){
	var language = $("meta[http-equiv='content-language']").attr("content")

	if (language == 'ko') {
		$("#nav-placeholder").load("/html/kr/nav.html");
		$("#footer-placeholder").load("/html/kr/footer.html");
	} else {
		$("#nav-placeholder").load("/html/nav.html");
		$("#footer-placeholder").load("/html/footer.html");
	}
});