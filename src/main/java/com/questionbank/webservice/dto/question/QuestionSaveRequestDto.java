package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Question;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuestionSaveRequestDto {
    private String testDscd;
    private Long   quizId;
    private int    questNbr;
    private String questText;
    private String explanation;
    private String reference;

    @Builder
    public QuestionSaveRequestDto(Long quizId) {
        this.quizId = quizId;
    }

    public Question toEntity() {
        return Question.builder().testDscd(testDscd).quizId(quizId).questNbr(questNbr).questText(questText)
                .explanation(explanation).reference(reference).build();
    }
}