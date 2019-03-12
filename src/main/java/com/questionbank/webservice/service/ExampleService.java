package com.questionbank.webservice.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.questionbank.webservice.domain.question.ExampleRepository;
import com.questionbank.webservice.dto.question.ExampleSaveRequestDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class ExampleService {
    private ExampleRepository exampleRepository;

    @Transactional
    public Long addExample(ExampleSaveRequestDto dto) {
        return exampleRepository.save(dto.toEntity()).getExmpId();
    }
}