package com.questionbank.webservice.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.domain.question.QuestionRepository;
import com.questionbank.webservice.dto.question.QuestionRequestDto;
import com.questionbank.webservice.dto.question.QuestionSaveRequestDto;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class QuestionService {
    private QuestionRepository questionRepository;

    //    /**
    //     *  문제목록 조회
    //     */
    //    public Question getRandomQuestion(String questionId) {
    //        List<Question> questions = questionRepository.getQuestionsFromFile(questionId);
    //
    //        return questions.get(_getRandomNumber(questions.size()));
    //    }
    //
    //    /**
    //     * Generate Random Number
    //     * @return
    //     */
    //    private int _getRandomNumber(int n) {
    //        Random random = new Random();
    //        return random.nextInt(n);
    //    }

    @Transactional
    public Long addQuestion(QuestionSaveRequestDto dto) {
        return questionRepository.save(dto.toEntity()).getQuestId();
    }

    @Transactional(readOnly = true)
    public Question getQuestion(QuestionRequestDto dto) {
        return null;
    }
}
