var quiz = {
    init : function () {
        var _this = this;

        _this.nextQuestion();
    },
    nextQuestion : function () {
        var quizId = $('#quizId').text();

        $.ajax({
            type: 'GET',
            url: '/quiz?id=' + quizId,
            dataType: 'json',
            contentType:'application/json; charset=utf-8',
        }).done(function(msg) {
            console.log(msg);

            $('#questionText').text(msg.questionText);

        }).fail(function (error) {
            alert(error);
        });
    }
};

quiz.init();