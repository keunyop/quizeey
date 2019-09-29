package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Explanation;

import lombok.Getter;

@Getter
public class ExplanationResponseDto {
    private String userNm;
    private String explanation;

    public ExplanationResponseDto(Explanation expl) {
        this.userNm = expl.getUserNm();
        this.explanation = expl.getExplanation();
    }
}
