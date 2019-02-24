package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Example;

import lombok.Getter;

@Getter
public class ExampleMainResponseDto {
    private Long    exmpId;
    private Long    testId;
    private int     verNbr;
    private int     questNbr;
    private int     exmpNbr;
    private String  exmpTxt;
    private boolean answer;

    public ExampleMainResponseDto(Example example) {
        this.exmpId = example.getExmpId();
        this.testId = example.getTestId();
        this.verNbr = example.getVerNbr();
        this.questNbr = example.getQuestNbr();
        this.exmpNbr = example.getExmpNbr();
        this.exmpTxt = example.getExmpTxt();
        this.answer = example.isAnswer();
    }

    @Override
    public String toString() {
        return "ExampleMainResponseDto [exmpId=" + exmpId + ", testId=" + testId + ", verNbr=" + verNbr + ", questNbr="
                + questNbr + ", exmpNbr=" + exmpNbr + ", exmpTxt=" + exmpTxt + ", answer=" + answer + "]";
    }
}