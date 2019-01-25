var main = {
    init : function () {
        var _this = this;
        $('#btn-take-the-quiz').on('click', function () {
            _this.openQuiz();
        });
    },
    openQuiz : function () {
        var quizId = $("input[name='quizRadio']:checked").val();
        
        location.href = "/quiz?id=" + quizId;
    }
};

main.init();