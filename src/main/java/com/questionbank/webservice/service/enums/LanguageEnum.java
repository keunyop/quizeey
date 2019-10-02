package com.questionbank.webservice.service.enums;

import org.apache.commons.lang3.StringUtils;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public enum LanguageEnum {
    KOR("kor"),

    ENG("eng"),

    ;

    private String code;

    private LanguageEnum(String code) {
        this.code = code;
    }

    public static LanguageEnum getByCode(String code) {
        for (LanguageEnum val : LanguageEnum.values()) {
            if (StringUtils.equals(code, val.getCode())) {
                return val;
            }
        }

        return null;
    }
}