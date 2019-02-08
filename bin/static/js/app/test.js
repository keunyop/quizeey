var test;

(function() {
    var quest_cnt = 0;

    test = {
        nextQuestion : function () {
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
    
                // 보기
                responseData.examples.forEach(function (item, index) {
                    var exampleNumber = index + 1;
    
                    var div = document.createElement("div");
                    div.className = "custom-control custom-radio";
                    div.style.paddingTop = "10px";
          
                    var input = document.createElement("input");
                    input.type = "radio";
                    input.id = "testRadio" + exampleNumber;
                    input.name = "testRadio";
                    input.className = "custom-control-input";
                    
                    var label = document.createElement("label");
                    label.className = "custom-control-label";
                    label.innerHTML = exampleNumber + ". " + item.exampleText;
                    label.setAttribute("for", "testRadio" + exampleNumber);
        
                    div.appendChild(input);
                    div.appendChild(label);
        
                    $('#examples-radio').append(div)
                });
                           
    
            }).fail(function (error) {
                alert(error);
            });
        }
    };
})();