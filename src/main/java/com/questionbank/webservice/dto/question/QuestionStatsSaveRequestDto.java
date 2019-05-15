package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.QuestionStats;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class QuestionStatsSaveRequestDto {
    private Long    questId;
    private boolean isCorrect;

    public QuestionStats toEntity(int correct, int incorrect) {
        return QuestionStats.builder().questId(questId).correct(correct).inCorrect(incorrect).build();
    }
}