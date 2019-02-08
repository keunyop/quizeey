var main_div =  $("#main-div");

var main = {
    init : function () {
        var _this = this;
        var _btn_take_the_quiz = $('#btn-take-the-quiz');

        _btn_take_the_quiz.on('click', function () {
            _this.openQuiz();
        });

        // Radio button change event
        $('input:radio[name="testRadio"]').on('change', function() {
            if (_btn_take_the_quiz.prop("disabled")) {
                _btn_take_the_quiz.removeClass('btn-secondary').addClass('btn-primary');
                _btn_take_the_quiz.prop("disabled", false);          
            }           
        });
    },
    openQuiz : function () {
        var testId = $("input[name='testRadio']:checked").val();
        // location.href = "/test.html?testId=" + testId;

        $.ajax({
            type: 'GET',
            url: '/test.html?testId=' + testId,
            dataType: 'html',
            contentType:'text/html; charset=utf-8'
        }).done(function(responseData) {
            main_div.html(responseData);
            test.nextQuestion();
        });
    }
};

main.init();