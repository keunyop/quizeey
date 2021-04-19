package com.questionbank.webservice.service.enums;

import org.apache.commons.lang3.StringUtils;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public enum TestEnum {
    AWS_DEV_ASSOCT("1", "AWS Certified Developer – Associate", "AWS 공인 개발자 - 어소시에이트"),

    SQLP("2", "SQLP - SQL Professional", "SQLP - 국가공인 SQL전문가"),

    CS("4", "Computer Science", "컴퓨터 공학"),

    SQLD("5", "SQLD - SQL Developer", "SQLD - 국가공인 SQL개발자"),

    ENGR_INFO_PROC("6", "Engineer Information Processing", "정보처리기사"),

    ENGR_TRANSPORTATION("7", "Engineer Transpertation", "교통기사"),

    ;

    private String code;
    private String engName;
    private String korName;

    private TestEnum(String code, String engName, String korName) {
	this.code = code;
	this.engName = engName;
	this.korName = korName;
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
