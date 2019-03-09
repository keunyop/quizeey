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
    private Long    testId;
    private int     verNbr;
    private int     questNbr;
    private String  questTxt;
    private String  explanation;
    private String  reference;
    private boolean isMultiAnswer;

    @Builder
    public QuestionSaveRequestDto(int verNbr) {
        this.verNbr = verNbr;
    }

    public Question toEntity() {
        return Question.builder().testId(testId).verNbr(verNbr).questNbr(questNbr).questTxt(questTxt)
                .explanation(explanation).reference(reference).isMultiAnswer(isMultiAnswer).build();
    }
}