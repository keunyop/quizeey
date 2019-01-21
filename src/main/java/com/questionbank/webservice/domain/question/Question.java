package com.questionbank.webservice.domain.question;

import java.util.List;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class Question {
    private int           number;
    private String        questionText;
    private List<Example> examples;
    private String        explanation;
    private String        reference;

    @Builder
    public Question(int number, String questionText, List<Example> examples, String explanation, String reference) {
        this.number = number;
        this.questionText = questionText;
        this.examples = examples;
        this.explanation = explanation;
        this.reference = reference;
    }

}
