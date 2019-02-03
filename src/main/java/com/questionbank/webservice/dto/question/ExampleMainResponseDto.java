package com.questionbank.webservice.dto.question;

import lombok.Getter;

@Getter
public class ExampleMainResponseDto {
    private Long    exmpId;
    private Long    questId;
    private int     exmpNbr;
    private String  exampleText;
    private boolean answer;
}
