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
    private Long   testId;
    private Long   verId;
    private int    questNbr;
    private String questTxt;
    private String explanation;
    private String reference;

    @Builder
    public QuestionSaveRequestDto(Long verId) {
        this.verId = verId;
    }

    public Question toEntity() {
        return Question.builder().testId(testId).verId(verId).questNbr(questNbr).questTxt(questTxt)
                .explanation(explanation).reference(reference).build();
    }
}