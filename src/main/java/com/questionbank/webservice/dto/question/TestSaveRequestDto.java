package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Test;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestSaveRequestDto {
    private Long   testId;
    private String testNm;

    @Builder
    public TestSaveRequestDto(String testNm) {
        this.testNm = testNm;
    }

    public Test toEntity() {
        return Test.builder().testId(testId).testNm(testNm).build();
    }

}