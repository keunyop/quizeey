var main_div = $("#main-div");

var main = {
  init: function() {
    var _this = this;
    var languageCd = $("meta[http-equiv='content-language']").attr("content");

    // 시험 목록 조회
    _this.getTests(languageCd);

    $("#testSearch").on("keyup", function() {
      var value = $(this)
        .val()
        .toLowerCase();

      // $("#testRadios *").filter(function() {
      //   $(this).toggle(
      //     $(this)
      //       .text()
      //       .toLowerCase()
      //       .indexOf(value) > -1
      //   );
      // });

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
  getTests: function(languageCd) {
    var _this = this;

    var data = {
      languageCd: languageCd
    };

    $.ajax({
      type: "POST",
      url: "/tests",
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify(data)
    })
      .done(function(responseData) {
        // var cnt = 1;

        // // 라디오버튼
        // $.each(responseData, function(key, value) {
        //   var div = document.createElement("div");
        //   div.className = "custom-control custom-radio";

        //   var input = document.createElement("input");
        //   input.type = "radio";
        //   input.id = "testRadio" + cnt;
        //   input.name = "testRadio";
        //   input.className = "custom-control-input";
        //   input.value = value.url;

        //   var label = document.createElement("label");
        //   label.className = "custom-control-label";
        //   label.innerHTML = value.testNm;
        //   label.setAttribute("for", "testRadio" + cnt);

        //   div.appendChild(input);
        //   div.appendChild(label);

        //   var br = document.createElement("br");

        //   $("#testRadios").append(div);
        //   $("#testRadios").append(br);

        //   cnt++;
        // });

        // 링크 버튼
        $.each(responseData, function(key, value) {
          var li = document.createElement("li");
          li.className = "test-link";

          var atag = document.createElement("a");
          atag.className = "text-muted";
          atag.href = value.url;
          atag.innerHTML = value.testNm;
          
          li.appendChild(atag);

          $("#testLinks").append(li);
        });

        _this.afterGetTests(languageCd);
      })
      .fail(function(error) {
        console.log(error);
      });
  },

  // Radio button change event
  takeTheQuizBtnChange: function($btn_take_the_quiz) {
    if ($btn_take_the_quiz.prop("disabled")) {
      $btn_take_the_quiz.removeClass("btn-secondary").addClass("btn-primary");
      $btn_take_the_quiz.prop("disabled", false);
    }
  },

  afterGetTests: function(languageCd) {
    var _this = this;
    var $btn_take_the_quiz = $("#btn-take-the-quiz");

    // Radio button change event123
    $('input:radio[name="testRadio"]').on("change", function() {
      _this.takeTheQuizBtnChange($btn_take_the_quiz);
    });

    $btn_take_the_quiz.on("click", function() {
      _this.openQuiz(languageCd);
    });

    // Keyboard press event
    $(document).keypress(function(e) {
      // 키보드 숫자 1~9
      // keyCode 49~57
      if (e.keyCode >= 49 && e.keyCode <= 57) {
        var radioNbr = e.keyCode - 48;
        $("#testRadio" + radioNbr).prop("checked", true);

        _this.takeTheQuizBtnChange($btn_take_the_quiz);
      }
      // 엔터키
      else if (e.keyCode == 13) {
        _this.openQuiz(languageCd);
      }
    });
  },

  openQuiz: function(languageCd) {
    var path = "/";
    var testNm = $("input[name='testRadio']:checked").val();

    if (!testNm) {
      return;
    }

    // Language
    if (languageCd == "en") {
      path = "/en/";
    }

    window.location = path + testNm;
  }
};

main.init();
