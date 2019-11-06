var main_div = $("#main-div");

var main = {
  init: function() {
    var _this = this;
    var languageCd = $("meta[http-equiv='content-language']").attr("content");

    // 시험 목록 조회
    // _this.getTests(languageCd);

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
  },

  // 시험 목록 조회
  // getTests: function(languageCd) {
  //   var _this = this;

  //   var data = {
  //     languageCd: languageCd
  //   };

  //   $.ajax({
  //     type: "POST",
  //     url: "/tests",
  //     dataType: "json",
  //     contentType: "application/json; charset=utf-8",
  //     data: JSON.stringify(data)
  //   })
  //     .done(function(responseData) {
  //       $.each(responseData, function(key, value) {
  //         var li = document.createElement("li");
  //         li.className = "test-link";

  //         var atag = document.createElement("a");
  //         atag.className = "text-muted";
  //         atag.href = value.url;
  //         atag.innerHTML = value.testNm;

  //         li.appendChild(atag);

  //         // $("#testLinks").append(li);
  //       });
  //     })
  //     .fail(function(error) {
  //       console.log(error);
  //     });
  // }
};

main.init();
