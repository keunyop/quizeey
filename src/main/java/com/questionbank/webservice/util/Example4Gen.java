package com.questionbank.webservice.util;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Example4Gen {
    private String exmpNbr;
    private String exampleStr;
    private String answerYn;

    @Builder
    public Example4Gen(String exmpNbr, String exampleStr, String answerYn) {
        this.exmpNbr = exmpNbr;
        this.exampleStr = exampleStr;
        this.answerYn = answerYn;
    }

}
