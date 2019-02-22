var main_div =  $("#main-div");

var main = {
    init : function () {
        var _this = this;
        var _btn_take_the_quiz = $('#btn-take-the-quiz');

        // _this.disqus();

        _btn_take_the_quiz.on('click', function () {
            var testId = $("input[name='testRadio']:checked").val();
            _this.openQuiz(testId);
        });

        // Radio button change event
        $('input:radio[name="testRadio"]').on('change', function() {
            if (_btn_take_the_quiz.prop("disabled")) {
                _btn_take_the_quiz.removeClass('btn-secondary').addClass('btn-primary');
                _btn_take_the_quiz.prop("disabled", false);          
            }           
        });
    },
    openQuiz : function (testId) {
        window.location = '/test?testId=' + testId;
    }
    // ,
    // disqus : function () {
    //     var disqus_config = function () {
    //         this.page.url = 'quizeey.com';  // Replace PAGE_URL with your page's canonical URL variable
    //         this.page.identifier = 'main'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
    //     };
    //     (function() { // DON'T EDIT BELOW THIS LINE
    //         var d = document, s = d.createElement('script');
    //         s.src = 'https://testasdf-1.disqus.com/embed.js';
    //         s.setAttribute('data-timestamp', +new Date());
    //         (d.head || d.body).appendChild(s);
    //     })();
    // }
};

main.init();