package com.questionbank.webservice.domain.question;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class TestRepository {
    public List<Test> getTestsFromFile() {
        List<Test> tests = new ArrayList<>();
        tests.add(Test.builder().groupId("aws").groupName("aws").testId("AWS-Certified-Developer-Associate V13.95.dat")
                .testName("AWS-Certified-Developer-Associate V13.95")
                .testDesc("AWS-Certified-Developer-Associate V13.95").build());

        return tests;
    }
}