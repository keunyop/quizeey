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
    private Long quizId;

    @Builder
    public QuestionRequestDto(Long quizId) {
        this.quizId = quizId;
    }

    public Question toEntity() {
        return Question.builder().testDscd(null).quizId(quizId).questNbr(0).questText(null).explanation(null)
                .reference(null).build();
    }
}