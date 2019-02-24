package com.questionbank.webservice.dto.question;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class VersionRequestDto {
    private Long testId;

    @Builder
    public VersionRequestDto(Long testId) {
        this.testId = testId;
    }
}
