package com.questionbank.webservice.service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.questionbank.webservice.domain.question.Explanation;
import com.questionbank.webservice.domain.question.ExplanationRepository;
import com.questionbank.webservice.dto.question.ExplanationRequestDto;
import com.questionbank.webservice.dto.question.ExplanationResponseDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class ExplanationService {
    private ExplanationRepository explanationRepository;

    @Transactional(readOnly = true)
    public List<ExplanationResponseDto> getExplanations(Long questId) {
        // 문제 설명 목록 조회
        Stream<Explanation> explanations = explanationRepository.getExplanationsByQuestId(questId);
        return explanations.map(ExplanationResponseDto::new).collect(Collectors.toList());
    }

    @Transactional
    public void addExplanation(ExplanationRequestDto dto) {
        explanationRepository.save(dto.toEntity());
    }
}