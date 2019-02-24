package com.questionbank.webservice.service;

import java.util.List;
import java.util.Random;
import java.util.stream.Stream;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.questionbank.webservice.domain.question.Example;
import com.questionbank.webservice.domain.question.ExampleRepository;
import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.domain.question.QuestionRepository;
import com.questionbank.webservice.dto.question.QuestionMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;
import com.questionbank.webservice.dto.question.QuestionSaveRequestDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class QuestionService {
    private QuestionRepository questionRepository;
    private ExampleRepository  exampleRepository;

    @Transactional
    public Long addQuestion(QuestionSaveRequestDto dto) {
        return questionRepository.save(dto.toEntity()).getQuestId();
    }

    @Transactional(readOnly = true)
    public QuestionMainResponseDto getQuestion(QuestionRequestDto dto) {
        // 문제 조회
        Question qeustion = _getQuestion(dto.getTestId(), dto.getVerNbr());

        // 보기 조회
        Stream<Example> examples = exampleRepository.findByTestIdAndVerNbrAndQuestNbr(qeustion.getTestId(),
                qeustion.getVerNbr(), qeustion.getQuestNbr());

        return new QuestionMainResponseDto(qeustion, examples);
    }

    // 문제 조회
    private Question _getQuestion(Long testId, int verNbr) {
        // verNbr가 있으면 해당 version 문제 조회
        // verNbr가 없으면 test 전체에서 문제 조회
        List<Question> questions = (verNbr == 0) ? questionRepository.getQuestionsByTestId(testId)
                : questionRepository.getQuestionsByTestIdAndVerNbr(testId, verNbr);

        return questions.get(_generateRandomNumber(questions.size()));
    }

    /**
     * Generate Random Number
     */
    private int _generateRandomNumber(int n) {
        Random random = new Random();
        return random.nextInt(n);
    }
}