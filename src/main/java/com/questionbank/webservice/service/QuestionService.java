package com.questionbank.webservice.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.questionbank.webservice.domain.question.Example;
import com.questionbank.webservice.domain.question.ExampleRepository;
import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.domain.question.QuestionRepository;
import com.questionbank.webservice.domain.question.Version;
import com.questionbank.webservice.domain.question.VersionRepository;
import com.questionbank.webservice.dto.question.QuestionMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;
import com.questionbank.webservice.dto.question.QuestionSaveRequestDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class QuestionService {
    static Map<String, List<Question>> QUESTIONS_CACHE = new HashMap<>();

    private QuestionRepository         questionRepository;
    private ExampleRepository          exampleRepository;
    private VersionRepository          versionRepository;

    @Transactional
    public Long addQuestion(QuestionSaveRequestDto dto) {
        return questionRepository.save(dto.toEntity()).getQuestId();
    }

    @Transactional(readOnly = true)
    public QuestionMainResponseDto getQuestion(QuestionRequestDto dto) {
        // 문제 조회
        Question qeustion = _getQuestion(dto);

        // 보기 조회
        List<Example> examples = exampleRepository.findByTestIdAndVerNbrAndQuestNbr(qeustion.getTestId(),
                qeustion.getVerNbr(), qeustion.getQuestNbr());

        // 보기 셔플
        Collections.shuffle(examples);

        return new QuestionMainResponseDto(qeustion, examples, _getVersionName(qeustion));
    }

    /**
     * 문제 조회
     */
    private Question _getQuestion(QuestionRequestDto dto) {
        Question question = null;

        // 특정 문제 번호가 없으면 random 문제 조회
        if (dto.getQuestId() == null) {
            // Cache 키
            String cacheKey = "T" + dto.getTestId() + "V" + dto.getVerNbr();

            // Cache 조회
            List<Question> questions = QUESTIONS_CACHE.get(cacheKey);

            // Cache miss
            if (CollectionUtils.isEmpty(questions)) {
                // verNbr가 있으면 해당 version 문제 조회
                // verNbr가 없으면 test 전체에서 문제 조회
                questions = (dto.getVerNbr() == 0) ? questionRepository.getQuestionsByTestId(dto.getTestId())
                        : questionRepository.getQuestionsByTestIdAndVerNbr(dto.getTestId(), dto.getVerNbr());

                // Cache 저장
                QUESTIONS_CACHE.put(cacheKey, questions);
            }

            question = questions.get(_generateRandomNumber(questions.size()));

        } else {
            question = questionRepository.findOne(dto.getQuestId());
        }

        return question;
    }

    /**
     * Generate Random Number
     */
    private int _generateRandomNumber(int n) {
        Random random = new Random();
        return random.nextInt(n);
    }

    /**
     * Get Version Name
     */
    private String _getVersionName(Question qeustion) {
        Version version = versionRepository.getVersionByTestIdAndVerNbr(qeustion.getTestId(), qeustion.getVerNbr());

        if (version != null) {
            return version.getVerNm();
        }

        return null;
    }

    public void clearCache() {
        System.out.println("Cache: " + QUESTIONS_CACHE.size());

        QUESTIONS_CACHE.clear();

        System.out.println("Clear Cache Size: " + QUESTIONS_CACHE.size());
    }
}