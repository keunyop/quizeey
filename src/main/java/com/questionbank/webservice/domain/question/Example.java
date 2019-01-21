package com.questionbank.webservice.domain.question;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class Example {
    private String  exampleText;
    private boolean answer;

    @Builder
    public Example(String exampleText, boolean answer) {
        this.exampleText = exampleText;
        this.answer = answer;
    }
}