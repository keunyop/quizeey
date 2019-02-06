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
    private String testDscd;
    private Long   quizId;

    @Builder
    public QuestionRequestDto(String testDscd, Long quizId) {
        this.testDscd = testDscd;
        this.quizId = quizId;
    }

    public Question toEntity() {
        return Question.builder().testDscd(testDscd).quizId(quizId).questNbr(0).questText(null).explanation(null)
                .reference(null).build();
    }
}