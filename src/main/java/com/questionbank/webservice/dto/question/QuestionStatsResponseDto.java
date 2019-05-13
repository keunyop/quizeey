package com.questionbank.webservice.dto.question;

import lombok.Getter;

@Getter
public class QuestionStatsResponseDto {
    private Long questId;
    private int  correct;
    private int  inCorrect;
}