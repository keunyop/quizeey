var test;

(function() {
    var quest_cnt = 0;
    var correct_cnt = 0;
    
    test = {
        init : function() {
            var _this = this;
            _this.getVersions();
            _this.nextQuestion();

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
                _this.nextQuestion(true);
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
            var answer = $('#hidden-answer').text();
            
            // Multi-answer question
            if (answer.length > 1) {
                var userAnswer='';

                var ele = document.getElementsByName("exampleCheck");
                for(var i=0; i<ele.length; i++) {
                    if (ele[i].checked == true) {
                        userAnswer = userAnswer + ele[i].id;
                    }
                }

                if (answer == userAnswer) return true;

            } else {
                var ele = document.getElementsByName("exampleRadio");
                for(var i=0; i<ele.length; i++) {
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
        cardColorChange : function(color) {
            $('#question-card').addClass('border-' + color);
            $('#quiz-result').removeClass('text-muted').addClass('text-' + color);
            setTimeout(function() { 
                $('#question-card').removeClass('border-' + color); 
                $('#quiz-result').removeClass('text-' + color).addClass('text-muted');
            }, 1000);
        },

        // Versions 조회
        getVersions : function() {
            var data = {
                testId: $('#testId').text()
            }

            $.ajax({
                type: 'POST',
                url: '/versions',
                dataType: 'json',
                contentType:'application/json; charset=utf-8',
                data: JSON.stringify(data)
            }).done(function(responseData) {
                var selector =  $('#quiz-version-selector');
                $.each(responseData, function(key, value) {   
                    selector.append($("<option></option>")
                                   .attr("value",value.verNbr)
                                   .text(value.verNm)); 
               });
            }).fail(function(error) {
                alert(error);
            });
        },

        // 문제 조회
        nextQuestion : function (isSkip) {
            var _this = this;

            var _btn_question_submit = $('#btn-question-submit');

            var data = {
                testId: $('#testId').text(),
                verNbr: $("#quiz-version-selector").val()
            };
    
            $.ajax({
                type: 'POST',
                url: '/question',
                dataType: 'json',
                contentType:'application/json; charset=utf-8',
                data: JSON.stringify(data)
            }).done(function(responseData) {
                // Disqus
                disqus_config = function () {
                    this.page.url = 'http://quizeey.com/test/' + responseData.questId;  // Replace PAGE_URL with your page's canonical URL variable
                    this.page.identifier = ''; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
                };

                (function() { // DON'T EDIT BELOW THIS LINE
                    var d = document, s = d.createElement('script');
                    s.src = 'https://questionbank-2.disqus.com/embed.js';
                    s.setAttribute('data-timestamp', +new Date());
                    (d.head || d.body).appendChild(s);
                })();

                if (!isSkip) quest_cnt++;

                // 문제 Reset
                if ($('#examples').has("div").length) {
                    $('#questionText').empty();
                    $('#examples').empty()
                    $('#hidden-answer').empty();
                    $('#quest-answer').empty();

                    // SUBMIT button reset
                    _btn_question_submit.removeClass('btn-primary').addClass('btn-secondary');
                    _btn_question_submit.prop("disabled", true);
                }
    
                // 문제
                $('#questionText').append(quest_cnt + ". " + responseData.questTxt);
                // 설명
                $('#explanation').text(responseData.explanation);
                // 참조
                $('#reference').attr("href", responseData.reference);
                $('#reference').text("Open reference link...");

                // 보기
                if (responseData.multiAnswer) {
                    _this.getCheckboxTypeExample(responseData.examples);
                } else {
                    _this.getRadioTypeExample(responseData.examples);
                }

                // Quiz result
                if (!isSkip && quest_cnt > 1) {
                    var current_num = quest_cnt-1;
                    $('#quiz-result').text(correct_cnt + "/" + current_num + " (" + (correct_cnt/current_num) * 100 + "%)");
                }

                // Normal question radio button change event
                $('input:radio[name="exampleRadio"]').on('change', function() {
                    if (_btn_question_submit.prop("disabled")) {
                        _btn_question_submit.removeClass('btn-secondary').addClass('btn-primary');
                        _btn_question_submit.prop("disabled", false);          
                    }           
                });

                // Multi-answer question checkbox check event
                var $checkboxes = $('input:checkbox[name="exampleCheck"]');
                $checkboxes.on('change', function() {
                    if ($checkboxes.filter(':checked').length > 1) {
                        if (_btn_question_submit.prop("disabled")) {
                            _btn_question_submit.removeClass('btn-secondary').addClass('btn-primary');
                            _btn_question_submit.prop("disabled", false);       
                        }
                    } else {
                        if (!_btn_question_submit.prop("disabled")) {
                            _btn_question_submit.removeClass('btn-primary').addClass('btn-secondary');
                            _btn_question_submit.prop("disabled", true);          
                        }
                    }
                });
    
            }).fail(function (error) {
                console.log(error);
            });
        },

        // 답이 하나인 Radio 타입 문제
        getRadioTypeExample : function(examples) {
            // 보기 
            examples.forEach(function (item, index) {
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

                $('#examples').append(div)

                if (item.answer) {
                    $('#hidden-answer').text(exampleAlphabet);
                    $('#quest-answer').append(exampleAlphabet + ". " + item.exmpTxt);
                }
            });
        },

        // 답이 복수인 Checkbox 타입 문제
        getCheckboxTypeExample: function(examples) {

            var hidden_answer = $('#hidden-answer');
            var quest_answer = $('#quest-answer');

            // 보기 
            examples.forEach(function (item, index) {
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

                $('#examples').append(div)

                if (item.answer) {
                    hidden_answer.append(exampleAlphabet);
                    quest_answer.text("<pre>"+exampleAlphabet + ". " + item.exmpTxt + "<br></pre>");
                }
            });
        }
    };
})();

test.init();