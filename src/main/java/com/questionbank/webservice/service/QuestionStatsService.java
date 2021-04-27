package com.questionbank.webservice.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.questionbank.webservice.domain.question.QuestionStats;
import com.questionbank.webservice.domain.question.QuestionStatsRepository;
import com.questionbank.webservice.dto.question.QuestionStatsResponseDto;
import com.questionbank.webservice.dto.question.QuestionStatsSaveRequestDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class QuestionStatsService {
    private QuestionStatsRepository questionStatsRepository;

    @Transactional(readOnly = true)
    public QuestionStatsResponseDto getQuestionStats(Long questId) {
	// 문제 통계 조회
	QuestionStats questionStats = questionStatsRepository.findByQuestId(questId);

	if (questionStats == null) {
	    return new QuestionStatsResponseDto();
	}

	return new QuestionStatsResponseDto(questionStats);
    }

    @Transactional
    public void updateQuestionStats(QuestionStatsSaveRequestDto dto) {
	int correct = 0;
	int inCorrect = 0;

	// 문제 통계 조회
	QuestionStats questionStats = questionStatsRepository.findByQuestId(dto.getQuestId());

	if (questionStats != null) {
	    correct = questionStats.getCorrect();
	    inCorrect = questionStats.getInCorrect();
	}

	if (dto.isCorrect()) {
	    correct++;
	} else {
	    inCorrect++;
	}

	questionStatsRepository.save(dto.toEntity(correct, inCorrect));
    }
}