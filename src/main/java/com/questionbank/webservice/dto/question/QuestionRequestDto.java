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

    @Builder
    public QuestionRequestDto(Long testId, int verNbr) {
        this.testId = testId;
        this.verNbr = verNbr;
    }

    @Override
    public String toString() {
        return "QuestionRequestDto [testId=" + testId + ", verNbr=" + verNbr + "]";
    }
}