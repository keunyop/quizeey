var request;

(function() {
    request = {
        init : function() {
            $("#request-form").submit(function(event) {
                event.preventDefault();

                var _btn_request_send = $('#btn-request-send');
                _btn_request_send.prop("disabled", true);
                _btn_request_send.text("SENDING...");

                var data = {
                    testName: $("#testName").val(),
                    questUrl: $("#questUrl").val(),
                    detailInfo: $("#detailInfo").val(),
                    userName: $("#userName").val(),
                    userEmail: $("#userEmail").val()
                };

                $.ajax({
                    type: 'POST',
                    url: 'https://hooks.zapier.com/hooks/catch/4617396/nyrliv/',
                    dataType: 'jsonp',
                    contentType:'application/json; charset=utf-8',
                    data: data
                }).done(function(responseData) {
                    
                    // SEND button disabled
                    _btn_request_send.removeClass('btn-primary').addClass('btn-success');
                    _btn_request_send.text("DONE");

                }).fail(function (error) {
                    console.log(error);

                    _btn_request_send.prop("disabled", false);
                    _btn_request_send.text("SEND");
                });
               
            });
        }
    };
})();

request.init();