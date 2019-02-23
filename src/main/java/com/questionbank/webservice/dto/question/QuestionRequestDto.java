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
    private Long verId;

    @Builder
    public QuestionRequestDto(Long testId, Long verId) {
        this.testId = testId;
        this.verId = verId;
    }

    public Question toEntity() {
        return Question.builder().testId(testId).verId(verId).questNbr(0).questTxt(null).explanation(null)
                .reference(null).build();
    }
}