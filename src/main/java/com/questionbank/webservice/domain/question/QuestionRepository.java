package com.questionbank.webservice.domain.question;

import java.util.ArrayList;
import java.util.List;

public class QuestionRepository {

    public Question getRandomQuestionFromFile() {
        return Question.builder().number(1).questionText("문제내용").examples(null).answer("답").explanation("설명")
                .reference("참조").build();
    }

    public List<Question> getAllQuestionFromFile() {
        return new ArrayList<>();
    }
}
