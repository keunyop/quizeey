package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Question;

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

    public Question toEntity() {
        return Question.builder().testId(testId).verNbr(verNbr).questNbr(0).questTxt(null).explanation(null)
                .reference(null).build();
    }

    @Override
    public String toString() {
        return "QuestionRequestDto [testId=" + testId + ", verNbr=" + verNbr + "]";
    }
}