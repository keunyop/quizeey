package com.questionbank.webservice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.questionbank.webservice.domain.question.TestRepository;
import com.questionbank.webservice.dto.question.TestResponseDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class TestService {
    private TestRepository testRepository;

    public List<TestResponseDto> getTests(String languageCd) {
        return null;
    }
}
