var test;

(function() {
    var quest_cnt = 0;

    test = {
        init : function() {
            var _this = this;
            var _btn_question_skip = $('#btn-question-skip');

            // Submit button click
            $('#btn-question-submit').on('click', function () {
                _this.nextQuestion();
            });

            // Skip button click
            $('#btn-question-skip').on('click', function () {
                _this.nextQuestion();
            });
        },

        nextQuestion : function () {
            var _btn_question_submit = $('#btn-question-submit');

            var data = {
                testDscd: $('#testId').text()
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
    
                // 보기 Clear
                if ($('#examples-radio').has("div").length) {
                    $('#examples-radio').empty()

                    // SUBMIT button reset
                    _btn_question_submit.removeClass('btn-primary').addClass('btn-secondary');
                    _btn_question_submit.prop("disabled", true);
                }

                // 보기 
                responseData.examples.forEach(function (item, index) {
                    // var exampleNumber = index + 1;
                    var exampleAlphabet = String.fromCharCode(65 + index);
    
                    var div = document.createElement("div");
                    div.className = "custom-control custom-radio";
                    div.style.paddingTop = "10px";
          
                    var input = document.createElement("input");
                    input.type = "radio";
                    input.id = "exampleRadio" + exampleAlphabet;
                    input.name = "exampleRadio";
                    input.className = "custom-control-input";
                    
                    var label = document.createElement("label");
                    label.className = "custom-control-label";
                    label.innerHTML = exampleAlphabet + ". " + item.exampleText;
                    label.setAttribute("for", "exampleRadio" + exampleAlphabet);
        
                    div.appendChild(input);
                    div.appendChild(label);
        
                    $('#examples-radio').append(div)
                });

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