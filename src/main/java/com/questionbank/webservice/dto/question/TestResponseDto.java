package com.questionbank.webservice.dto.question;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestResponseDto {
    private Long   testId;
    private String testNm;
    private String testNmEng;
    private int    inqrSeq;

}