package com.questionbank.webservice.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.questionbank.webservice.domain.question.Test;
import com.questionbank.webservice.domain.question.TestRepository;
import com.questionbank.webservice.dto.question.TestResponseDto;
import com.questionbank.webservice.service.enums.LanguageEnum;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class TestService {
    private TestRepository testRepository;

    public List<TestResponseDto> getTests(String languageCd) {

        List<TestResponseDto> testDtos = new ArrayList<>();

        List<Test> tests;

        if (LanguageEnum.KOR.getCode().equals(languageCd)) {
            tests = testRepository.findByTestNmNotNullOrderByInqrSeq();
        } else {
            tests = testRepository.findByTestNmEngNotNullOrderByInqrSeq();

            for (Test test : tests) {
                test.setTestNm(test.getTestNmEng());
            }
        }

        for (Test test : tests) {
            testDtos.add(TestResponseDto.builder().testId(test.getTestId()).testNm(test.getTestNm()).url(test.getUrl())
                    .build());
        }

        return testDtos;
    }

    public List<Test> getAllTests() {
        return testRepository.findAll();
    }
}
