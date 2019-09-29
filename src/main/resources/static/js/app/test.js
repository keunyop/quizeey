var test;

(function() {
  var questId;
  var isDisqusInitialLoading;

  var quest_cnt = 0;
  var correct_cnt = 0;

  test = {
    init: function() {
      var _this = this;
      _this.getVersions();
      _this.nextQuestion();
      $("#inputQuestId").text(""); // 최초 nextQuestion 후 #inputQuestId 초기화

      // Quiz version selector change
      $("#quiz-version-selector").on("change", function() {
        // 초기화
        quest_cnt = 0;
        correct_cnt = 0;
        $("#quiz-result").text("0/0 (0.0%)");

        _this.nextQuestion();
      });

      // Submit button click
      $("#btn-question-submit").on("click", function() {
        _this.submitQuiz();
      });

      // Skip button click
      $("#btn-question-skip").on("click", function() {
        _this.nextQuestion(true);
      });

      // Modal next button click
      $("#btn-next-question").on("click", function() {
        // Card border-danger
        _this.cardColorChange("danger");
        _this.nextQuestion();
      });

      // 통계 tab click
      $("#statistics-tab").on("click", function() {
        var data = {
          questId: questId
        };

        $.ajax({
          type: "POST",
          url: "/questionStats",
          dataType: "json",
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify(data)
        })
          .done(function(responseData) {
            var stats = 0;

            if (responseData) {
              var correct = responseData.correct;
              var inCorrect = responseData.inCorrect;

              stats = (correct / (correct + inCorrect)) * 100;
            }

            c3.generate({
              bindto: "#chart",
              data: {
                columns: [["Correct Answer", stats]],
                type: "gauge"
              },
              color: {
                pattern: ["#FF0000", "#F97600", "#F6C600", "#60B044"], // the three color levels for the percentage values.
                threshold: {
                  values: [30, 60, 90, 100]
                }
              },
              size: {
                height: 180
              }
            });
          })
          .fail(function(error) {
            console.log(error);
          });
      });

      // Disqus tab click
      $("#disqus-tab").on("click", function() {
        if (isDisqusInitialLoading) {
          isDisqusInitialLoading = false;

          // Disqus
          disqus_config = function() {
            this.page.url = "http://quizeey.com/test/" + questId; // Replace PAGE_URL with your page's canonical URL variable
            this.page.identifier = ""; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
          };

          (function() {
            // DON'T EDIT BELOW THIS LINE
            var d = document,
              s = d.createElement("script");
            s.src = "https://questionbank-2.disqus.com/embed.js";
            s.setAttribute("data-timestamp", +new Date());
            (d.head || d.body).appendChild(s);
          })();
        }
      });

      // 설명추가
      $(".add-explanation-txt").on("click", function() {
        $(".add-explanation-form").toggle();
      });

      $(".add-explanation-form").submit(function(e) {
        e.preventDefault();

        var data = {
          questId: questId,
          userNm: $("#addExplanationUserName").val(),
          explanation: $("#addExplanationContents").val()
        };

        $.ajax({
          type: "POST",
          url: "/addExplanation",
          dataType: "json",
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify(data)
        })
          .done(function(responseData) {
            $(".add-explanation-form").hide();
          })
          .fail(function(error) {
            console.log(error);
          });
      });

      // Keyboard press event
      $(document).keypress(function(e) {
        // 키보드 숫자 1~9
        // keyCode 49~57
        if (e.keyCode >= 49 && e.keyCode <= 57) {
          var $exampleCheck = $("#" + String.fromCharCode(16 + e.keyCode));

          if ($exampleCheck.prop("checked")) {
            $exampleCheck.prop("checked", false);
          } else {
            $exampleCheck.prop("checked", true);
          }

          // Button change
          _this.submitBtnChange($("#btn-question-submit"));
        }
        // 엔터키
        else if (e.keyCode == 13) {
          // 선택한 번호가 없으면 문제 skip
          if ($("#btn-question-submit").prop("disabled")) {
            _this.nextQuestion(true);
          } else {
            _this.submitQuiz();
          }
        }
      });
    },

    // 정답 여부
    isCorrect: function() {
      var answer = $("#hidden-answer").text();

      // Multi-answer question
      if (answer.length > 1) {
        var userAnswer = "";

        var ele = document.getElementsByName("exampleCheck");
        for (var i = 0; i < ele.length; i++) {
          if (ele[i].checked == true) {
            userAnswer = userAnswer + ele[i].id;
          }
        }

        if (answer == userAnswer) return true;
      } else {
        var ele = document.getElementsByName("exampleRadio");
        for (var i = 0; i < ele.length; i++) {
          if (ele[i].checked == true) {
            if (answer === ele[i].id) {
              return true;
            }
            break;
          }
        }
      }

      return false;
    },

    // Card board color change
    cardColorChange: function(color) {
      $("#question-card").addClass("border-" + color);
      $("#quiz-result")
        .removeClass("text-muted")
        .addClass("text-" + color);
      setTimeout(function() {
        $("#question-card").removeClass("border-" + color);
        $("#quiz-result")
          .removeClass("text-" + color)
          .addClass("text-muted");
      }, 1000);
    },

    // Versions 조회
    getVersions: function() {
      var data = {
        testId: $("#testId").text()
      };

      $.ajax({
        type: "POST",
        url: "/versions",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data)
      })
        .done(function(responseData) {
          var selector = $("#quiz-version-selector");
          $.each(responseData, function(key, value) {
            selector.append(
              $("<option></option>")
                .attr("value", value.verNbr)
                .text(value.verNm)
            );
          });
        })
        .fail(function(error) {
          console.log(error);
        });
    },

    // 문제 조회
    nextQuestion: function(isSkip, questionId) {
      var _this = this;

      var _btn_question_submit = $("#btn-question-submit");

      var data = {
        testId: $("#testId").text(),
        verNbr: $("#quiz-version-selector").val(),
        questId: $("#inputQuestId").text() || questionId
      };

      $.ajax({
        type: "POST",
        url: "/question",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data)
      })
        .done(function(responseData) {
          isDisqusInitialLoading = true;

          if (!isSkip) quest_cnt++;

          var isCorrect = _this.isCorrect() ? true : false;

          // 문제 Reset
          if ($("#examples").has("div").length) {
            $("#versionText").empty();
            $("#questionText").empty();
            $("#examples").empty();
            $("#hidden-answer").empty();
            $("#quest-answer").empty();
            $("#explanation").empty();

            // SUBMIT button reset
            _btn_question_submit
              .removeClass("btn-primary")
              .addClass("btn-secondary");
            _btn_question_submit.prop("disabled", true);
          }

          // Version
          $("#versionText").append(responseData.verName);
          // 문제
          $("#questionText").append(quest_cnt + ". " + responseData.questTxt);

          // 설명
          if (responseData.explanation != "") {
            $("#explanation-title").show();
            $("#explanation").append(responseData.explanation);
          } else {
            $("#explanation-title").hide();
            $("#explanation").text("");
          }

          // 참조
          if (responseData.reference != "") {
            $("#reference-title").show();
            $("#reference").attr("href", responseData.reference);
            $("#reference").text("Open reference link...");
          } else {
            $("#reference-title").hide();
            $("#reference").text("");
          }

          // 보기
          if (responseData.multiAnswer) {
            _this.getCheckboxTypeExample(responseData.examples);
          } else {
            _this.getRadioTypeExample(responseData.examples);
          }

          // Quiz result
          if (!isSkip && quest_cnt > 1) {
            var current_num = quest_cnt - 1;
            var percentage = (correct_cnt / current_num) * 100;
            $("#quiz-result").text(
              correct_cnt +
                "/" +
                current_num +
                " (" +
                percentage.toFixed(1) +
                "%)"
            );

            // 진행상태바
            var li = document.createElement("li");
            li.className = "breadcrumb-item";

            var anchor = document.createElement("a");
            anchor.setAttribute("href", "#`");
            anchor.setAttribute("class", "progress-bar-item" + current_num);

            if (!isCorrect) {
              anchor.setAttribute(
                "class",
                anchor.getAttribute("class") + " wrong-answer"
              );
            }

            anchor.setAttribute("value", questId);
            anchor.innerText = current_num;

            li.appendChild(anchor);

            $("#progress-bar").append(li);

            // Progress bar item click
            $(".progress-bar-item" + current_num).on("click", function(event) {
              _this.nextQuestion(
                true,
                event.currentTarget.attributes.value.value
              );
            });
          }

          // Normal question radio button change event
          $('input:radio[name="exampleRadio"]').on("change", function() {
            _this.submitBtnChange(_btn_question_submit);
          });

          // Multi-answer question checkbox check event
          var $checkboxes = $('input:checkbox[name="exampleCheck"]');
          $checkboxes.on("change", function() {
            if ($checkboxes.filter(":checked").length > 1) {
              if (_btn_question_submit.prop("disabled")) {
                _btn_question_submit
                  .removeClass("btn-secondary")
                  .addClass("btn-primary");
                _btn_question_submit.prop("disabled", false);
              }
            } else {
              if (!_btn_question_submit.prop("disabled")) {
                _btn_question_submit
                  .removeClass("btn-primary")
                  .addClass("btn-secondary");
                _btn_question_submit.prop("disabled", true);
              }
            }
          });

          questId = responseData.questId;
        })
        .fail(function(error) {
          console.log(error);
        });
    },

    // 답이 하나인 Radio 타입 문제
    getRadioTypeExample: function(examples) {
      // 보기
      examples.forEach(function(item, index) {
        var exampleAlphabet = String.fromCharCode(65 + index);

        var div = document.createElement("div");
        div.className = "custom-control custom-radio";
        div.style.paddingTop = "10px";

        var input = document.createElement("input");
        input.type = "radio";
        input.id = exampleAlphabet;
        input.name = "exampleRadio";
        input.className = "custom-control-input";

        var label = document.createElement("label");
        label.className = "custom-control-label";
        label.innerHTML = exampleAlphabet + ". " + item.exmpTxt;
        label.setAttribute("for", exampleAlphabet);

        div.appendChild(input);
        div.appendChild(label);

        $("#examples").append(div);

        if (item.answer) {
          $("#hidden-answer").text(exampleAlphabet);
          $("#quest-answer").append(exampleAlphabet + ". " + item.exmpTxt);
        }
      });
    },

    // 답이 복수인 Checkbox 타입 문제
    getCheckboxTypeExample: function(examples) {
      var hidden_answer = $("#hidden-answer");
      var quest_answer = $("#quest-answer");

      // 보기
      examples.forEach(function(item, index) {
        var exampleAlphabet = String.fromCharCode(65 + index);

        var div = document.createElement("div");
        div.className = "custom-control custom-checkbox";
        div.style.paddingTop = "10px";

        var input = document.createElement("input");
        input.type = "checkbox";
        input.id = exampleAlphabet;
        input.name = "exampleCheck";
        input.className = "custom-control-input";

        var label = document.createElement("label");
        label.className = "custom-control-label";
        label.innerHTML = exampleAlphabet + ". " + item.exmpTxt;
        label.setAttribute("for", exampleAlphabet);

        div.appendChild(input);
        div.appendChild(label);

        $("#examples").append(div);

        if (item.answer) {
          hidden_answer.append(exampleAlphabet);
          quest_answer.append(exampleAlphabet + ". " + item.exmpTxt + "<br>");
        }
      });
    },

    // Normal question radio button change event
    submitBtnChange: function($btn_question_submit) {
      if ($btn_question_submit.prop("disabled")) {
        $btn_question_submit
          .removeClass("btn-secondary")
          .addClass("btn-primary");
        $btn_question_submit.prop("disabled", false);
      }
    },

    // Submit quiz
    submitQuiz: function() {
      var _this = this;

      // 정답여부
      const result = _this.isCorrect();

      if (result) {
        correct_cnt++;

        // Card border-success
        _this.cardColorChange("success");
        _this.nextQuestion();
      } else {
        $("#wrongModal").modal("show");
      }

      // 통계용 결과 전송
      _this.sendResult(result);
    },

    // 통계용 결과 전송
    sendResult: function(result) {
      var data = {
        questId: questId,
        correct: result
      };

      $.ajax({
        type: "POST",
        url: "/updateQuestionStats",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data)
      })
        .done(function(responseData) {
          // Nothing to do yet
        })
        .fail(function(error) {
          console.log(error);
        });
    },

    // 통계 결과 조회
    getStatistic: function(questId) {
      var data = {
        questId: questId
      };

      $.ajax({
        type: "POST",
        url: "/questionStats",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data)
      })
        .done(function(responseData) {
          var correct = responseData.correct;
          var inCorrect = responseData.inCorrect;

          return ((correct + inCorrect) / correct) * 100;
        })
        .fail(function(error) {
          console.log(error);
        });
    }
  };
})();

test.init();
