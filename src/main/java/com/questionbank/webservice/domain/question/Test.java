package com.questionbank.webservice.domain.question;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class Test {
    private String groupId;
    private String groupName;
    private String testId;
    private String testName;
    private String testDesc;

    @Builder
    public Test(String groupId, String groupName, String testId, String testName, String testDesc) {
        this.groupId = groupId;
        this.groupName = groupName;
        this.testId = testId;
        this.testName = testName;
        this.testDesc = testDesc;
    }
}