package com.questionbank.webservice.domain.question;

import java.util.List;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class Question {
    private int          number;
    private String       questionText;
    private List<String> examples;
    private String       answer;
    private String       explanation;
    private String       reference;

    @Builder
    public Question(int number, String questionText, List<String> examples, String answer, String explanation,
                    String reference) {
        this.number = number;
        this.questionText = questionText;
        this.examples = examples;
        this.answer = answer;
        this.explanation = explanation;
        this.reference = reference;
    }

}
