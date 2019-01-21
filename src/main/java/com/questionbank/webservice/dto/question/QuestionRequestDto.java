package com.questionbank.webservice.dto.question;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class QuestionRequestDto {
    private String questionId;

    @Builder
    public QuestionRequestDto(String questionId) {
        this.questionId = questionId;
    }
}
