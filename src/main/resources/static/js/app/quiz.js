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
        }).done(function(data) {
            // 문제
            $('#questionText').text(data.questionText);

            // 보기
            data.examples.forEach(function (item, index) {
                var exampleNumber = index + 1;

                var div = document.createElement("div");
                div.className = "custom-control custom-radio";
                div.style.paddingTop = "10px";
      
                var input = document.createElement("input");
                input.type = "radio";
                input.id = "quizRadio" + exampleNumber;
                input.name = "quizRadio";
                input.className = "custom-control-input";
                
                var label = document.createElement("label");
                label.className = "custom-control-label";
                label.innerHTML = exampleNumber + ". " + item.exampleText;
                label.setAttribute("for", "quizRadio" + exampleNumber);
    
                div.appendChild(input);
                div.appendChild(label);
    
                $('#examples-radio').append(div)
            });
                       

        }).fail(function (error) {
            alert(error);
        });
    }
};

quiz.init();