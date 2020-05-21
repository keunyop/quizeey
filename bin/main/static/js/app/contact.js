var contact;

(function() {
    contact = {
        init : function() {
            $("#contact-form").submit(function(event) {
                event.preventDefault();

                var _btn_contact_send = $('#btn-contact-send');
                _btn_contact_send.prop("disabled", true);
                _btn_contact_send.text("SENDING...");

                var data = {
                    email: $("#email").val(),
                    message: $("#message").val()
                };

                $.ajax({
                    type: 'POST',
                    url: 'https://hooks.zapier.com/hooks/catch/4617396/n39vpv/',
                    dataType: 'jsonp',
                    contentType:'application/json; charset=utf-8',
                    data: data
                }).done(function(responseData) {
                    
                    // SEND button disabled
                    _btn_contact_send.removeClass('btn-primary').addClass('btn-success');
                    _btn_contact_send.text("DONE");

                }).fail(function (error) {
                    console.log(error);

                    _btn_contact_send.prop("disabled", false);
                    _btn_contact_send.text("SEND");
                });
               
            });
        }
    };
})();

contact.init();