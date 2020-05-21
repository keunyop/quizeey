var main_div = $("#main-div");

var main = {
  init: function() {
    var _this = this;
    var languageCd = $("meta[http-equiv='content-language']").attr("content");

    $("#testSearch").on("keyup", function() {
      var value = $(this)
        .val()
        .toLowerCase();

      $("#testLinks *").filter(function() {
        $(this).toggle(
          $(this)
            .text()
            .toLowerCase()
            .indexOf(value) > -1
        );
      });
    });
  }
};

main.init();
