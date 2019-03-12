package com.questionbank.webservice.service.enums;

import org.apache.commons.lang3.StringUtils;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public enum TestEnum {
    AWS_DEV_ASSOCT("1", "AWS Certified Developer – Associate"),

    SQLP("2", "SQLP - 국가공인 SQL전문가"),

    CBP_BASIC("3", "CBP Certification - Basic Developer"),

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
