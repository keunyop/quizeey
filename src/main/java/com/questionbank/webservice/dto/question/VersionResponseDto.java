package com.questionbank.webservice.dto.question;

import com.questionbank.webservice.domain.question.Version;

import lombok.Getter;

@Getter
public class VersionResponseDto {
    private Long   verId;
    private String verNm;

    public VersionResponseDto(Version ver) {
        this.verId = ver.getVerId();
        this.verNm = ver.getVerNm();
    }
}
