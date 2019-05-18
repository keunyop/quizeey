package com.questionbank.webservice.dto.question;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuestionRequestDto {
    private Long testId;
    private int  verNbr;
    private Long questId;

    @Builder
    public QuestionRequestDto(Long testId, int verNbr, Long questId) {
        this.testId = testId;
        this.verNbr = verNbr;
        this.questId = questId;
    }
}