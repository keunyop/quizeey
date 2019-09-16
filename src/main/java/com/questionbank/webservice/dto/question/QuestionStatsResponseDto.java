package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.QuestionStats;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
public class QuestionStatsResponseDto {
    private Long questId;
    private int  correct;
    private int  inCorrect;

    public QuestionStatsResponseDto(QuestionStats qs) {
        this.questId = qs.getQuestId();
        this.correct = qs.getCorrect();
        this.inCorrect = qs.getInCorrect();
    }
}