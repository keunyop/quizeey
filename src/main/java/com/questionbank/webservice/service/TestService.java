package com.questionbank.webservice.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.questionbank.webservice.domain.question.TestRepository;
import com.questionbank.webservice.dto.question.TestSaveRequestDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class TestService {
    private TestRepository testRepository;

    @Transactional
    public Long addTest(TestSaveRequestDto dto) {
        return testRepository.save(dto.toEntity()).getTestId();
    }
}
