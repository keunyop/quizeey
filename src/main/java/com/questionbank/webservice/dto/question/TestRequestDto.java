package com.questionbank.webservice.dto.question;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestRequestDto {
    private String languageCd;

    @Builder
    public TestRequestDto(String languageCd) {
        this.languageCd = languageCd;
    }
}