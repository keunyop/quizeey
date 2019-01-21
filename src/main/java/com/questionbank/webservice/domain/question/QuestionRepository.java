package com.questionbank.webservice.domain.question;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class QuestionRepository {
    public List<Question> getQuestionsFromFile(String questionId) {

        List<Question> questions = new ArrayList<>();
        questions.add(Question.builder().number(1).questionText("문제내용").examples(null).explanation("설명").reference("참조")
                .build());

        return questions;
    }
}
