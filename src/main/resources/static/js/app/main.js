var main_div = $("#main-div");

var main = {
  init: function () {
    var _this = this;
    var languageCd = $("meta[http-equiv='content-language']").attr("content");

    $("#adsense-place-search-bottom").hide();

    $("#testSearch").on("keyup", function () {
      var value = $(this)
        .val()
        .toLowerCase();

      $("#testLinks *").filter(function () {
        $(this).toggle(
          $(this)
            .text()
            .toLowerCase()
            .indexOf(value) > -1
        );
      });

      if (value) {
        $("#adsense-place-search-top").hide();
        $("#adsense-place-search-bottom").show();
      } else {
        $("#adsense-place-search-top").show();
        $("#adsense-place-search-bottom").hide();
      }

    });
  }
};

main.init();
