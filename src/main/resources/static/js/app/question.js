$(function() {
  var language = $("meta[http-equiv='content-language']").attr("content");

  if (language == "en") {
    $("#question-placeholder").load("/html/en/question.hbs");
  } else {
    $("#question-placeholder").load("/html/question.hbs");
  }
});