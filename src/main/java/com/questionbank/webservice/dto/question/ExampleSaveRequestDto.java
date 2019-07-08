package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Example;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ExampleSaveRequestDto {
    private Long    testId;
    private int     verNbr;
    private int     questNbr;
    private int     exmpNbr;
    private String  exmpTxt;
    private boolean isAnswer;

    public Example toEntity() {
        return Example.builder().testId(testId).verNbr(verNbr).questNbr(questNbr).exmpNbr(exmpNbr).exmpTxt(exmpTxt)
                .answerYn(isAnswer ? "Y" : "N").build();
    }
}