package com.questionbank.webservice.service.enums;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public enum LanguageEnum {
    KOR("kr"),

    ENG("en"),

    ;

    private String code;

    private LanguageEnum(String code) {
	this.code = code;
    }

    public static LanguageEnum getByCode(String code) {
	if (code != null) {
	    for (LanguageEnum val : LanguageEnum.values()) {
		if (code.equalsIgnoreCase(val.getCode())) {
		    return val;
		}
	    }
	}

	return null;
    }
}