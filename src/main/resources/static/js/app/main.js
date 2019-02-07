var main = {
    init : function () {
        var _this = this;
        var _btn_take_the_quiz = $('#btn-take-the-quiz');

        _btn_take_the_quiz.on('click', function () {
            _this.openQuiz();
        });

        // Radio button change event
        $('input:radio[name="quizRadio"]').on('change', function() {
            if (_btn_take_the_quiz.prop("disabled")) {
                _btn_take_the_quiz.removeClass('btn-secondary').addClass('btn-primary');
                _btn_take_the_quiz.prop("disabled", false);          
            }           
        });
    },
    openQuiz : function () {
        var quizId = $("input[name='quizRadio']:checked").val();
        
        location.href = "/test.html?testId=" + quizId;
    }
};

main.init();