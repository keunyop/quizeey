package com.questionbank.webservice.domain.question;

import org.springframework.stereotype.Component;

@Component
public class QuestionRepository {
    public Question getRandomQuestionFromFile() {
        return Question.builder().number(1).questionText("문제내용").examples(null).explanation("설명").reference("참조")
                .build();
    }
}
