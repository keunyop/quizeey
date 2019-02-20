var test;

(function() {
    var quest_cnt = 0;
    var correct_cnt = 0;
    

    test = {
        init : function() {
            var _this = this;

            // Quiz version selector change
            $('#quiz-version-selector').on('change', function() {
                // 초기화
                quest_cnt = 0;
                correct_cnt = 0;
                $('#quiz-result').text("0/0 (0%)");

                _this.nextQuestion();
            });

            // Submit button click
            $('#btn-question-submit').on('click', function () {
                if (_this.isCorrect()) {
                    correct_cnt++;
                    
                    // Card border-success
                    _this.cardColorChange('success');
                    _this.nextQuestion();

                } else {
                    $('#wrongModal').modal('show'); 
                }   
            });

            // Skip button click
            $('#btn-question-skip').on('click', function () {
                _this.nextQuestion();
            });

            // Modal next button click
            $('#btn-next-question').on('click', function () {

                // Card border-danger
                _this.cardColorChange('danger');
                _this.nextQuestion();
            });
        },

        // 정답 여부
        isCorrect : function() {
            var ele = document.getElementsByName("exampleRadio");  
            for(var i=0; i<ele.length; i++) {
                if (ele[i].checked == true) {
                    if ($('#hidden-answer').text() === ele[i].id) {
                        return true;
                    }   
                    break;
                }
            }
            return false;
        },

        // Card board color change
        cardColorChange : function(color) {
            $('#question-card').addClass('border-' + color);
            $('#quiz-result').removeClass('text-muted').addClass('text-' + color);
            setTimeout(function() { 
                $('#question-card').removeClass('border-' + color); 
                $('#quiz-result').removeClass('text-' + color).addClass('text-muted');
            }, 1000);
        },

        // 문제 조회
        nextQuestion : function () {
            var _btn_question_submit = $('#btn-question-submit');

            var data = {
                testDscd: $('#testId').text(),
                quizId: $("#quiz-version-selector").val()
            };
    
            $.ajax({
                type: 'POST',
                url: '/question',
                dataType: 'json',
                contentType:'application/json; charset=utf-8',
                data: JSON.stringify(data)
            }).done(function(responseData) {
                quest_cnt++;
    
                // 문제
                $('#questionText').text(quest_cnt + ". " + responseData.questText);
                // 설명
                $('#explanation').text(responseData.explanation);
                // 참조
                $('#reference').attr("href", responseData.reference);
                $('#reference').text("Open Reference link...");
    
                // 보기 Clear
                if ($('#examples-radio').has("div").length) {
                    $('#examples-radio').empty()

                    // SUBMIT button reset
                    _btn_question_submit.removeClass('btn-primary').addClass('btn-secondary');
                    _btn_question_submit.prop("disabled", true);
                }

                // 보기 
                responseData.examples.forEach(function (item, index) {
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
                    label.innerHTML = exampleAlphabet + ". " + item.exampleText;
                    label.setAttribute("for", exampleAlphabet);
        
                    div.appendChild(input);
                    div.appendChild(label);
        
                    $('#examples-radio').append(div)

                    if (item.answer) {
                        $('#hidden-answer').text(exampleAlphabet);
                        $('#quest-answer').text(exampleAlphabet + ". " + item.exampleText);
                    }
                });

                // Quiz result
                if (quest_cnt > 1) {
                    var current_num = quest_cnt-1;
                    $('#quiz-result').text(correct_cnt + "/" + current_num + " (" + (correct_cnt/current_num) * 100 + "%)");
                }

                // Radio button change event
                $('input:radio[name="exampleRadio"]').on('change', function() {
                    if (_btn_question_submit.prop("disabled")) {
                        _btn_question_submit.removeClass('btn-secondary').addClass('btn-primary');
                        _btn_question_submit.prop("disabled", false);          
                    }           
                });
    
            }).fail(function (error) {
                alert(error);
            });
        }
    };
})();

test.init();