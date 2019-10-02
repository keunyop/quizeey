package com.questionbank.webservice.dto.question;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestResponseDto {
    private Long   testId;
    private String testNm;
    private String url;

    @Builder
    public TestResponseDto(Long testId, String testNm, String url) {
        this.testId = testId;
        this.testNm = testNm;
        this.url = url;
    }

}