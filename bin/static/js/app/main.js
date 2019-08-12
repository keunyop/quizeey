var main_div = $("#main-div");

var main = {
  init: function() {
    var _this = this;
    var $btn_take_the_quiz = $("#btn-take-the-quiz");

    $btn_take_the_quiz.on("click", function() {
      _this.openQuiz();
    });

    // Radio button change event123
    $('input:radio[name="testRadio"]').on("change", function() {
      _this.takeTheQuizBtnChange($btn_take_the_quiz);
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
        _this.openQuiz();
      }
    });

    $("#testSearch").on("keyup", function() {
      var value = $(this)
        .val()
        .toLowerCase();
      $("#testRadios *").filter(function() {
        $(this).toggle(
          $(this)
            .text()
            .toLowerCase()
            .indexOf(value) > -1
        );
      });
    });
  },

  openQuiz: function() {
    var path = "/";
    var testNm = $("input[name='testRadio']:checked").val();

    if (!testNm) {
      return;
    }

    // Language
    if ($("meta[http-equiv='content-language']").attr("content") == "en") {
      path = "/en/";
    }

    window.location = path + testNm;
  },

  // Radio button change event
  takeTheQuizBtnChange: function($btn_take_the_quiz) {
    if ($btn_take_the_quiz.prop("disabled")) {
      $btn_take_the_quiz.removeClass("btn-secondary").addClass("btn-primary");
      $btn_take_the_quiz.prop("disabled", false);
    }
  }
};

main.init();
