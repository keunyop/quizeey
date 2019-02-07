package com.questionbank.webservice.service.enums;

import org.apache.commons.lang3.StringUtils;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public enum TestEnum {
    AWS_DEV_ASSOCT("01", "AWS Certified Developer – Associate"),

    AWS_ARCH_ASSOCT("02", "AWS Certified Solutions Architect – Associate"),

    ;

    private String code;
    private String name;

    private TestEnum(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public static TestEnum getByCode(String code) {
        for (TestEnum val : TestEnum.values()) {
            if (StringUtils.equals(code, val.getCode())) {
                return val;
            }
        }

        return null;
    }
}
