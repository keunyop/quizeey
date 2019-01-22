package com.questionbank.webservice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.questionbank.webservice.domain.question.Test;
import com.questionbank.webservice.domain.question.TestRepository;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class TestService {
    private TestRepository testRepository;

    /**
     * 테스트 목록 조회
     */
    public List<Test> getTests() {
        return testRepository.getTestsFromFile();
    }
}
