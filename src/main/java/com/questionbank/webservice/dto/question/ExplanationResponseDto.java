package com.questionbank.webservice.dto.question;

import java.time.format.DateTimeFormatter;

import com.questionbank.webservice.domain.question.Explanation;

import lombok.Getter;

@Getter
public class ExplanationResponseDto {
    private String userNm;
    private String explanation;
    private String createdDate;

    public ExplanationResponseDto(Explanation expl) {
        this.userNm = expl.getUserNm();
        this.explanation = expl.getExplanation();
        this.createdDate = expl.getCreatedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}
