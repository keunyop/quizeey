package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Example;

import lombok.Getter;

@Getter
public class ExampleMainResponseDto {
    private Long    exmpId;
    private Long    questId;
    private int     exmpNbr;
    private String  exampleText;
    private boolean answer;

    public ExampleMainResponseDto(Example example) {
        this.exmpId = example.getExmpId();
        this.questId = example.getQuestId();
        this.exmpNbr = example.getExmpNbr();
        this.exampleText = example.getExampleText();
        this.answer = example.isAnswer();
    }

    @Override
    public String toString() {
        return "ExampleMainResponseDto [exmpId=" + exmpId + ", questId=" + questId + ", exmpNbr=" + exmpNbr
                + ", exampleText=" + exampleText + ", answer=" + answer + "]";
    }
}