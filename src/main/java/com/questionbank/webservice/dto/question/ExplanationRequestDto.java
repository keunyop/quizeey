package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Explanation;

import lombok.Getter;

@Getter
public class ExplanationRequestDto {
    private Long   questId;
    private String userNm;
    private String explanation;

    public Explanation toEntity() {
        return Explanation.builder().questId(questId).userNm(userNm).explanation(explanation).build();
    }
}
