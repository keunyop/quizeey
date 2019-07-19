$(function(){
	var language = $("meta[http-equiv='content-language']").attr("content");

	if (language == 'en') {
		$("#nav-placeholder").load("/html/en/nav.html");
		$("#footer-placeholder").load("/html/en/footer.html");
	} else {
		$("#nav-placeholder").load("/html/nav.html");
		$("#footer-placeholder").load("/html/footer.html");
	}
});